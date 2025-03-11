import sys

# How This Works
#     Encodes the EXE into shellcode.h.
#     Decodes shellcode.h back into decoded.exe.
#     Verifies that the original EXE matches decoded.exe.

def exe_to_header(input_file, header_file="shellcode.h"):
    with open(input_file, "rb") as f:
        exe_bytes = f.read()

    # Convert binary data to C-style shellcode format
    shellcode = ''.join(f"\\x{b:02x}" for b in exe_bytes)

    # Format shellcode into multiple lines (16 bytes per line for readability)
    formatted_shellcode = 'unsigned char shellcode[] =\n'
    for i in range(0, len(shellcode), 64):  # 64 chars = 16 bytes per line
        formatted_shellcode += f'\t\t"{shellcode[i:i+64]}"\n'
    formatted_shellcode += ";\n"

    # Write to .h file
    with open(header_file, "w") as f:
        f.write(f"#ifndef SHELLCODE_H\n#define SHELLCODE_H\n\n")
        f.write(formatted_shellcode)
        f.write("\n#endif // SHELLCODE_H\n")

    print(f"Generated {header_file}")

def decode_header_to_exe(header_file="shellcode.h", output_file="decoded.exe"):
    with open(header_file, "r") as f:
        lines = f.readlines()

    shellcode = ""
    recording = False

    for line in lines:
        line = line.strip()
        if "unsigned char shellcode" in line:
            recording = True
            continue
        if recording:
            if line.startswith("#endif"):
                break
            shellcode += line.strip('";')

    # Convert shellcode back to binary
    exe_bytes = bytes.fromhex(shellcode.replace("\\x", ""))
    
    with open(output_file, "wb") as f:
        f.write(exe_bytes)

    print(f"Decoded shellcode back to {output_file}")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py <exe_file>", file=sys.stderr)
        sys.exit(1)

    input_exe = sys.argv[1]
    exe_to_header(input_exe)  # Encode EXE into header
    decode_header_to_exe()    # Decode header back into EXE

    # Compare files to check if encoding/decoding was successful
    with open(input_exe, "rb") as f1, open("decoded.exe", "rb") as f2:
        if f1.read() == f2.read():
            print("Success: Encoded and decoded files match!")
        else:
            print("Error: Encoded and decoded files do NOT match!")
