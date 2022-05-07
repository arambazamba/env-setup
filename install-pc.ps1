# Settings vars
$User="Ernst Stöger"
$EMAIL="ernst.stoeger@integrations.at"

# Install chocolatey
Write-Host "Installing Chocolatey - 1/6" -ForegroundColor yellow

Set-ExecutionPolicy Bypass -Scope Process -Force; 
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; 
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install Git Related Software
Write-Host "Installing VSCode & Git Related Software" -ForegroundColor yellow
Write-Host "Refresh Path Env - 2/6" -ForegroundColor yellow

choco install googlechrome -y
choco install vscode -y
choco install git -y
choco install gitextensions -y

# Install Software
Write-Host "Refresh Path Env - 3/6" -ForegroundColor yellow

choco install dotnetcore-sdk -y
choco install dotnet-6.0-sdk -y
choco install nodejs --version=14.15.0 -y
choco install azure-cli -y
choco install azurepowershell -y
choco install microsoftazurestorageexplorer -y
choco install azure-data-studio -y
choco install ngrok -y
choco install microsoft-windows-terminal -y
choco install sql-server-management-studio -y

# General Software

choco install microsoft-teams -y
choco install telegram -y
choco install signal -y
choco install googlephotos -y
choco install spotify -y
choco install 7zip -y
choco install adobereader -y
choco install displayfusion -y
choco install onedrive -y 
choco install snagit -y 

# Refresh Path Env
Write-Host "Refresh Path Env - 4/6" -ForegroundColor yellow

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Setup Git
git config --global user.name $User
git config --global user.email $EMAIL

# Turn off Taskbar grouping
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name TaskbarGlomLevel -Value 2

# Intall VS Code Extensions
Write-Host "VS Code Extensions - 5/6" -ForegroundColor yellow

code --install-extension ms-dotnettools.csharp
code --install-extension ms-vscode.powershell
code --install-extension ms-vscode.azurecli
code --install-extension ms-vscode.azure-account
code --install-extension ms-azuretools.vscode-azureappservice
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-azuretools.vscode-cosmosdb
code --install-extension ms-azuretools.vscode-azurefunctions
code --install-extension ms-azuretools.vscode-azurestaticwebapps
code --install-extension GitHub.vscode-pull-request-github
code --install-extension redhat.vscode-yaml
code --install-extension bencoleman.armview
code --install-extension msazurermtools.azurerm-vscode-tools
code --install-extension mdickin.markdown-shortcuts
code --install-extension mhutchie.git-graph 
code --install-extension humao.rest-client

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

npx @angular/cli@latest analytics off
npm i -g @angular/cli

# Finished Msg
Write-Host "Finished Software installation" -ForegroundColor yellow