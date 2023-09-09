# gen-scribus

POC generating a scribus file with Haxe

## Goals:

- [x] create scribus file in any size you want
- [x] regex door alle PAGEHEIGHT PAGEWIDTH
- [x] change the language of the file
- [x] add pages
- [x] change input to mm
- [ ] change margins
- [ ] import images
- [ ] update images
- [ ] import text
- [ ] update text
- [ ] text input markdown
- [ ] text input html
- [ ] generate document based upon json (settings file)
- [x] adding colors (rgb, cmyk)
- [ ] updating title, author, etc
- [ ] single page, facing page

## Pandoc

Use pandoc, to convert markdown to a file that works for scribus

see: [pandoc.sh](pandoc.sh)

```bash
# open terminal to the root of this repo
sh pandoc.sh
```
