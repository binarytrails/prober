import sys

# How This Works
#     Encodes the EXE into shellcode.h and prints the file.
#     Include it with: #include "sc_file.h"

def exe_to_header(input_file):
    with open(input_file, "rb") as f:
        exe_bytes = f.read()

    # Convert binary data to C-style shellcode format
    shellcode = ''.join(f"\\x{b:02x}" for b in exe_bytes)

    # Format shellcode into multiple lines (16 bytes per line for readability)
    formatted_shellcode = 'unsigned char shellcode[] =\n'
    for i in range(0, len(shellcode), 64):  # 64 chars = 16 bytes per line
        formatted_shellcode += f'\t\t"{shellcode[i:i+64]}"\n'
    formatted_shellcode += ";\n"

    # Print the complete header content
    print("#ifndef SHELLCODE_H")
    print("#define SHELLCODE_H\n")
    print(formatted_shellcode)
    print("#endif // SHELLCODE_H")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py <exe_file>", file=sys.stderr)
        sys.exit(1)

    exe_to_header(sys.argv[1])
