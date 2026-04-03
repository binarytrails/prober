import json
import argparse
import sys
from pathlib import Path
from json_repair import repair_json

def main():
    parser = argparse.ArgumentParser(description="Repair and format BloodHound JSON files for legacy ingestion.")
    
    # File Arguments
    parser.add_argument("-i", "--input", required=True, help="Path to the broken JSON file")
    parser.add_argument("-o", "--output", required=True, help="Path for the repaired output file")
    
    # Type Arguments (Mutually Exclusive)
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument("--users", action="store_true", help="Set metadata type to 'users'")
    group.add_argument("--computers", action="store_true", help="Set metadata type to 'computers'")

    args = parser.parse_args()

    # Determine type string
    bh_type = "users" if args.users else "computers"
    
    input_path = Path(args.input)
    if not input_path.exists():
        print(f"[-] Error: Input file '{args.input}' not found.")
        sys.exit(1)

    print(f"[*] Repairing {input_path} as type: {bh_type}...")

    try:
        with open(input_path, "r", encoding="utf-8", errors="ignore") as f:
            broken_content = f.read()

        # 1. Structural Repair
        repaired_str = repair_json(broken_content)
        data_obj = json.loads(repaired_str)

        # 2. Normalize the data list
        # Handles cases where data is already a list or nested in a 'data' key
        raw_list = data_obj if isinstance(data_obj, list) else data_obj.get("data", [])

        # 3. Construct Legacy BloodHound 4.3 Schema
        final_output = {
            "data": raw_list,
            "meta": {
                "methods": 0,
                "type": bh_type,
                "count": len(raw_list),
                "version": 4
            }
        }

        # 4. Write to file
        with open(args.output, "w", encoding="utf-8") as f:
            json.dump(final_output, f, separators=(',', ':'))

        print(f"[+] Success! Saved {len(raw_list)} objects to {args.output}")

    except Exception as e:
        print(f"[-] An unexpected error occurred: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
