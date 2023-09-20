# gen-scribus

POC: generating a [Scribus](https://www.scribus.net/) file via [Haxe](https://haxe.org/)

## Reason

- Not possible to link (and update) to external text file (markdown)
- Generate a quick and dirty document with text and image on a spread
- Automate some of the scribus features via settings
- Not possible to use commandline to generate file
- Not possible to update document (with external file and/or input)
- Better import markdown (Scribus default markdown import will break when using `<li>`)

## TODO

check [TODO](TODO.md)

## Pandoc

Use pandoc, to convert markdown to a file that works for scribus

see: [pandoc.sh](pandoc.sh)

```bash
# open terminal to the root of this repo
sh pandoc.sh
```
