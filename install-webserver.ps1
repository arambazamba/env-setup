

function Disable-InternetExplorerESC {
    $AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
    $UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
    Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0
    Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0
    Stop-Process -Name Explorer
    Write-Host "IE Enhanced Security Configuration (ESC) has been disabled." -ForegroundColor Green
}

function Disable-UserAccessControl {
    Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value 00000000
    Write-Host "User Access Control (UAC) has been disabled." -ForegroundColor Green    
}

function InstallWebserver{
    import-module servermanager
    add-windowsfeature web-server -includeallsubfeature
}

function AddUsability{
    Set-WinUserLanguageList -LanguageList de-AT -Force
    Import-Module ServerManager 
    Add-WindowsFeature PowerShell-ISE
    Add-WindowsFeature Desktop-Experience
    #Disable Server Manager Startup
    New-ItemProperty -Path HKCU:\Software\Microsoft\ServerManager -Name DoNotOpenServerManagerAtLogon -PropertyType DWORD -Value "0x1" -Force
	New-ItemProperty HKLM:\System\CurrentControlSet\Control\Lsa -Name "DisableLoopbackCheck" -value "1" -PropertyType dword
}

function Set-DefaultBrowser
{
    param($defaultBrowser)
 
    $regKey      = "HKCU:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\{0}\UserChoice"
    $regKeyFtp   = $regKey -f 'ftp'
    $regKeyHttp  = $regKey -f 'http'
    $regKeyHttps = $regKey -f 'https'
 
    switch -Regex ($defaultBrowser.ToLower())
    {
        # Internet Explorer
        'ie|internet|explorer' {
            Set-ItemProperty $regKeyFtp   -name ProgId IE.FTP
            Set-ItemProperty $regKeyHttp  -name ProgId IE.HTTP
            Set-ItemProperty $regKeyHttps -name ProgId IE.HTTPS
            break
        }
        # Firefox
        'ff|firefox' {
            Set-ItemProperty $regKeyFtp   -name ProgId FirefoxURL
            Set-ItemProperty $regKeyHttp  -name ProgId FirefoxURL
            Set-ItemProperty $regKeyHttps -name ProgId FirefoxURL
            break
        }
        # Google Chrome
        'cr|google|chrome' {
            Set-ItemProperty $regKeyFtp   -name ProgId ChromeHTML
            Set-ItemProperty $regKeyHttp  -name ProgId ChromeHTML
            Set-ItemProperty $regKeyHttps -name ProgId ChromeHTML
            break
        }   
    } 
}

function InstallChoco
{
    Set-ExecutionPolicy Bypass -Scope Process -Force; 
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; 
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

function InstallPackages
{
    choco install googlechrome -y
    choco install git -y
    choco install gitextensions -y
    choco install dotnetcore-sdk -y
    choco install dotnet-5.0-sdk -y
    choco install nvm -y
    choco install azure-cli -y
    choco install azurepowershell -y
    choco install microsoftazurestorageexplorer -y
    choco install azure-data-studio -y
    choco install postman -y
    choco install microsoft-windows-terminal -y
    choco install certifytheweb -y
    choco install sql-server-management-studio -y
    choco install 7zip -y
    choco install adobereader -y
}

function DisableTaskbarGrouping{
    Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name TaskbarGlomLevel -Value 2
}

function InstallVSCode
{
    choco install vscode -y
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
}    

Disable-InternetExplorerESC
Disable-UserAccessControl
InstallWebserver
AddUsability
InstallChoco
InstallPackages
InstallVSCode
DisableTaskbarGrouping