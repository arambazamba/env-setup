$sapwd = 'TiTp4SQLPa$$w0rd'
$chocopath = 'c:\programdata\chocolatey'

set-content -Value $Source -Path 'configurationfile.ini'

choco install sql-server-2019 --params='/ConfigurationFile="ConfigurationFile.ini"' -y
choco install sql-server-management-studio -y
choco install azure-data-studio -y