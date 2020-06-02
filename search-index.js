crystal_doc_search_index_callback({"repository_name":"fastimage","body":"# fastimage.cr\n\n[![Build Status](https://travis-ci.org/jetrockets/fastimage.cr.svg?branch=master)](https://travis-ci.org/jetrockets/fastimage.cr)\n[![GitHub release](https://img.shields.io/github/release/jetrockets/fastimage.cr.svg)](https://GitHub.com/jetrockets/fastimage.cr/releases/)\n[![GitHub license](https://img.shields.io/github/license/jetrockets/fastimage.cr)](https://github.com/jetrockets/fastimage.cr/blob/master/LICENSE)\n\nLibrary that finds the dimensions and type of an image fetching as little as needed.\n\n## Installation\n\n1. Add the dependency to your `shard.yml`:\n\n   ```yaml\n   dependencies:\n     fastimage:\n       github:jetrockets/fastimage.cr\n   ```\n\n2. Run `shards install`\n\n## Usage\n\n```crystal\nrequire \"fastimage\"\n\nFastImage.type(\"https://file-examples.com/wp-content/uploads/2017/10/file_example_PNG_3MB.png\") #png\n\nFastImage.dimensions(\"https://file-examples.com/wp-content/uploads/2017/10/file_example_PNG_3MB.png\") #[2200, 1467]\n```\n\n## Feature Progress\n\n- [ ] Data sources\n  - [X] Remote file\n    - [X] HTTP/HTTPS\n    - [ ] Proxy\n    - [ ] HTTP redirects\n  - [X] Local file\n  - [ ] IO\n  - [ ] Base64\n- [ ] File formats\n  - [X] BMP\n  - [X] CUR\n  - [X] GIF\n  - [X] ICO\n  - [X] JPEG\n    - [ ] parse EXIF information for JPEG orientation\n  - [X] PNG\n  - [ ] PSD\n  - [ ] SVG\n  - [ ] TIFF\n  - [X] WEBP\n\n\n## Contributing\n\n1. Fork it (<https://github.com/jetrockets/fastimage.cr/fork>)\n2. Create your feature branch (`git checkout -b my-new-feature`)\n3. Commit your changes (`git commit -am 'Add some feature'`)\n4. Push to the branch (`git push origin my-new-feature`)\n5. Create a new Pull Request\n\n## Contributors\n\n- [Igor Alexandrov](https://github.com/igor-alexandrov) - creator and maintainer\n","program":{"html_id":"fastimage/toplevel","path":"toplevel.html","kind":"module","full_name":"Top Level Namespace","name":"Top Level Namespace","abstract":false,"superclass":null,"ancestors":[],"locations":[],"repository_name":"fastimage","program":true,"enum":false,"alias":false,"aliased":"","const":false,"constants":[],"included_modules":[],"extended_modules":[],"subclasses":[],"including_types":[],"namespace":null,"doc":null,"summary":null,"class_methods":[],"constructors":[],"instance_methods":[],"macros":[],"types":[{"html_id":"fastimage/FastImage","path":"FastImage.html","kind":"class","full_name":"FastImage","name":"FastImage","abstract":false,"superclass":{"html_id":"fastimage/Reference","kind":"class","full_name":"Reference","name":"Reference"},"ancestors":[{"html_id":"fastimage/Reference","kind":"class","full_name":"Reference","name":"Reference"},{"html_id":"fastimage/Object","kind":"class","full_name":"Object","name":"Object"}],"locations":[{"filename":"src/fastimage.cr","line_number":6,"url":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage.cr#L6"},{"filename":"src/fastimage/meta.cr","line_number":1,"url":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta.cr#L1"},{"filename":"src/fastimage/meta/bmp.cr","line_number":1,"url":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta/bmp.cr#L1"},{"filename":"src/fastimage/meta/cur.cr","line_number":1,"url":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta/cur.cr#L1"},{"filename":"src/fastimage/meta/gif.cr","line_number":1,"url":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta/gif.cr#L1"},{"filename":"src/fastimage/meta/ico.cr","line_number":1,"url":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta/ico.cr#L1"},{"filename":"src/fastimage/meta/jpeg.cr","line_number":1,"url":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta/jpeg.cr#L1"},{"filename":"src/fastimage/meta/png.cr","line_number":1,"url":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta/png.cr#L1"},{"filename":"src/fastimage/meta/psd.cr","line_number":1,"url":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta/psd.cr#L1"},{"filename":"src/fastimage/meta/svg.cr","line_number":1,"url":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta/svg.cr#L1"},{"filename":"src/fastimage/meta/tiff.cr","line_number":1,"url":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta/tiff.cr#L1"},{"filename":"src/fastimage/meta/webp.cr","line_number":1,"url":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta/webp.cr#L1"}],"repository_name":"fastimage","program":false,"enum":false,"alias":false,"aliased":"","const":false,"constants":[],"included_modules":[],"extended_modules":[],"subclasses":[],"including_types":[],"namespace":null,"doc":null,"summary":null,"class_methods":[{"id":"dimensions(uri:URI|String)-class-method","html_id":"dimensions(uri:URI|String)-class-method","name":"dimensions","doc":null,"summary":null,"abstract":false,"args":[{"name":"uri","doc":null,"default_value":"","external_name":"uri","restriction":"URI | String"}],"args_string":"(uri : URI | String)","source_link":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage.cr#L14","def":{"name":"dimensions","args":[{"name":"uri","doc":null,"default_value":"","external_name":"uri","restriction":"URI | String"}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"(new(uri)).meta.try(&.dimensions)"}},{"id":"type(uri:URI|String)-class-method","html_id":"type(uri:URI|String)-class-method","name":"type","doc":null,"summary":null,"abstract":false,"args":[{"name":"uri","doc":null,"default_value":"","external_name":"uri","restriction":"URI | String"}],"args_string":"(uri : URI | String)","source_link":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage.cr#L18","def":{"name":"type","args":[{"name":"uri","doc":null,"default_value":"","external_name":"uri","restriction":"URI | String"}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"(new(uri, type_only: true)).meta.try(&.type)"}}],"constructors":[{"id":"new(uri:String,**options)-class-method","html_id":"new(uri:String,**options)-class-method","name":"new","doc":null,"summary":null,"abstract":false,"args":[{"name":"uri","doc":null,"default_value":"","external_name":"uri","restriction":"String"}],"args_string":"(uri : String, **options)","source_link":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage.cr#L22","def":{"name":"new","args":[{"name":"uri","doc":null,"default_value":"","external_name":"uri","restriction":"String"}],"double_splat":{"name":"options","doc":null,"default_value":"","external_name":"options","restriction":""},"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"_ = allocate\n_.initialize(uri, **options)\nif _.responds_to?(:finalize)\n  ::GC.add_finalizer(_)\nend\n_\n"}},{"id":"new(uri:URI,**options)-class-method","html_id":"new(uri:URI,**options)-class-method","name":"new","doc":null,"summary":null,"abstract":false,"args":[{"name":"uri","doc":null,"default_value":"","external_name":"uri","restriction":"URI"}],"args_string":"(uri : URI, **options)","source_link":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage.cr#L27","def":{"name":"new","args":[{"name":"uri","doc":null,"default_value":"","external_name":"uri","restriction":"URI"}],"double_splat":{"name":"options","doc":null,"default_value":"","external_name":"options","restriction":""},"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"_ = allocate\n_.initialize(uri, **options)\nif _.responds_to?(:finalize)\n  ::GC.add_finalizer(_)\nend\n_\n"}}],"instance_methods":[{"id":"fetch_using_file(**options)-instance-method","html_id":"fetch_using_file(**options)-instance-method","name":"fetch_using_file","doc":null,"summary":null,"abstract":false,"args":[],"args_string":"(**options)","source_link":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage.cr#L41","def":{"name":"fetch_using_file","args":[],"double_splat":{"name":"options","doc":null,"default_value":"","external_name":"options","restriction":""},"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"File.open(uri.to_s) do |file|\n  @meta = parse_type(file, **options)\nend"}},{"id":"fetch_using_http(**options)-instance-method","html_id":"fetch_using_http(**options)-instance-method","name":"fetch_using_http","doc":null,"summary":null,"abstract":false,"args":[],"args_string":"(**options)","source_link":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage.cr#L35","def":{"name":"fetch_using_http","args":[],"double_splat":{"name":"options","doc":null,"default_value":"","external_name":"options","restriction":""},"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"HTTP::Client.get(uri.to_s, headers: HTTP::Headers {\"Accept-Encoding\" => \"identity\"}) do |response|\n  @meta = parse_type(response.body_io, **options)\nend"}},{"id":"meta:Meta?-instance-method","html_id":"meta:Meta?-instance-method","name":"meta","doc":null,"summary":null,"abstract":false,"args":[],"args_string":" : Meta?","source_link":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage.cr#L12","def":{"name":"meta","args":[],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"Meta | ::Nil","visibility":"Public","body":"@meta"}},{"id":"parse_type(io:IO,type_only=false,**options)-instance-method","html_id":"parse_type(io:IO,type_only=false,**options)-instance-method","name":"parse_type","doc":null,"summary":null,"abstract":false,"args":[{"name":"io","doc":null,"default_value":"","external_name":"io","restriction":"IO"},{"name":"type_only","doc":null,"default_value":"false","external_name":"type_only","restriction":""}],"args_string":"(io : IO, type_only = <span class=\"n\">false</span>, **options)","source_link":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage.cr#L47","def":{"name":"parse_type","args":[{"name":"io","doc":null,"default_value":"","external_name":"io","restriction":"IO"},{"name":"type_only","doc":null,"default_value":"false","external_name":"type_only","restriction":""}],"double_splat":{"name":"options","doc":null,"default_value":"","external_name":"options","restriction":""},"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"tmp = Bytes.new(2)\nio.read(tmp)\ncase tmp\nwhen BMP::MAGICK\n  type_only ? BMP.new : BMP.new(io, 2)\nwhen GIF::MAGICK\n  type_only ? GIF.new : GIF.new(io, 2)\nwhen PNG::MAGICK\n  type_only ? PNG.new : PNG.new(io, 2)\nwhen JPEG::MAGICK\n  type_only ? JPEG.new : JPEG.new(io, 2)\nwhen [56, 66]\n  type_only ? PSD.new : PSD.new(io, 2)\nwhen [77, 77]\n  type_only ? TIFF.new : TIFF.new(io, 2)\nwhen ICO::MAGICK\n  byte = io.read_byte\n  if byte == 1\n    type_only ? ICO.new : ICO.new(io, 3)\n  else\n    if byte == 2\n      type_only ? CUR.new : CUR.new(io, 3)\n    else\n      nil\n    end\n  end\nwhen WEBP::MAGICK[0..1]\n  io.read(tmp)\n  if tmp == WEBP::MAGICK[2..3]\n    type_only ? WEBP.new : WEBP.new(io, 4)\n  end\nwhen [60, 63], [60, 33]\nwhen [60, 115]\n  type_only ? SVG.new : SVG.new(io, 3)\nelse\n  nil\nend\n"}},{"id":"uri:URI?-instance-method","html_id":"uri:URI?-instance-method","name":"uri","doc":null,"summary":null,"abstract":false,"args":[],"args_string":" : URI?","source_link":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage.cr#L11","def":{"name":"uri","args":[],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"@uri"}}],"macros":[],"types":[{"html_id":"fastimage/FastImage/BMP","path":"FastImage/BMP.html","kind":"struct","full_name":"FastImage::BMP","name":"BMP","abstract":false,"superclass":{"html_id":"fastimage/FastImage/Meta","kind":"struct","full_name":"FastImage::Meta","name":"Meta"},"ancestors":[{"html_id":"fastimage/FastImage/Meta","kind":"struct","full_name":"FastImage::Meta","name":"Meta"},{"html_id":"fastimage/Struct","kind":"struct","full_name":"Struct","name":"Struct"},{"html_id":"fastimage/Value","kind":"struct","full_name":"Value","name":"Value"},{"html_id":"fastimage/Object","kind":"class","full_name":"Object","name":"Object"}],"locations":[{"filename":"src/fastimage/meta/bmp.cr","line_number":2,"url":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta/bmp.cr#L2"}],"repository_name":"fastimage","program":false,"enum":false,"alias":false,"aliased":"","const":false,"constants":[{"id":"MAGICK","name":"MAGICK","value":"\"BM\".to_slice","doc":null,"summary":null}],"included_modules":[],"extended_modules":[],"subclasses":[],"including_types":[],"namespace":{"html_id":"fastimage/FastImage","kind":"class","full_name":"FastImage","name":"FastImage"},"doc":null,"summary":null,"class_methods":[],"constructors":[],"instance_methods":[{"id":"type-instance-method","html_id":"type-instance-method","name":"type","doc":null,"summary":null,"abstract":false,"args":[],"args_string":"","source_link":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta/bmp.cr#L2","def":{"name":"type","args":[],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"(\"FastImage::BMP\".gsub(/.*::/, \"\")).downcase"}}],"macros":[],"types":[]},{"html_id":"fastimage/FastImage/CUR","path":"FastImage/CUR.html","kind":"struct","full_name":"FastImage::CUR","name":"CUR","abstract":false,"superclass":{"html_id":"fastimage/FastImage/Meta","kind":"struct","full_name":"FastImage::Meta","name":"Meta"},"ancestors":[{"html_id":"fastimage/FastImage/Meta","kind":"struct","full_name":"FastImage::Meta","name":"Meta"},{"html_id":"fastimage/Struct","kind":"struct","full_name":"Struct","name":"Struct"},{"html_id":"fastimage/Value","kind":"struct","full_name":"Value","name":"Value"},{"html_id":"fastimage/Object","kind":"class","full_name":"Object","name":"Object"}],"locations":[{"filename":"src/fastimage/meta/cur.cr","line_number":2,"url":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta/cur.cr#L2"}],"repository_name":"fastimage","program":false,"enum":false,"alias":false,"aliased":"","const":false,"constants":[{"id":"MAGICK","name":"MAGICK","value":"Bytes[0, 0]","doc":null,"summary":null}],"included_modules":[],"extended_modules":[],"subclasses":[],"including_types":[],"namespace":{"html_id":"fastimage/FastImage","kind":"class","full_name":"FastImage","name":"FastImage"},"doc":null,"summary":null,"class_methods":[],"constructors":[],"instance_methods":[{"id":"type-instance-method","html_id":"type-instance-method","name":"type","doc":null,"summary":null,"abstract":false,"args":[],"args_string":"","source_link":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta/cur.cr#L2","def":{"name":"type","args":[],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"(\"FastImage::CUR\".gsub(/.*::/, \"\")).downcase"}}],"macros":[],"types":[]},{"html_id":"fastimage/FastImage/Error","path":"FastImage/Error.html","kind":"class","full_name":"FastImage::Error","name":"Error","abstract":false,"superclass":{"html_id":"fastimage/Exception","kind":"class","full_name":"Exception","name":"Exception"},"ancestors":[{"html_id":"fastimage/Exception","kind":"class","full_name":"Exception","name":"Exception"},{"html_id":"fastimage/Reference","kind":"class","full_name":"Reference","name":"Reference"},{"html_id":"fastimage/Object","kind":"class","full_name":"Object","name":"Object"}],"locations":[{"filename":"src/fastimage.cr","line_number":7,"url":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage.cr#L7"}],"repository_name":"fastimage","program":false,"enum":false,"alias":false,"aliased":"","const":false,"constants":[],"included_modules":[],"extended_modules":[],"subclasses":[{"html_id":"fastimage/FastImage/FormatError","kind":"class","full_name":"FastImage::FormatError","name":"FormatError"}],"including_types":[],"namespace":{"html_id":"fastimage/FastImage","kind":"class","full_name":"FastImage","name":"FastImage"},"doc":null,"summary":null,"class_methods":[],"constructors":[],"instance_methods":[],"macros":[],"types":[]},{"html_id":"fastimage/FastImage/FormatError","path":"FastImage/FormatError.html","kind":"class","full_name":"FastImage::FormatError","name":"FormatError","abstract":false,"superclass":{"html_id":"fastimage/FastImage/Error","kind":"class","full_name":"FastImage::Error","name":"Error"},"ancestors":[{"html_id":"fastimage/FastImage/Error","kind":"class","full_name":"FastImage::Error","name":"Error"},{"html_id":"fastimage/Exception","kind":"class","full_name":"Exception","name":"Exception"},{"html_id":"fastimage/Reference","kind":"class","full_name":"Reference","name":"Reference"},{"html_id":"fastimage/Object","kind":"class","full_name":"Object","name":"Object"}],"locations":[{"filename":"src/fastimage.cr","line_number":9,"url":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage.cr#L9"}],"repository_name":"fastimage","program":false,"enum":false,"alias":false,"aliased":"","const":false,"constants":[],"included_modules":[],"extended_modules":[],"subclasses":[],"including_types":[],"namespace":{"html_id":"fastimage/FastImage","kind":"class","full_name":"FastImage","name":"FastImage"},"doc":null,"summary":null,"class_methods":[],"constructors":[],"instance_methods":[],"macros":[],"types":[]},{"html_id":"fastimage/FastImage/GIF","path":"FastImage/GIF.html","kind":"struct","full_name":"FastImage::GIF","name":"GIF","abstract":false,"superclass":{"html_id":"fastimage/FastImage/Meta","kind":"struct","full_name":"FastImage::Meta","name":"Meta"},"ancestors":[{"html_id":"fastimage/FastImage/Meta","kind":"struct","full_name":"FastImage::Meta","name":"Meta"},{"html_id":"fastimage/Struct","kind":"struct","full_name":"Struct","name":"Struct"},{"html_id":"fastimage/Value","kind":"struct","full_name":"Value","name":"Value"},{"html_id":"fastimage/Object","kind":"class","full_name":"Object","name":"Object"}],"locations":[{"filename":"src/fastimage/meta/gif.cr","line_number":2,"url":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta/gif.cr#L2"}],"repository_name":"fastimage","program":false,"enum":false,"alias":false,"aliased":"","const":false,"constants":[{"id":"MAGICK","name":"MAGICK","value":"Bytes[71, 73]","doc":null,"summary":null}],"included_modules":[],"extended_modules":[],"subclasses":[],"including_types":[],"namespace":{"html_id":"fastimage/FastImage","kind":"class","full_name":"FastImage","name":"FastImage"},"doc":null,"summary":null,"class_methods":[],"constructors":[],"instance_methods":[{"id":"type-instance-method","html_id":"type-instance-method","name":"type","doc":null,"summary":null,"abstract":false,"args":[],"args_string":"","source_link":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta/gif.cr#L2","def":{"name":"type","args":[],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"(\"FastImage::GIF\".gsub(/.*::/, \"\")).downcase"}}],"macros":[],"types":[]},{"html_id":"fastimage/FastImage/ICO","path":"FastImage/ICO.html","kind":"struct","full_name":"FastImage::ICO","name":"ICO","abstract":false,"superclass":{"html_id":"fastimage/FastImage/Meta","kind":"struct","full_name":"FastImage::Meta","name":"Meta"},"ancestors":[{"html_id":"fastimage/FastImage/Meta","kind":"struct","full_name":"FastImage::Meta","name":"Meta"},{"html_id":"fastimage/Struct","kind":"struct","full_name":"Struct","name":"Struct"},{"html_id":"fastimage/Value","kind":"struct","full_name":"Value","name":"Value"},{"html_id":"fastimage/Object","kind":"class","full_name":"Object","name":"Object"}],"locations":[{"filename":"src/fastimage/meta/ico.cr","line_number":2,"url":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta/ico.cr#L2"}],"repository_name":"fastimage","program":false,"enum":false,"alias":false,"aliased":"","const":false,"constants":[{"id":"MAGICK","name":"MAGICK","value":"Bytes[0, 0]","doc":null,"summary":null}],"included_modules":[],"extended_modules":[],"subclasses":[],"including_types":[],"namespace":{"html_id":"fastimage/FastImage","kind":"class","full_name":"FastImage","name":"FastImage"},"doc":null,"summary":null,"class_methods":[],"constructors":[],"instance_methods":[{"id":"type-instance-method","html_id":"type-instance-method","name":"type","doc":null,"summary":null,"abstract":false,"args":[],"args_string":"","source_link":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta/ico.cr#L2","def":{"name":"type","args":[],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"(\"FastImage::ICO\".gsub(/.*::/, \"\")).downcase"}}],"macros":[],"types":[]},{"html_id":"fastimage/FastImage/JPEG","path":"FastImage/JPEG.html","kind":"struct","full_name":"FastImage::JPEG","name":"JPEG","abstract":false,"superclass":{"html_id":"fastimage/FastImage/Meta","kind":"struct","full_name":"FastImage::Meta","name":"Meta"},"ancestors":[{"html_id":"fastimage/FastImage/Meta","kind":"struct","full_name":"FastImage::Meta","name":"Meta"},{"html_id":"fastimage/Struct","kind":"struct","full_name":"Struct","name":"Struct"},{"html_id":"fastimage/Value","kind":"struct","full_name":"Value","name":"Value"},{"html_id":"fastimage/Object","kind":"class","full_name":"Object","name":"Object"}],"locations":[{"filename":"src/fastimage/meta/jpeg.cr","line_number":2,"url":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta/jpeg.cr#L2"}],"repository_name":"fastimage","program":false,"enum":false,"alias":false,"aliased":"","const":false,"constants":[{"id":"COM_MARKER","name":"COM_MARKER","value":"254","doc":"Comment","summary":"<p>Comment</p>"},{"id":"EOI_MARKER","name":"EOI_MARKER","value":"217","doc":"End of image","summary":"<p>End of image</p>"},{"id":"MAGICK","name":"MAGICK","value":"Bytes[SEPARATOR, SOI_MARKER]","doc":null,"summary":null},{"id":"RST_0_MARKER","name":"RST_0_MARKER","value":"208","doc":"Restart (0)","summary":"<p>Restart (0)</p>"},{"id":"RST_7_MARKER","name":"RST_7_MARKER","value":"215","doc":"Restart (7)","summary":"<p>Restart (7)</p>"},{"id":"SEPARATOR","name":"SEPARATOR","value":"255","doc":null,"summary":null},{"id":"SOF_0_MARKER","name":"SOF_0_MARKER","value":"192","doc":"Start of frame (baseline sequential)","summary":"<p>Start of frame (baseline sequential)</p>"},{"id":"SOF_2_MARKER","name":"SOF_2_MARKER","value":"194","doc":"Start of frame (progressive)","summary":"<p>Start of frame (progressive)</p>"},{"id":"SOI_MARKER","name":"SOI_MARKER","value":"216","doc":"Start of image","summary":"<p>Start of image</p>"},{"id":"SOS_MARKER","name":"SOS_MARKER","value":"218","doc":"Start of scans","summary":"<p>Start of scans</p>"}],"included_modules":[],"extended_modules":[],"subclasses":[],"including_types":[],"namespace":{"html_id":"fastimage/FastImage","kind":"class","full_name":"FastImage","name":"FastImage"},"doc":null,"summary":null,"class_methods":[],"constructors":[],"instance_methods":[{"id":"type-instance-method","html_id":"type-instance-method","name":"type","doc":null,"summary":null,"abstract":false,"args":[],"args_string":"","source_link":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta/jpeg.cr#L2","def":{"name":"type","args":[],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"(\"FastImage::JPEG\".gsub(/.*::/, \"\")).downcase"}}],"macros":[],"types":[]},{"html_id":"fastimage/FastImage/Meta","path":"FastImage/Meta.html","kind":"struct","full_name":"FastImage::Meta","name":"Meta","abstract":true,"superclass":{"html_id":"fastimage/Struct","kind":"struct","full_name":"Struct","name":"Struct"},"ancestors":[{"html_id":"fastimage/Struct","kind":"struct","full_name":"Struct","name":"Struct"},{"html_id":"fastimage/Value","kind":"struct","full_name":"Value","name":"Value"},{"html_id":"fastimage/Object","kind":"class","full_name":"Object","name":"Object"}],"locations":[{"filename":"src/fastimage/meta.cr","line_number":3,"url":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta.cr#L3"}],"repository_name":"fastimage","program":false,"enum":false,"alias":false,"aliased":"","const":false,"constants":[],"included_modules":[],"extended_modules":[],"subclasses":[{"html_id":"fastimage/FastImage/BMP","kind":"struct","full_name":"FastImage::BMP","name":"BMP"},{"html_id":"fastimage/FastImage/CUR","kind":"struct","full_name":"FastImage::CUR","name":"CUR"},{"html_id":"fastimage/FastImage/GIF","kind":"struct","full_name":"FastImage::GIF","name":"GIF"},{"html_id":"fastimage/FastImage/ICO","kind":"struct","full_name":"FastImage::ICO","name":"ICO"},{"html_id":"fastimage/FastImage/JPEG","kind":"struct","full_name":"FastImage::JPEG","name":"JPEG"},{"html_id":"fastimage/FastImage/PNG","kind":"struct","full_name":"FastImage::PNG","name":"PNG"},{"html_id":"fastimage/FastImage/PSD","kind":"struct","full_name":"FastImage::PSD","name":"PSD"},{"html_id":"fastimage/FastImage/SVG","kind":"struct","full_name":"FastImage::SVG","name":"SVG"},{"html_id":"fastimage/FastImage/TIFF","kind":"struct","full_name":"FastImage::TIFF","name":"TIFF"},{"html_id":"fastimage/FastImage/WEBP","kind":"struct","full_name":"FastImage::WEBP","name":"WEBP"}],"including_types":[],"namespace":{"html_id":"fastimage/FastImage","kind":"class","full_name":"FastImage","name":"FastImage"},"doc":"Struct to support different file types parsing","summary":"<p>Struct to support different file types parsing</p>","class_methods":[],"constructors":[{"id":"new(io:IO,initial_pos=0)-class-method","html_id":"new(io:IO,initial_pos=0)-class-method","name":"new","doc":"We pass original position to #initialize, because some IOs (like HTTP) does not support #pos","summary":"<p>We pass original position to #initialize, because some IOs (like HTTP) does not support #pos</p>","abstract":false,"args":[{"name":"io","doc":null,"default_value":"","external_name":"io","restriction":"IO"},{"name":"initial_pos","doc":null,"default_value":"0","external_name":"initial_pos","restriction":""}],"args_string":"(io : IO, initial_pos = <span class=\"n\">0</span>)","source_link":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta.cr#L12","def":{"name":"new","args":[{"name":"io","doc":null,"default_value":"","external_name":"io","restriction":"IO"},{"name":"initial_pos","doc":null,"default_value":"0","external_name":"initial_pos","restriction":""}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"_ = allocate\n_.initialize(io, initial_pos)\nif _.responds_to?(:finalize)\n  ::GC.add_finalizer(_)\nend\n_\n"}},{"id":"new-class-method","html_id":"new-class-method","name":"new","doc":null,"summary":null,"abstract":false,"args":[],"args_string":"","source_link":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta.cr#L8","def":{"name":"new","args":[],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"_ = allocate\n_.initialize\nif _.responds_to?(:finalize)\n  ::GC.add_finalizer(_)\nend\n_\n"}}],"instance_methods":[{"id":"dimensions-instance-method","html_id":"dimensions-instance-method","name":"dimensions","doc":null,"summary":null,"abstract":false,"args":[],"args_string":"","source_link":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta.cr#L23","def":{"name":"dimensions","args":[],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"[width, height]"}},{"id":"height:UInt32?-instance-method","html_id":"height:UInt32?-instance-method","name":"height","doc":null,"summary":null,"abstract":false,"args":[],"args_string":" : UInt32?","source_link":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta.cr#L5","def":{"name":"height","args":[],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"UInt32 | ::Nil","visibility":"Public","body":"@height"}},{"id":"initial_pos:Int32-instance-method","html_id":"initial_pos:Int32-instance-method","name":"initial_pos","doc":null,"summary":null,"abstract":false,"args":[],"args_string":" : Int32","source_link":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta.cr#L6","def":{"name":"initial_pos","args":[],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"@initial_pos"}},{"id":"width:UInt32?-instance-method","html_id":"width:UInt32?-instance-method","name":"width","doc":null,"summary":null,"abstract":false,"args":[],"args_string":" : UInt32?","source_link":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta.cr#L4","def":{"name":"width","args":[],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"UInt32 | ::Nil","visibility":"Public","body":"@width"}}],"macros":[],"types":[]},{"html_id":"fastimage/FastImage/PNG","path":"FastImage/PNG.html","kind":"struct","full_name":"FastImage::PNG","name":"PNG","abstract":false,"superclass":{"html_id":"fastimage/FastImage/Meta","kind":"struct","full_name":"FastImage::Meta","name":"Meta"},"ancestors":[{"html_id":"fastimage/FastImage/Meta","kind":"struct","full_name":"FastImage::Meta","name":"Meta"},{"html_id":"fastimage/Struct","kind":"struct","full_name":"Struct","name":"Struct"},{"html_id":"fastimage/Value","kind":"struct","full_name":"Value","name":"Value"},{"html_id":"fastimage/Object","kind":"class","full_name":"Object","name":"Object"}],"locations":[{"filename":"src/fastimage/meta/png.cr","line_number":2,"url":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta/png.cr#L2"}],"repository_name":"fastimage","program":false,"enum":false,"alias":false,"aliased":"","const":false,"constants":[{"id":"MAGICK","name":"MAGICK","value":"Bytes[137, 80]","doc":null,"summary":null}],"included_modules":[],"extended_modules":[],"subclasses":[],"including_types":[],"namespace":{"html_id":"fastimage/FastImage","kind":"class","full_name":"FastImage","name":"FastImage"},"doc":null,"summary":null,"class_methods":[],"constructors":[],"instance_methods":[{"id":"type-instance-method","html_id":"type-instance-method","name":"type","doc":null,"summary":null,"abstract":false,"args":[],"args_string":"","source_link":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta/png.cr#L2","def":{"name":"type","args":[],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"(\"FastImage::PNG\".gsub(/.*::/, \"\")).downcase"}}],"macros":[],"types":[]},{"html_id":"fastimage/FastImage/PSD","path":"FastImage/PSD.html","kind":"struct","full_name":"FastImage::PSD","name":"PSD","abstract":false,"superclass":{"html_id":"fastimage/FastImage/Meta","kind":"struct","full_name":"FastImage::Meta","name":"Meta"},"ancestors":[{"html_id":"fastimage/FastImage/Meta","kind":"struct","full_name":"FastImage::Meta","name":"Meta"},{"html_id":"fastimage/Struct","kind":"struct","full_name":"Struct","name":"Struct"},{"html_id":"fastimage/Value","kind":"struct","full_name":"Value","name":"Value"},{"html_id":"fastimage/Object","kind":"class","full_name":"Object","name":"Object"}],"locations":[{"filename":"src/fastimage/meta/psd.cr","line_number":2,"url":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta/psd.cr#L2"}],"repository_name":"fastimage","program":false,"enum":false,"alias":false,"aliased":"","const":false,"constants":[],"included_modules":[],"extended_modules":[],"subclasses":[],"including_types":[],"namespace":{"html_id":"fastimage/FastImage","kind":"class","full_name":"FastImage","name":"FastImage"},"doc":null,"summary":null,"class_methods":[],"constructors":[],"instance_methods":[{"id":"type-instance-method","html_id":"type-instance-method","name":"type","doc":null,"summary":null,"abstract":false,"args":[],"args_string":"","source_link":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta/psd.cr#L2","def":{"name":"type","args":[],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"(\"FastImage::PSD\".gsub(/.*::/, \"\")).downcase"}}],"macros":[],"types":[]},{"html_id":"fastimage/FastImage/SVG","path":"FastImage/SVG.html","kind":"struct","full_name":"FastImage::SVG","name":"SVG","abstract":false,"superclass":{"html_id":"fastimage/FastImage/Meta","kind":"struct","full_name":"FastImage::Meta","name":"Meta"},"ancestors":[{"html_id":"fastimage/FastImage/Meta","kind":"struct","full_name":"FastImage::Meta","name":"Meta"},{"html_id":"fastimage/Struct","kind":"struct","full_name":"Struct","name":"Struct"},{"html_id":"fastimage/Value","kind":"struct","full_name":"Value","name":"Value"},{"html_id":"fastimage/Object","kind":"class","full_name":"Object","name":"Object"}],"locations":[{"filename":"src/fastimage/meta/svg.cr","line_number":2,"url":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta/svg.cr#L2"}],"repository_name":"fastimage","program":false,"enum":false,"alias":false,"aliased":"","const":false,"constants":[],"included_modules":[],"extended_modules":[],"subclasses":[],"including_types":[],"namespace":{"html_id":"fastimage/FastImage","kind":"class","full_name":"FastImage","name":"FastImage"},"doc":null,"summary":null,"class_methods":[],"constructors":[],"instance_methods":[{"id":"type-instance-method","html_id":"type-instance-method","name":"type","doc":null,"summary":null,"abstract":false,"args":[],"args_string":"","source_link":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta/svg.cr#L2","def":{"name":"type","args":[],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"(\"FastImage::SVG\".gsub(/.*::/, \"\")).downcase"}}],"macros":[],"types":[]},{"html_id":"fastimage/FastImage/TIFF","path":"FastImage/TIFF.html","kind":"struct","full_name":"FastImage::TIFF","name":"TIFF","abstract":false,"superclass":{"html_id":"fastimage/FastImage/Meta","kind":"struct","full_name":"FastImage::Meta","name":"Meta"},"ancestors":[{"html_id":"fastimage/FastImage/Meta","kind":"struct","full_name":"FastImage::Meta","name":"Meta"},{"html_id":"fastimage/Struct","kind":"struct","full_name":"Struct","name":"Struct"},{"html_id":"fastimage/Value","kind":"struct","full_name":"Value","name":"Value"},{"html_id":"fastimage/Object","kind":"class","full_name":"Object","name":"Object"}],"locations":[{"filename":"src/fastimage/meta/tiff.cr","line_number":2,"url":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta/tiff.cr#L2"}],"repository_name":"fastimage","program":false,"enum":false,"alias":false,"aliased":"","const":false,"constants":[],"included_modules":[],"extended_modules":[],"subclasses":[],"including_types":[],"namespace":{"html_id":"fastimage/FastImage","kind":"class","full_name":"FastImage","name":"FastImage"},"doc":null,"summary":null,"class_methods":[],"constructors":[],"instance_methods":[{"id":"type-instance-method","html_id":"type-instance-method","name":"type","doc":null,"summary":null,"abstract":false,"args":[],"args_string":"","source_link":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta/tiff.cr#L2","def":{"name":"type","args":[],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"(\"FastImage::TIFF\".gsub(/.*::/, \"\")).downcase"}}],"macros":[],"types":[]},{"html_id":"fastimage/FastImage/WEBP","path":"FastImage/WEBP.html","kind":"struct","full_name":"FastImage::WEBP","name":"WEBP","abstract":false,"superclass":{"html_id":"fastimage/FastImage/Meta","kind":"struct","full_name":"FastImage::Meta","name":"Meta"},"ancestors":[{"html_id":"fastimage/FastImage/Meta","kind":"struct","full_name":"FastImage::Meta","name":"Meta"},{"html_id":"fastimage/Struct","kind":"struct","full_name":"Struct","name":"Struct"},{"html_id":"fastimage/Value","kind":"struct","full_name":"Value","name":"Value"},{"html_id":"fastimage/Object","kind":"class","full_name":"Object","name":"Object"}],"locations":[{"filename":"src/fastimage/meta/webp.cr","line_number":2,"url":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta/webp.cr#L2"}],"repository_name":"fastimage","program":false,"enum":false,"alias":false,"aliased":"","const":false,"constants":[{"id":"MAGICK","name":"MAGICK","value":"Bytes[82, 73, 70, 70]","doc":null,"summary":null},{"id":"VP8","name":"VP8","value":"Bytes[86, 80, 56, 32]","doc":"VP8 chunk ID","summary":"<p>VP8 chunk ID</p>"},{"id":"VP8L","name":"VP8L","value":"Bytes[86, 80, 56, 76]","doc":"VP8L chunk ID","summary":"<p>VP8L chunk ID</p>"},{"id":"VP8X","name":"VP8X","value":"Bytes[86, 80, 56, 88]","doc":"VP8L chunk ID","summary":"<p>VP8L chunk ID</p>"}],"included_modules":[],"extended_modules":[],"subclasses":[],"including_types":[],"namespace":{"html_id":"fastimage/FastImage","kind":"class","full_name":"FastImage","name":"FastImage"},"doc":null,"summary":null,"class_methods":[],"constructors":[],"instance_methods":[{"id":"type-instance-method","html_id":"type-instance-method","name":"type","doc":null,"summary":null,"abstract":false,"args":[],"args_string":"","source_link":"https://github.com/jetrockets/fastimage.cr/blob/v0.2.1/src/fastimage/meta/webp.cr#L2","def":{"name":"type","args":[],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"(\"FastImage::WEBP\".gsub(/.*::/, \"\")).downcase"}}],"macros":[],"types":[]}]}]}})