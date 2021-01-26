Function Get-FileNames {
<#
.Synopsis
   Function written in order to recursively get all file names from specified path.
.DESCRIPTION
    Function will recursively look at all file names from the top of the listed directory
    Data will be exported in CSV format.
    Data, if no file path is specified will be exported in the current directory. Alternative export path can be specified
.EXAMPLE
   Get-IAACFileNames -Path C:\Users\
.EXAMPLE
   Get-IAACFileNames -Path C:\Users\ -ExportPath C:\temp\
.INPUTS
   File Paths
.OUTPUTS
   Confirmation of export
.NOTES
   Written by : J-P Amyotte
   Email : jpamyotte85@gmail.com
   Version : 1.0
   Date : December 14, 2020 1:16:22 PM
#>

    [CmdletBinding()]
    Param(

      [Parameter(Mandatory=$false)]
      [string]$Path,

      [Parameter(Mandatory=$false)]
      [string]$ExportPath = $(get-location).path


    
    )




    $Test = Test-Path $Path
    $TestExport = Test-Path $ExportPath
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



}