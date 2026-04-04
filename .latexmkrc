# .latexmkrc - Configuration for KTH Thesis

# Use pdflatex with shell-escape
$pdflatex = 'pdflatex -shell-escape -interaction=nonstopmode -file-line-error -synctex=1';

# Set output directory for intermediate files ONLY
$out_dir = 'build';
$aux_dir = 'build';

# PDF mode
$pdf_mode = 1;

# CRITICAL: Keep PDF in the same directory as the source .tex file
# This tells latexmk NOT to move the PDF to the output directory
$pdf_update_method = 4;  # 4 = copy PDF to source directory

# Change to the directory of the main file
$cd = 1;

# Quiet mode
$silent = 0;

# Custom dependencies for glossaries
add_cus_dep('glo', 'gls', 0, 'make_glossaries');
sub make_glossaries {
    system("makeglossaries '$_[0]'");
}

add_cus_dep('acn', 'acr', 0, 'make_acronyms');
sub make_acronyms {
    system("makeglossaries '$_[0]'");
}