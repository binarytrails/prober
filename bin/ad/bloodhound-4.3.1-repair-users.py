import json
from json_repair import repair_json

input_file = "19820102030405_users.json"
output_file = "19820102030405__users_fixed.json"

with open(input_file, "r") as f:
    broken_content = f.read()

# 1. Perform the structural repair
repaired_str = repair_json(broken_content)

# 2. Parse into a Python dict to manipulate the schema
data_obj = json.loads(repaired_str)

# 3. Standardize for BloodHound 4.3 (Legacy)
# We ensure the 'data' key exists and force the 'meta' block
final_output = {
    "data": data_obj.get("data", []),
    "meta": {
        "type": "users",
        "count": len(data_obj.get("data", [])),
        "version": 4,
        "methods": 0
    }
}

# 4. Write to file (compact formatting is usually safer for BH)
with open(output_file, "w") as f:
    json.dump(final_output, f, separators=(',', ':'))

print(f"Successfully repaired and converted {input_file} to {output_file}")
