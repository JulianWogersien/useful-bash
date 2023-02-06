#!/bin/sh
name="$2"
lang="$1"
adapter="none"
filetypes="none"
build_dir="\${workspaceRoot}/src/$name"

if [ "$lang" = "c++" ]; then
    adapter="CodeLLDB"
    filetypes="[ \"cpp\" \"c++\" \"c\" \"h\" \"hpp\" \"cxx\" ]"
elif [ "$lang" = "c" ]; then 
    adapter="CodeLLDB"
    filetypes="[ \"c\" \"h\" ]"
elif [ "$lang" = "rust" ]; then
    adapter="CodeLLDB"
    filetypes="[ \"rust\" ]"
    build_dir="\${workspaceRoot}/target/debug/app"
elif [ "$lang" = "python" ]; then
    adapter="debugpy"
    filetypes="[ \"rs\", \"rust\" ]"
elif [ "$lang" = "bash" ]; then
    adapter="vscode-bash-debug"
    filetypes="[ \"bash\" \"sh\"]"
elif [ "$lang" = "lua" ]; then
    adapter="local-lua-debugger-vscode"
    filetypes="[ \"lua\" ]"
elif [ "$lang" = "node" ]; then
    adapter="vscode-node-debug2"
    filetypes="[ \"js\" \"javascript\" ]"
elif [ "$lang" = "javascript" ]; then
    adapter="vscode-firefox-debug"
    filetypes="[ \"js\" \"javascript\" ]"
elif [ "$lang" = "java" ]; then
    adapter="vscode-java-debug"
    filetypes="[ \"java\" ]"
elif [ "$lang" = "php" ]; then
    adapter="vscode-php-debug"
    filetypes="[ \"php\" ]"
elif [ "$lang" = "c#" ]; then
    adapter="netcoredbg"
    filetypes="[ \"cs\" ]"
elif [ "$lang" = "f#" ]; then
    adapter="netcoredbg"
    filetypes="[ \"fs\" ]"
elif [ "$lang" = "vb" ]; then
    adapter="netcoredbg"
    filetypes="[ \"vb\" ]"
fi

touch "$(pwd)/.vimspector.json"
echo "
{
  \"configurations\": {
    \"launch\": {
      \"adapter\": \"$adapter\",
      \"filetypes\": \"$filetypes\",
      \"configuration\": {
        \"request\": \"launch\",
        \"program\": \"$build_dir\"
      }
    }
  }
}
" >> "$(pwd)/.vimspector.json"
