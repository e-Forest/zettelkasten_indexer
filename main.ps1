# Setze den Pfad zu dem Ordner, den du durchlaufen möchtest
$folderPath = "C:\Users\ewald\zettelkasten - Kopie"

# Hole alle Dateien im Ordner
$files = Get-ChildItem -Path $folderPath -File | Sort-Object CreationTime

$counter = 0

foreach ($file in $files) {
    # Prüfe, ob der Dateiname kein '#' enthält
    if ($file.Name -notmatch "#") {
        # Hole das Erstellungsdatum der Datei
        $creationDate = $file.CreationTime

        
        if($lastCreationTime=$creationDate){
            $counter++
        }else{
            $counter = 0
        }
        $lastCreationTime=$creationDate

        echo $creationDate

        # Formatiere das Erstellungsdatum als string
        $formattedDate = $creationDate.ToString("yyMMdd")


        # Baue den neuen Dateinamen
        $newName = "$formattedDate-$counter#$($file.Name)"

        # Setze den vollständigen Pfad für die Umbenennung
        $newPath = Join-Path -Path $folderPath -ChildPath $newName

        # Benenne die Datei um
        Rename-Item -Path $file.FullName -NewName $newPath
    }
}