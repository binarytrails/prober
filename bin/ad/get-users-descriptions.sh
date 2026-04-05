cat users.json | jq '.data[] | select(.Properties.description != null) | {name: .Properties.name, description: .Properties.description}'
