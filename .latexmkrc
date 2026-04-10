# .latexmkrc - Configuration for KTH Thesis

# Use pdflatex with shell-escape
$pdflatex = 'pdflatex -shell-escape -interaction=nonstopmode -file-line-error -synctex=1';

# Set output directory for intermediate files ONLY
$out_dir = 'build';
$aux_dir = 'build';

# Minted v3 + MiKTeX: pdflatex with -output-directory requires this env var or
# minted fails (exit code 1). That aborts latexmk before the post-BibTeX runs,
# so citations stay as [?] even though BibTeX would succeed.
$ENV{TEXMF_OUTPUT_DIRECTORY} = $out_dir;

# PDF mode
$pdf_mode = 1;

# CRITICAL: Keep PDF in the same directory as the source .tex file
# This tells latexmk NOT to move the PDF to the output directory
$pdf_update_method = 4;  # 4 = copy PDF to source directory

# Change to the directory of the main file
$cd = 1;

# Quiet mode
$silent = 0;

# Custom dependencies for glossaries (must pass output dir when $aux_dir is set)
add_cus_dep('glo', 'gls', 0, 'make_glossaries');
sub make_glossaries {
    my ($path) = @_;
    my $base = $path;
    $base =~ s!^.*/!!;
    system("makeglossaries", "-d", $aux_dir, $base);
}

add_cus_dep('acn', 'acr', 0, 'make_acronyms');
sub make_acronyms {
    my ($path) = @_;
    my $base = $path;
    $base =~ s!^.*/!!;
    system("makeglossaries", "-d", $aux_dir, $base);
}