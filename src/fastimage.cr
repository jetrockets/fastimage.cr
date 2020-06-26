require "base64"
require "uri"
require "http/client"

require "./fastimage/meta"

class FastImage
  class Error < Exception; end

  class FormatError < Error; end

  class UnknownTypeError < Error; end

  class UnknownSourceError < Error; end

  class ReadError < Error; end

  getter? type_only = false

  # Initializes `FastImage` and tries to fetch image dimensions.
  # Returns `nil` if dimensions cannot be fetched.
  #
  # ```
  # FastImage.dimensions("https://file-examples.com/wp-content/uploads/2017/10/file_example_PNG_3MB.png")
  # => [2200, 1467]
  # ```
  def self.dimensions(source : URI | String | IO) : Tuple(UInt16?, UInt16?)?
    new.process(source).try &.dimensions
  rescue FormatError
    nil
  rescue UnknownTypeError
    nil
  rescue UnknownSourceError
    nil
  rescue ReadError
    nil
  end

  # Initializes `FastImage` and tries to fetch image dimensions.
  # Raises exception inherited from `FastImage::Error` (`FastImage::FormatError`, `UnknownTypeError`, `UnknownSourceError`, `ReadError`)
  # if dimensions cannot be fetched.
  def self.dimensions!(source : URI | String | IO) : Tuple(UInt16, UInt16)
    dimensions = new.process(source).not_nil!.dimensions
    raise FastImage::Error.new("Cannot fetch dimensions for #{source}") if dimensions[0].nil? || dimensions[1].nil?

    dimensions.map &.not_nil!
  end

  # Initializes `FastImage` and tries to determine image type.
  # Returns `nil` if type cannot be determined.
  #
  # ```
  # FastImage.type("https://file-examples.com/wp-content/uploads/2017/10/file_example_PNG_3MB.png")
  # => "png"
  # ```
  def self.type(source : URI | String | IO) : String?
    new(
      type_only: true
    ).process(source).type
  rescue FormatError
    nil
  rescue UnknownTypeError
    nil
  rescue UnknownSourceError
    nil
  rescue ReadError
    nil
  end

  # Initializes `FastImage` and tries to determine image type.
  # Raises exception inherited from `FastImage::Error` (`FastImage::FormatError`, `UnknownTypeError`, `UnknownSourceError`, `ReadError`)
  # if type cannot be determined.
  def self.type!(source : URI | String | IO) : String
    new(
      type_only: true,
    ).process(source).not_nil!.type
  end

  def initialize(**options)
    @type_only = options[:type_only]? || false
  end

  def process(source : String) : FastImage::Meta
    if source.starts_with?("data:")
      fetch_using_base64(source)
    else
      process(URI.parse(source))
    end
  end

  def process(uri : URI) : FastImage::Meta
    if uri.scheme == "http" || uri.scheme == "https"
      fetch_using_http(uri)
    elsif (uri.scheme.nil? || uri.scheme == "file") && !uri.path.nil?
      fetch_using_file(uri)
    else
      raise UnknownSourceError.new("Seems that URI is not a HTTP/HTTPs link and not a file path")
    end
  end

  def process(io : IO) : FastImage::Meta
    fetch_using_io(io)
  end

  private def fetch_using_base64(enc : String)
    data = enc.split(',')[1]
    fetch_using_io(IO::Memory.new(Base64.decode_string(data)))
  end

  private def fetch_using_io(io : IO)
    begin
      io.rewind unless io.pos.zero?
    rescue _e : IO::Error
    end

    parse_type(io)
  end

  private def fetch_using_http(uri : URI)
    HTTP::Client.get(uri.to_s) do |response|
      if response.status == HTTP::Status::OK
        parse_type(response.body_io)
      else
        raise ReadError.new("HTTP status: #{response.status.to_i}")
      end
    end
  end

  private def fetch_using_file(uri : URI)
    File.open(uri.to_s) do |file|
      parse_type(file)
    end
  end

  private def parse_type(io : IO)
    tmp = Bytes.new(2)
    io.read(tmp)

    case tmp
    when BMP::MAGICK
      type_only? ? BMP.new : BMP.new(io, initial_pos: 2)
    when GIF::MAGICK
      type_only? ? GIF.new : GIF.new(io, initial_pos: 2)
    when PNG::MAGICK
      type_only? ? PNG.new : PNG.new(io, initial_pos: 2)
    when JPEG::MAGICK
      type_only? ? JPEG.new : JPEG.new(io, initial_pos: 2)
    when PSD::MAGICK
      type_only? ? PSD.new : PSD.new(io, initial_pos: 2)
    when TIFF::LittleEndian::MAGICK
      type_only? ? TIFF::LittleEndian.new : TIFF::LittleEndian.new(io, initial_pos: 2)
    when TIFF::BigEndian::MAGICK
      type_only? ? TIFF::BigEndian.new : TIFF::BigEndian.new(io, initial_pos: 2)
    when ICO::MAGICK
      byte = io.read_byte

      if byte == 1
        type_only? ? ICO.new : ICO.new(io, initial_pos: 3)
      elsif byte == 2
        type_only? ? CUR.new : CUR.new(io, initial_pos: 3)
      else
        raise UnknownTypeError.new
      end
    when WEBP::MAGICK[0..1]
      io.read(tmp)

      if tmp == WEBP::MAGICK[2..3]
        type_only? ? WEBP.new : WEBP.new(io, initial_pos: 4)
      else
        raise UnknownTypeError.new
      end
    when [60, 63], [60, 33] # <?xml, <!D
      # if cache.gets(250).includes?("<svg")
      #   type_only? ? SVG.new : SVG.new(cache)
      # end
      raise UnknownTypeError.new
    when [60, 115]
      type_only? ? SVG.new : SVG.new(io, initial_pos: 3)
    else
      raise UnknownTypeError.new
    end
  end
end
