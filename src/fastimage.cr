require "uri"
require "http/client"

require "./fastimage/meta"

class FastImage
  getter :uri
  getter meta : Meta? = nil

  def self.dimensions(uri : URI | String)
    new(uri).meta.try &.dimensions
  end

  def self.type(uri : URI | String)
    new(uri, type_only: true).meta.try &.type
  end

  def initialize(uri : String, **options)
    @uri = nil
    initialize(URI.parse(uri), **options)
  end

  def initialize(@uri : URI, **options)
    if uri.scheme == "http" || uri.scheme == "https"
      fetch_using_http(**options)
    elsif (uri.scheme.nil? || uri.scheme == "file") && !uri.path.nil?
      fetch_using_read(**options)
    end
  end

  def fetch_using_http(**options)
    HTTP::Client.get(uri.to_s, headers: HTTP::Headers{"Accept-Encoding" => "identity"}) do |response|
      @meta = parse_type(Buffer.new(response.body_io), **options)
    end
  end

  def fetch_using_read(**options)
    File.open(uri.to_s) do |file|
      @meta = parse_type(Buffer.new(file), **options)
    end
  end

  def parse_type(buffer : Buffer, type_only = false, **options)
    case buffer.bytes(0..1)
    when BMP::MAGICK
      return type_only ? BMP.new : BMP.new(buffer)
    when Bytes[71, 73]
      return type_only ? GIF.new : GIF.new(buffer)
    when PNG::MAGICK
      return type_only ? PNG.new : PNG.new(buffer)
    when Bytes[255, 216]
      return type_only ? JPEG.new : JPEG.new(buffer)
    when Bytes[56, 66]
      return type_only ? PSD.new : PSD.new(buffer)
    when Bytes[77, 77]
      return type_only ? TIFF.new : TIFF.new(buffer)
    when Bytes[0, 0]
      if buffer.byte(2) == 1
        return type_only ? ICO.new : ICO.new(buffer)
      elsif buffer.byte(2) == 2
        return type_only ? CUR.new : CUR.new(buffer)
      else
        nil
      end
    when Bytes[82, 73]
      if buffer.bytes(8..11) == Bytes[87, 69, 66, 80]
        return type_only ? WEBP.new : WEBP.new(buffer)
      end
    when Bytes[60, 63], Bytes[60, 33] # <?xml, <!D
      if buffer.gets(250).includes?("<svg")
        return type_only ? SVG.new : SVG.new(buffer)
      end
    when Bytes[60, 115]
      return type_only ? SVG.new : SVG.new(buffer)
    end
  end

  # def parse_png(buffer : Buffer)
  #   width = buffer.u32(16, IO::ByteFormat::BigEndian)
  #   height = buffer.u32(20, IO::ByteFormat::BigEndian)

  #   @dimensions = [width, height]
  # end

  # def parse_gif(buffer : Buffer)
  #   width = buffer.u16(6, IO::ByteFormat::BigEndian).to_u32
  #   height = buffer.u16(8, IO::ByteFormat::BigEndian).to_u32

  #   @dimensions = [width, height]
  # end
end
