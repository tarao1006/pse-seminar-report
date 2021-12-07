$latex      = "find . -type f -name '*.tex' | xargs sed -i -e 's/、/，/g' -e 's/。/．/g'; platex -synctex=1 -halt-on-error %O %S";
$bibtex     = "pbibtex %O %B";
$dvipdf     = "dvipdfmx -f ptex-haranoaji.map -V 7 %O -o %D %S";
$max_repeat = 5;
$pdf_mode   = 3;
