#!/bin/bash
# @author: Vsevolod Ivanov <seva@binarytrails.net>

# Default values
OUTPUT_FILE="extracted_hashes.txt"
HASH_TYPE_FILE="hash_types.txt"
WORDLIST=""
EXTRA_PARAMS=""
DB_FILES=()
TAR_FILES=()

# Function to display usage
usage() {
    echo "Usage: $0 (-d <db_file1> [<db_file2> ...] | -t <tar_file1> [<tar_file2> ...]) -w <wordlist> [--extra <hashcat_args>]"
    exit 1
}

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -d) shift; while [[ $# -gt 0 && "$1" != -* ]]; do DB_FILES+=("$1"); shift; done ;;
        -t) shift; while [[ $# -gt 0 && "$1" != -* ]]; do TAR_FILES+=("$1"); shift; done ;;
        -w) shift; [[ $# -gt 0 && "$1" != -* ]] && WORDLIST="$1" || usage; shift ;;
        --extra) shift; [[ $# -gt 0 && "$1" != -* ]] && EXTRA_PARAMS="$1" || usage; shift ;;
        *) echo "[!] Unknown option: $1"; usage ;;
    esac
done

# Validate inputs
[[ ${#DB_FILES[@]} -eq 0 && ${#TAR_FILES[@]} -eq 0 ]] && echo "[!] Error: At least one database or archive required." && usage
[[ -z "$WORDLIST" || ! -f "$WORDLIST" ]] && echo "[!] Error: Valid wordlist file required." && exit 1

# Extract tar.gz archives
EXTRACTED_DB_FILES=()
TMP_DIR=$(mktemp -d)
if [[ ${#TAR_FILES[@]} -gt 0 ]]; then
    echo "[+] Extracting .tar.gz files..."
    for TAR_FILE in "${TAR_FILES[@]}"; do
        tar -xzvf "$TAR_FILE" -C "$TMP_DIR" >/dev/null 2>&1
        EXTRACTED_DB_FILES+=($(find "$TMP_DIR" -type f -name "*.db"))
    done
fi

# Combine extracted and provided DB files
ALL_DB_FILES=("${DB_FILES[@]}" "${EXTRACTED_DB_FILES[@]}")

# Clear previous outputs
> "$OUTPUT_FILE"
> "$HASH_TYPE_FILE"

echo "[+] Extracting hashes from database files..."

# Define suspected credential tables
CRED_TABLES=("AdminUser" "UserAuth" "APIKey" "AppCredential" "Credential" "DatabaseCredential"
             "SSHCredential" "WindowsCredential" "LDAP" "AppSSHCredential"
)

# Process each database file
for DB_FILE in "${ALL_DB_FILES[@]}"; do
    echo "Processing: $DB_FILE"

    # List tables
    TABLES=$(sqlite3 "$DB_FILE" ".tables")

    for TABLE in $TABLES; do
        if [[ " ${CRED_TABLES[*]} " =~ " ${TABLE} " ]]; then
            echo "[*] Checking table: $TABLE"

            # Try extracting specific column names (if available)
            COLUMNS=$(sqlite3 "$DB_FILE" "PRAGMA table_info($TABLE);" | awk -F'|' '{print $2}')

            for COLUMN in $COLUMNS; do
                # Extract potential hash values
                HASHES=$(sqlite3 "$DB_FILE" "SELECT $COLUMN FROM $TABLE;" | grep -Eo '[a-fA-F0-9]{32,}')

                if [[ ! -z "$HASHES" ]]; then
                    while read -r HASH; do
                        echo "$DB_FILE -> $TABLE -> $COLUMN -> $HASH" >> "$OUTPUT_FILE"
                        echo "[+] Found hash in $DB_FILE -> $TABLE -> $COLUMN"
                    done <<< "$HASHES"
                fi
            done
        fi
    done
done

[[ ! -s "$OUTPUT_FILE" ]] && echo "[!] No hashes found." && exit 1
echo "[+] Identifying hash types..."

while IFS=" -> " read -r DB TABLE COLUMN HASH; do
    # Skip APIKey entries
    if [[ "$COLUMN" == "APIKey" ]]; then
        echo "[!] Skipping APIKey entry from: $DB -> $TABLE -> $COLUMN"
        continue
    fi

    # Extract clean hash
    CLEAN_HASH=$(echo "$HASH" | awk -F ' -> ' '{print $NF}' | tr -d '[:space:]')

    echo "[*] Processing Hash from: $DB -> $TABLE -> $COLUMN"
    echo "[*] Hash: $CLEAN_HASH"

    # Identify hash type
    TYPE_OUTPUT=$(hashid -m "$CLEAN_HASH" 2>/dev/null)
    HASH_MODE=$(echo "$TYPE_OUTPUT" | grep -oE 'Hashcat Mode: [0-9]+' | awk '{print $3}' | head -n 1)

    if [[ -z "$HASH_MODE" ]]; then
        echo "[!] No valid Hashcat mode detected for this hash."
    else
        echo "[+] Using Hashcat Mode: $HASH_MODE"

        # Generate Hashcat command
        HASH_FILE="hashes_$HASH_MODE.txt"
        echo "$CLEAN_HASH" >> "$HASH_FILE"

        #COMMAND="hashcat -m $HASH_MODE $HASH_FILE /path/to/rockyou.txt --force"
        COMMAND="hashcat -m "$HASH_MODE" $HASH_FILE "$WORDLIST" $EXTRA_PARAMS --force"

        echo "[#] Run: $COMMAND"
        echo "$COMMAND" >> hashcat_commands.sh
    fi
done < "$OUTPUT_FILE"

echo "[+] All Hashcat commands written to hashcat_commands.sh"
chmod +x hashcat_commands.sh

#echo "[+] Cracking hashes with Hashcat..."
#while IFS=" -> " read -r DB TABLE COLUMN HASH HASH_TYPE; do
#    if [[ "$HASH_TYPE" != "Unknown" ]]; then
#        echo "Cracking $HASH (Type: $HASH_TYPE)..."
#        hashcat -m "$HASH_TYPE" -a 0 <(echo "$HASH") "$WORDLIST" $EXTRA_PARAMS --force &
#    else
#        echo "Skipping $HASH (Unknown type)"
#    fi
#done < "$HASH_TYPE_FILE"
#
#wait  # Ensure all Hashcat jobs complete
#rm -rf "$TMP_DIR"
#
#echo "[+] Process complete!"
