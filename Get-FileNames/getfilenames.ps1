do{
    
    $Path = Read-Host "Please Enter Root Directory"
    $Test = Test-Path $Path

}until($Test -eq $True) 

do{

    $ExportPath = Read-Host "Please Enter Export Path"
    $TestExport = Test-Path $ExportPath

}until($TestExport -eq $true)



$Date = get-date -Format yyyyMMdd_HHmmss
    

if($Test -eq $True -and $TestExport -eq $True){
        

    $Files = Get-ChildItem $Path -File -Recurse | select Name,FullName,Directory,CreationTime,LastAccessTime,LastWriteTime
    $i = 0
        
        

    foreach($File in $Files){
            
        $i++
        Write-Progress -Activity "$i of $($Files.count) - $($File.name)" -PercentComplete "$($i * 100 / $Files.count)" -Status "Exporting data to : `"$ExportPath\files_$date.csv`""
        Export-Csv -Path "$ExportPath\files_$date.csv" -InputObject $file -NoClobber -NoTypeInformation -Encoding UTF8 -Append 
            
        
    }
    
} else {
    
    $obj = [pscustomobject]@{
        
        Path = $test
        ExportPath = $testexport
        
    }

    Write-Output $obj
    
}

if($test -eq $true -and $testexport -eq $true){
    
    Write-Host "$($files.count) file names exported to `"$ExportPath\files_$date.csv`"" -ForegroundColor Yellow
}



