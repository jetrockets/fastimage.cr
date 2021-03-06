# fastimage.cr

[![Build Status](https://github.com/jetrockets/fastimage.cr/workflows/specs/badge.svg?branch=master)](https://github.com/jetrockets/fastimage.cr/actions)
[![GitHub release](https://img.shields.io/github/release/jetrockets/fastimage.cr.svg)](https://GitHub.com/jetrockets/fastimage.cr/releases/)
[![GitHub license](https://img.shields.io/github/license/jetrockets/fastimage.cr)](https://github.com/jetrockets/fastimage.cr/blob/master/LICENSE)

Library that finds the dimensions and type of an image fetching as little as needed.

## Documentation

[https://jetrockets.github.io/fastimage.cr](https://jetrockets.github.io/fastimage.cr)

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     fastimage:
       github:jetrockets/fastimage.cr
   ```

2. Run `shards install`

## Usage

```crystal
require "fastimage"
```

### `.type : String|Nil`

Returns image type. Returns `nil` if image type is not supported.

```crystal
FastImage.type("https://file-examples.com/wp-content/uploads/2017/10/file_example_PNG_3MB.png")
# => png
```

### `.type! : String`

Same as `#type`, but raise exception if anything goes wrong.

### `.dimensions : Tuple(UInt16?, UInt16?)|Nil`

Returns image width and height as a `Tuple(UInt16?, UInt16?)`. Returns `nil` if image type is not supported.

```crystal
FastImage.dimensions("https://file-examples.com/wp-content/uploads/2017/10/file_example_PNG_3MB.png")
# => [2200, 1467]
```

### `.dimensions! : Tuple(UInt16?, UInt16?)`

Same as `#dimensions`, but raise exception if anything goes wrong.

## Feature Progress

- [ ] Data sources
  - [X] Remote file
    - [X] HTTP/HTTPS
    - [ ] Proxy
    - [ ] HTTP redirects
  - [X] Local file
  - [X] IO
  - [X] Base64
- [ ] File formats
  - [X] BMP
  - [X] CUR
  - [X] GIF
  - [X] ICO
  - [X] JPEG
    - [X] parse EXIF information for JPEG orientation
  - [X] PNG
  - [X] PSD
  - [ ] SVG
  - [X] TIFF
  - [X] WEBP


## Contributing

1. Fork it (<https://github.com/jetrockets/fastimage.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Igor Alexandrov](https://github.com/igor-alexandrov) - creator and maintainer
