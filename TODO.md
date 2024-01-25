# TODO

### Scribus

- [x] create scribus file in any size you want
- [x] regex door alle PAGEHEIGHT PAGEWIDTH
- [ ] single page, facing page
- Single page
  - [ ] master called normal
  - [ ] all page x same
  - [ ] all page MNAM =normal
- Pages
  - [x] add pages
  - [x] xpos ypos page
  - [ ] left, right, middle page
- Document
  - [x] change input to mm
  - [x] change margins
  - [x] change the language of the file
  - [x] horizontal and vertical guides
  - [x] snapToGuide toggle
  - [x] generate document based upon json (settings file)
  - [x] updating title, author, etc
- [x] create dummy png
- [x] use UUID in nodes (doesn't work.. is cleaned after save in Scribus)
- Custom markdown converter
  - [x] heading
  - [x] bold
  - [x] italic
  - [x] bold italic
  - [ ] strikethrough
  - [x] quote / block quote
  - [x] list
  - [x] number list
  - [ ] refactor
  - [ ] test more
  - [x] fix choose enters to hide or not
  - [x] remove html escape of (single) quotes
- [x] create json (settings file)
- [x] adding colors (rgb, cmyk)
- Images
  - [x] fit image to frame
  - [x] import images
  - [x] update images (does Scribus also self)
  - [x] xpos/ypos image
  - [x] position images via settings json
  - [ ] use percentage for width and height
  - [ ] use percentage for x and y
- Texts

  - [x] import text
  - [x] ~~update text~~ ( UUID, doesn't work)
  - [x] text input odt
  - [x] text input markdown
  - [x] text input html
  - [x] xpos/ypos text
  - [x] position texts via settings json
  - [ ] use percentage for width and height
  - [ ] use percentage for x and y
  - [ ] custom style

- [x] resize image to correct scale (load image, get imagesize, calculate new scale) <- fit image to frame

### Inkscape

When I generate a document, I add an Inkscape svg with the same padding/bleed/size

- [ ] create inkscape file in any size you want
- [ ] use settings
- Pages
  - [ ] add pages
  - [ ] xpos ypos page
- Document
  - [ ] change input to mm
  - [ ] change margins
  - [ ] change the language of the file
  - [ ] horizontal and vertical guides
  - [ ] snapToGuide toggle
  - [ ] generate document based upon json (settings file)
  - [ ] updating title, author, etc
- Artboards
  - [ ] generate artboards
  - [ ] create bleed, bg, margin layer
