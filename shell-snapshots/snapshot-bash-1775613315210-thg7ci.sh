# Snapshot file
# Unset all aliases to avoid conflicts with functions
unalias -a 2>/dev/null || true
shopt -s expand_aliases
# Check for rg availability
if ! (unalias rg 2>/dev/null; command -v rg) >/dev/null 2>&1; then
  function rg {
  local _cc_bin="${CLAUDE_CODE_EXECPATH:-}"
  [[ -x $_cc_bin ]] || _cc_bin=$(command -v claude 2>/dev/null)
  if [[ ! -x $_cc_bin ]]; then command rg "$@"; return; fi
  if [[ -n $ZSH_VERSION ]]; then
    ARGV0=rg "$_cc_bin" "$@"
  elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "win32" ]]; then
    ARGV0=rg "$_cc_bin" "$@"
  elif [[ $BASHPID != $$ ]]; then
    exec -a rg "$_cc_bin" "$@"
  else
    (exec -a rg "$_cc_bin" "$@")
  fi
}
fi
export PATH='/c/Users/corea/bin:/mingw64/bin:/usr/local/bin:/usr/bin:/bin:/mingw64/bin:/usr/bin:/c/Users/corea/bin:/c/Users/corea/AppData/Local/Programs/cursor/resources/app/bin:/c/WINDOWS/system32:/c/WINDOWS:/c/WINDOWS/System32/Wbem:/c/WINDOWS/System32/WindowsPowerShell/v1.0:/c/WINDOWS/System32/OpenSSH:/c/Program Files/jdk-1.8.0_252/bin:/c/Program Files/PuTTY:/c/Program Files/dotnet:/cmd:/c/Users/corea/AppData/Local/Microsoft/WindowsApps:/c/Users/corea/AppData/Local/Programs/EmEditor:/d/Program Files/JetBrains/DataGrip 2024.1.1/bin:/c/Program Files/JetBrains/IntelliJ IDEA 2024.2.3/bin:/c/WINDOWS/system32:/c/WINDOWS:/c/WINDOWS/System32/Wbem:/c/WINDOWS/System32/WindowsPowerShell/v1.0:/c/WINDOWS/System32/OpenSSH:/c/Program Files/WezTerm:/c/Program Files/nodejs:/c/Users/corea/AppData/Local/Microsoft/WindowsApps:/d/app/openjdk-26_windows-x64_bin/bin:/c/Users/corea/AppData/Local/Programs/EmEditor:/c/Program Files/JetBrains/DataGrip 2025.3.3/bin:/c/Program Files/JetBrains/IntelliJ IDEA 2024.2.3/bin:/c/Users/corea/AppData/Local/Programs/Microsoft VS Code/bin:/d/Users/corea/AppData/Local/Programs/Kiro/bin:/c/Users/corea/AppData/Roaming/npm:/c/Users/corea/.local/bin:/c/Users/corea/AppData/Local/Programs/cursor/resources/app/bin:/d/Users/corea/AppData/Local/Programs/Antigravity/bin:/usr/bin/vendor_perl:/usr/bin/core_perl'
