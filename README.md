# gen-scribus

POC: generating a [Scribus](https://www.scribus.net/) file via [Haxe](https://haxe.org/)

![](haxe_scribus.jpeg)

## Reason

- Not possible to link (and update) to external text file (markdown)
- Generate a quick and dirty document with text and image on a spread
- Automate some of the scribus features via settings
- Not possible to use commandline to generate file
- Not possible to update document (with external file and/or input)
- Better import markdown (Scribus default markdown import will break when using `<li>`)

## json structure

basic structure

```json
{
  "document": {}, // used for the settings of the document
  "pages": [] // pages (left right)
}
```

About document

```json
{
  "document": {
    "author": "Matthijs Kamstra",
    "title": "test images with gen-scribus",
    "description": "blah blah, Haxe Scribus Gen doc",
    "language": "nl",
    "pageName": "a4",
    "width": { "unit": "mm", "value": 210 },
    "height": { "unit": "mm", "value": 210 },
    "margins": [
      { "dir": "left", "unit": "mm", "value": 10 },
      { "dir": "right", "unit": "mm", "value": 10 },
      { "dir": "top", "unit": "mm", "value": 10 },
      { "dir": "bottom", "unit": "mm", "value": 10 }
    ],
    "guides": [
      { "dir": "left", "unit": "mm", "value": 10 },
      { "dir": "right", "unit": "mm", "value": 10 },
      { "dir": "top", "unit": "mm", "value": 10 },
      { "dir": "bottom", "unit": "mm", "value": 10 }
    ],
    "bleeds": [
      { "dir": "left", "unit": "mm", "value": 3 },
      { "dir": "right", "unit": "mm", "value": 3 },
      { "dir": "top", "unit": "mm", "value": 3 },
      { "dir": "bottom", "unit": "mm", "value": 3 }
    ],
    "guideSnap": true,
    "guideLocked": true
  }
  //   ...
}
```

pages

```json
 "pages": [
    {
      "left": {},
      "right": {
        "_alias": "Cover (right) Green",
        "images": [
          {
            "path": "assets/png/a4_green.png",
            "width": { "unit": "mm", "value": 100 },
            "height": { "unit": "mm", "value": 100 }
          },
          {
            "path": "assets/png/a4_gray.png",
            "x": { "unit": "mm", "value": 0 },
            "y": { "unit": "mm", "value": 0 },
            "width": { "unit": "mm", "value": 210 },
            "height": { "unit": "mm", "value": 297 }
          },
          {
            "path": "assets/png/a4_blue.png",
            "x": { "unit": "mm", "value": -3 },
            "y": { "unit": "mm", "value": -3 },
            "width": { "unit": "mm", "value": 216 },
            "height": { "unit": "mm", "value": 303 }
          }
        ]
      }
    },
    {
      "left": {},
      "right": {}
    }
  ]
```

use typed json:

```haxe
var _HxSettingsObj:HxSettingsObj = {
	// ....
}

```

## TODO

check [TODO](TODO.md)

## Pandoc

Use pandoc, to convert markdown to a file that works for scribus

see: [pandoc.sh](pandoc.sh)

```bash
# open terminal to the root of this repo
sh pandoc.sh
```
