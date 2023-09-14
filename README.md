# gen-scribus

POC: generating a [Scribus](https://www.scribus.net/) file via [Haxe](https://haxe.org/)

## temp fix

haxe is acting up...

```bash
haxe -v --wait 6000
```

## Reason

- Not possible to link (and update) to external text file (markdown)
- Generate a quick and dirty document with text and image on a spread
- Automate some of the scribus features
- Not possible to use commandline to generate file
- Not possible to update document (with external file and/or input)

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
- [x] use UUID in nodes (doesn't work.. is cleaned after save in Scribus)
- [x] import text
- [x] custom markdown converter
  - [x] heading
  - [x] bold
  - [x] italic
  - [ ] bold italic
  - [ ] quote / block quote
  - [ ] list
  - [ ] number list
- [x] update text (how to find? use UUID, doesn't work)
- [x] text input odt
- [x] text input markdown
- [x] text input html
- [x] create json (settings file)
- [x] generate document based upon json (settings file)
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
