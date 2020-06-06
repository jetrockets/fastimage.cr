require "base64"
require "uri"
require "http/client"

require "./fastimage/meta"

class FastImage
  class Error < Exception; end

  class FormatError < Error; end

  getter meta : Meta? = nil

  def self.dimensions(source : URI | String | IO)
    new(source).meta.try &.dimensions
  end

  def self.type(source : URI | String | IO)
    new(source, type_only: true).meta.try &.type
  end

  def initialize(source : String, **options)
    if source.starts_with?("data:")
      fetch_using_base64(source, **options)
    else
      initialize(URI.parse(source), **options)
    end
  end

  def initialize(uri : URI, **options)
    if uri.scheme == "http" || uri.scheme == "https"
      fetch_using_http(uri, **options)
    elsif (uri.scheme.nil? || uri.scheme == "file") && !uri.path.nil?
      fetch_using_file(uri, **options)
    end
  end

  def initialize(io : IO, **options)
    fetch_using_io(io, **options)
  end

  private def fetch_using_base64(enc : String, **options)
    data = enc.split(',')[1]
    fetch_using_io(IO::Memory.new(Base64.decode_string(data)))
  end

  private def fetch_using_io(io : IO, **options)
    begin
      io.rewind unless io.pos.zero?
    rescue _e : IO::Error
    end

    @meta = parse_type(io, **options)
  end

  private def fetch_using_http(uri : URI, **options)
    HTTP::Client.get(uri.to_s) do |response|
      @meta = parse_type(response.body_io, **options) if response.status == HTTP::Status::OK
    end
  end

  private def fetch_using_file(uri : URI, **options)
    File.open(uri.to_s) do |file|
      @meta = parse_type(file, **options)
    end
  end

  private def parse_type(io : IO, type_only = false, **options)
    tmp = Bytes.new(2)
    io.read(tmp)

    case tmp
    when BMP::MAGICK
      type_only ? BMP.new : BMP.new(io, 2)
    when GIF::MAGICK
      type_only ? GIF.new : GIF.new(io, 2)
    when PNG::MAGICK
      type_only ? PNG.new : PNG.new(io, 2)
    when JPEG::MAGICK
      type_only ? JPEG.new : JPEG.new(io, 2)
    when PSD::MAGICK
      type_only ? PSD.new : PSD.new(io, 2)
    when [77, 77]
      type_only ? TIFF.new : TIFF.new(io, 2)
    when ICO::MAGICK
      byte = io.read_byte
      if byte == 1
        type_only ? ICO.new : ICO.new(io, 3)
      elsif byte == 2
        type_only ? CUR.new : CUR.new(io, 3)
      else
        nil
      end
    when WEBP::MAGICK[0..1]
      io.read(tmp)

      if tmp == WEBP::MAGICK[2..3]
        type_only ? WEBP.new : WEBP.new(io, 4)
      end
    when [60, 63], [60, 33] # <?xml, <!D
      # if cache.gets(250).includes?("<svg")
      #   type_only ? SVG.new : SVG.new(cache)
      # end
    when [60, 115]
      type_only ? SVG.new : SVG.new(io, 3)
    else
      nil
    end
  end
end
