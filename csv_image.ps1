# Read the CSV file "csv_imagini.csv" with columns "index" and "folder_name"
# Set the input directory path, output directory path, and cod_tara

# Get folder_lucru from the command line arguments
$folder_lucru = Read-Host "Enter folder_lucru:"  # Assuming the first command line argument is  
$tara = Read-Host "Enter tara:"  # Assuming the first command line argument is  

# Read the CSV file
$csvData = Import-Csv -Path "$folder_lucru\csv_imagini.csv"
Write-Host "You entered: $userInput"
foreach ($row in $csvData) {
    $folderName = $row.folder_name
    $cod_tara = $row.folder_name
    # Get a list of image files in the folder
    $imageList = Get-ChildItem -Path "$folder_lucru\in_directory_path\$folderName" -File
    
    # Create the output directory if it doesn't exist
    $outputFolderPath = Join-Path -Path "$folder_lucru\out_directory_path" -ChildPath $folderName
   
    if (-not (Test-Path -Path $outputFolderPath -PathType Container)) {
        New-Item -Path $outputFolderPath -ItemType Directory | Out-Null
    }
    $i = 0 
    foreach ($image in $imageList) {
        $nrPrefix = 1000 + $i + 1
        $i++
        $newImageName = Join-Path -Path $outputFolderPath -ChildPath (   
            $tara + "_" + $cod_tara +"_"+"S"+ $nrPrefix  + $image.Extension )
        Copy-Item -Path $image.FullName -Destination $newImageName
    }
}

pause