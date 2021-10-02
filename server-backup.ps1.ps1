Add-PSSnapin WebAdministration -ErrorAction SilentlyContinue
Import-Module WebAdministration -ErrorAction SilentlyContinue
Add-Type -Assembly "System.IO.Compression.FileSystem"


function SetMethodRequiresCWD() {
    [Type] $requestType = [System.Net.FtpWebRequest]
    [System.Reflection.FieldInfo] $methodInfoField = $requestType.GetField("m_MethodInfo", [System.Reflection.BindingFlags]::NonPublic -bor [System.Reflection.BindingFlags]::Instance)
    [Type] $methodInfoType = $methodInfoField.FieldType


    [System.Reflection.FieldInfo] $knownMethodsField = $methodInfoType.GetField("KnownMethodInfo", [System.Reflection.BindingFlags]::Static -bor [System.Reflection.BindingFlags]::NonPublic)
    [Array] $knownMethodsArray = [Array]$knownMethodsField.GetValue($null);

    [System.Reflection.FieldInfo] $flagsField = $methodInfoType.GetField("Flags", [System.Reflection.BindingFlags]::NonPublic -bor [System.Reflection.BindingFlags]::Instance)

    [int] $MustChangeWorkingDirectoryToPath = 0x100
    ForEach ($knownMethod In $knownMethodsArray) {
        [int] $flags = [int]$flagsField.GetValue($knownMethod)
        $flags = $flags -bor $MustChangeWorkingDirectoryToPath
        $flagsField.SetValue($knownMethod, $flags)
    }
}

SetMethodRequiresCWD

$DBBackupPath = "D:\DBBackup"
$IISBackupDir = "IISBackup_" + (Get-Date).ToString("dd-MM-yyy") 
$IISSystem = "C:\Windows\System32\inetsrv\backup\"
$IISBackupFullPath = $IISSystem + $IISBackupDir

if(Test-Path $IISBackupFullPath){
	Remove-WebConfigurationBackup $IISBackupDir
}

Backup-WebConfiguration -Name $IISBackupDir

$sources = @($DBBackupPath, "D:\Webs", $IISBackupFullPath)
$files =  @("db_backup_" + (Get-Date).ToString("dd-MM-yyy") +  ".zip"), @("web_backup_" + (Get-Date).ToString("dd-MM-yyy") +  ".zip"), @("iis_config_backup_" + (Get-Date).ToString("dd-MM-yyy") +  ".zip")

$ct = 0
$webClient = New-Object System.Net.WebClient
$webClient.AllowWriteStreamBuffering = $true;
$webclient.Credentials = New-Object System.Net.NetworkCredential("server","server02")

ForEach($file in $files){
	$destination = "d:\" + $file
	If((Test-path $destination) -And ($ct -lt 2)) {Remove-item $destination}

	[io.compression.zipfile]::CreateFromDirectory($sources[$ct], $destination) 
	
    $url = "ftp://80.108.244.55/ALEX_USB/server/" + $file 
	$webclient.UploadFile($url, $destination)
	
	Remove-Item $destination
	Write-Host "Processed " $file
	$ct++
}
$webClient.Dispose()

Remove-WebConfigurationBackup $IISBackupDir

$limit = (Get-Date).AddDays(-1)
Get-ChildItem -Path $DBBackupPath -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $limit } | Remove-Item -Force

Write-Host "Backup finished "