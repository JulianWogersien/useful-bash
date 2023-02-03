#!/bin/sh
touch "$(pwd)/.vimspector.json"
echo "
{
  \"configurations\": {
    \"launch\": {
      \"adapter\": \"CodeLLDB\",
      \"filetypes\": [ \"rust\" ],
      \"configuration\": {
        \"request\": \"launch\",
        \"program\": \"\${workspaceRoot}/target/debug/app\"
      }
    }
  }
}
" >> "$(pwd)/.vimspector.json"
