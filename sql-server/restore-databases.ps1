$path="C:\DBBackup";
$files = Get-ChildItem -Path $path

for ($i=0; $i -lt $files.length; $i++){
    $file=$files[$i]
    $item= $path + "\" + $file.Name   
    sqlcmd -q "RESTORE DATABASE TESTDB  FROM DISK=N'$item'" ;
}