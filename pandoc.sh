#!/bin/bash

echo 'Using pandoc.sh to convert .md to .docx/.html/.odt'



# pandoc -o assets/converted/open_vraag_00.docx -f markdown -t docx -V lang=nl assets/markdown/open_vraag_00.md
pandoc -o assets/converted/open_vraag_00.odt -f markdown -t odt -V lang=nl assets/markdown/open_vraag_00.md
# pandoc -o assets/converted/open_vraag_00.html -f markdown -t html -V lang=nl assets/markdown/open_vraag_00.md


# pandoc -o assets/converted/cheatsheet.rtf -f markdown -t rtf -V lang=nl assets/markdown/cheatsheet.md
pandoc -o assets/converted/cheatsheet.odt -f markdown -t odt -V lang=nl assets/markdown/cheatsheet.md
# pandoc -o assets/converted/cheatsheet.html -f markdown -t html -V lang=nl assets/markdown/cheatsheet.md
# pandoc -o assets/converted/cheatsheet.docx -f markdown -t docx -V lang=nl assets/markdown/full_markdown.md




# echo 'Step 0. Close LibreOffice'
# echo '(it seems impossible to refresh a new document with the same name)'
# osascript -e 'tell application "LibreOffice" to quit'
# # osascript -e 'tell application "Word" to quit'

# echo 'Step 1: Convert markdown to docx 5'
# # pandoc -o digital_2023_by_MatthijsKamstra.docx -f markdown -t docx digital_2023_by_MatthijsKamstra.md
# # pandoc -o digital_2023_by_MatthijsKamstra_v03.docx -f markdown -t docx digital_2023_by_MatthijsKamstra_v03.md
# # pandoc -o digital_2023_by_MatthijsKamstra_v04.docx -f markdown -t docx -V lang=nl digital_2023_by_MatthijsKamstra_v04.md
# # pandoc -o digital_2023_by_MatthijsKamstra_v05.docx -f markdown -t docx --metadata title="title Name" -V lang=nl digital_2023_by_MatthijsKamstra_v05.md
# pandoc -o digital_2023_by_MatthijsKamstra_v05.docx -f markdown -t docx -V lang=nl digital_2023_by_MatthijsKamstra_v05.md
# # pandoc -o digital_2023_by_MatthijsKamstra.pdf test.md

# echo 'Step 2: Open docx in LibreOffice'
# # open digital_2023_by_MatthijsKamstra.docx
# # open -a "LibreOffice" digital_2023_by_MatthijsKamstra.docx
# # open -a "LibreOffice" digital_2023_by_MatthijsKamstra_v03.docx
# # open -a "LibreOffice" digital_2023_by_MatthijsKamstra_v04.docx
# open -a "LibreOffice" digital_2023_by_MatthijsKamstra_v05.docx



echo 'end'

# #!/bin/bash

# echo 'start convertion .md to .odt / .dox / .pdf'

# # pandoc paperart-project.md -V geometry:margin=5cm -s -o export/paperart-project.odt

# # pandoc chapter-bots.md -V geometry:margin=5cm -s -o export/chapter-bots.odt
# # pandoc chapter-creativity.md -V geometry:margin=5cm -s -o export/chapter-creativity.odt
# # pandoc chapter-matthijskamstra.md -V geometry:margin=5cm -s -o export/chapter-matthijskamstra.odt
# # pandoc chapter-papertoys.md -V geometry:margin=5cm -s -o export/chapter-papertoys.odt
# # pandoc chapter-play.md -V geometry:margin=5cm -s -o export/chapter-play.odt
# # pandoc chapter-vision.md -V geometry:margin=5cm -s -o export/chapter-vision.odt


# # pandoc chapter-bots.md -V geometry:margin=1in -s -o export/chapter-bots.pdf
# # pandoc chapter-creativity.md -V geometry:margin=1in -s -o export/chapter-creativity.pdf
# # pandoc chapter-matthijskamstra.md -V geometry:margin=1in -s -o export/chapter-matthijskamstra.pdf
# # pandoc chapter-papertoys.md -V geometry:margin=1in -s -o export/chapter-papertoys.pdf
# # pandoc chapter-play.md -V geometry:margin=1in -s -o export/chapter-play.pdf
# # pandoc chapter-vision.md -V geometry:margin=1in -s -o export/chapter-vision.pdf


# pandoc chapter-bots.md -V geometry:margin=5cm -s -o export/chapter-bots.docx
# pandoc chapter-creativity.md -V geometry:margin=5cm -s -o export/chapter-creativity.docx
# pandoc chapter-matthijskamstra.md -V geometry:margin=5cm -s -o export/chapter-matthijskamstra.docx
# pandoc chapter-papertoys.md -V geometry:margin=5cm -s -o export/chapter-papertoys.docx
# pandoc chapter-play.md -V geometry:margin=5cm -s -o export/chapter-play.docx
# pandoc chapter-vision.md -V geometry:margin=5cm -s -o export/chapter-vision.docx

# echo 'end'

