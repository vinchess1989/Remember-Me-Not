$slidesDir = Join-Path $PWD "slides"

if (-Not (Test-Path $slidesDir)) {
    Write-Host "Directory 'slides' not found."
    exit
}

$htmlFiles = Get-ChildItem -Path $slidesDir -Filter "*.html"

foreach ($file in $htmlFiles) {
    $content = [System.IO.File]::ReadAllText($file.FullName)
    
    $content = $content.Replace('`', '\`').Replace('${', '\${')
    
    $jsName = $file.Name.Replace('.html', '.js')
    $jsKey = "slides/$jsName"
    $jsPath = Join-Path $slidesDir $jsName
    
    $jsContent = "window.presentationSlides = window.presentationSlides || {};`nwindow.presentationSlides['$jsKey'] = ``" + "`n" + $content + "`n``;`n"
    
    [System.IO.File]::WriteAllText($jsPath, $jsContent, [System.Text.Encoding]::UTF8)
    Write-Host "Converted $($file.Name) to $jsName"
}

Write-Host "`nConversion complete! Your wrapper should now load perfectly."