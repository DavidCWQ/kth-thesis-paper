$buildDir = "build"
if (-not (Test-Path $buildDir)) {
    New-Item -ItemType Directory -Path $buildDir | Out-Null
}
$env:TEXMF_OUTPUT_DIRECTORY = (Resolve-Path $buildDir).Path
latexmk -pdf -pdflatex="pdflatex -shell-escape -interaction=nonstopmode -file-line-error" -outdir=$buildDir examplethesis.tex
