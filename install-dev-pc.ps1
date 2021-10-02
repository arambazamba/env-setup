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
choco install dotnet-5.0-sdk -y
choco install nvm
choco install azure-cli -y
choco install azure-functions-core-tools-3 --params="'/x64:true'" -y
choco install azurestorageemulator -y
choco install azurepowershell -y
choco install microsoftazurestorageexplorer -y
choco install azure-data-studio -y
choco install postman -y
choco install ngrok -y
choco install 7zip -y
choco install adobereader -y

# General Software

choco install microsoft-teams -y
choco install microsoft-windows-terminal -y
choco install telegram -y
choco install googlephotos -y
choco install spotify -y
choco install sql-server-management-studio -y

# Refresh Path Env
Write-Host "Refresh Path Env - 4/6" -ForegroundColor yellow

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Install httprepl
dotnet tool install -g Microsoft.dotnet-httprepl
dotnet nuget add source https://api.nuget.org/v3/index.json -n nuget.org

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
code --install-extension CoenraadS.bracket-pair-colorizer-2
code --install-extension mdickin.markdown-shortcuts
code --install-extension mhutchie.git-graph 
code --install-extension humao.rest-client

# Install Node

nvm install 12.20.0
nvm install 14.18.0
nvm use 14.18.0

# Install Angular
Write-Host "Installing Angular - 6/6" -ForegroundColor yellow

npx @angular/cli@latest analytics off
npm i -g @angular/cli

# Azurite Storage Emulator

npm install -g azurite

# Base Toolset M365 Related
npm i -g webpack webpack-cli
npm i -g gulp yo @microsoft/generator-sharepoint
npm i -g @pnp/cli-microsoft365
npm i -g generator-teams
npm i -g yo generator-office
npm i -g spfx-fast-serve

# SPA Frameworks
npm i -g create-react-app

# Finished Msg
Write-Host "Finished Software installation" -ForegroundColor yellow