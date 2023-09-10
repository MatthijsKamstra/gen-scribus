# gen-scribus

POC generating a scribus file with Haxe

## Reason

- Not possible to link to external text file (markdown)
- Generate a quick and dirty document with text and image on a spread
- automate some of the scribus features
-

## Goals:

- [x] create scribus file in any size you want
- [x] regex door alle PAGEHEIGHT PAGEWIDTH
- [x] change the language of the file
- [x] add pages
- [x] xpos ypos page
- [x] change input to mm
- [x] change margins
- [x] create dummy png
- [x] import images
- [x] update images
- [x] xpos ypos image
- [ ] import text
- [ ] update text
- [x] text input odt
- [x] text input markdown
- [x] text input html
- [ ] generate document based upon json (settings file)
- [x] adding colors (rgb, cmyk)
- [x] horizontal and vertical guides
- [x] snapToGuide toggle
- [x] fit image to frame
- [ ] updating title, author, etc
- [ ] single page, facing page
- [x] resize image to correct scale (load image, get imagesize, calculate new scale) <- fit image to frame

## Pandoc

Use pandoc, to convert markdown to a file that works for scribus

see: [pandoc.sh](pandoc.sh)

```bash
# open terminal to the root of this repo
sh pandoc.sh
```
