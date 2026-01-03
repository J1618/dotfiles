using namespace System.Management.Automation
using namespace System.Management.Automation.Language

# --- 1. Imports ---
Import-Module -Name Terminal-Icons
Import-Module z

# --- 2. Aliases ---
set-alias desktop "Desktop.ps1"

# --- 3. Search History with Arrows ---
# Type "git" then press UpArrow to see only your past git commands
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# --- 4. The "Magic" Setup (Inline + Right Arrow) ---
# We use InlineView (Ghost Text) so Right Arrow works immediately.
# TIP: Press 'F2' at any time to switch to the List View!
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle InlineView
Set-PSReadLineOption -EditMode Windows

# Make Right Arrow accept the ghost text word-by-word
Set-PSReadLineKeyHandler -Key RightArrow -ScriptBlock {
    param($key, $arg)
    $line = $null; $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
    # If cursor is at the end of the line, accept the ghost text
    if ($cursor -lt $line.Length) {
        [Microsoft.PowerShell.PSConsoleReadLine]::ForwardChar($key, $arg)
    } else {
        [Microsoft.PowerShell.PSConsoleReadLine]::AcceptNextSuggestionWord($key, $arg)
    }
}

# --- 5. Conda Lazy Loader ---
function conda {
    $CondaExe = "D:\Users\Jonny\scoop\apps\miniconda3\current\Scripts\conda.exe"
    if (Test-Path $CondaExe) {
        Write-Host "Initializing Conda environment..." -ForegroundColor DarkGray
        (& $CondaExe "shell.powershell" "hook") | Out-String | Invoke-Expression
        conda @args
    } else {
        Write-Error "Conda executable not found at $CondaExe"
    }
}

# --- 6. Theme Initialization (Must be last) ---
# Disable terminal queries when using SSH
oh-my-posh init pwsh --config "C:\Users\Jonny\.config\.mytheme.omp.json" | Invoke-Expression
