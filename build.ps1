# Build the thesis with latexmk (runs BibTeX / glossaries as needed).
# Usage:
#   .\build.ps1                      # builds my_thesis.tex
#   .\build.ps1 -Clean               # full clean + rebuild (use after .latexmkrc / bib changes)
#   .\build.ps1 examplethesis.tex    # builds the template example
param(
    [Parameter(Position = 0)]
    [string]$Main = "my_thesis.tex",
    [switch]$Clean
)

$ErrorActionPreference = "Stop"
$buildDir = "build"

if (-not (Test-Path $buildDir)) {
    New-Item -ItemType Directory -Path $buildDir | Out-Null
}

# Same path as latexmk -outdir: required by minted v3 when using MiKTeX with
# -output-directory (see minted package warning). Omitting it makes pdflatex exit 1,
# which stops latexmk before follow-up runs—BibTeX may never get applied → [?] cites.
$env:TEXMF_OUTPUT_DIRECTORY = Join-Path (Get-Location).Path $buildDir

$mainPath = Resolve-Path -Path $Main -ErrorAction Stop

if ($Clean) {
    latexmk -C -outdir=$buildDir $mainPath.Path
}

# -f: first pass has undefined citations/refs; still run BibTeX and further pdflatex.
latexmk -f -pdf `
    -pdflatex="pdflatex -shell-escape -interaction=nonstopmode -file-line-error -synctex=1" `
    -outdir=$buildDir `
    $mainPath.Path
