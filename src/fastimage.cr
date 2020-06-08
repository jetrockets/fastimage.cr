require "base64"
require "uri"
require "http/client"

require "./fastimage/meta"

class FastImage
  class Error < Exception; end

  class FormatError < Error; end

  class UnknownTypeError < Error; end

  getter? type_only = false
  getter? raise_on_failure = false

  def self.dimensions(source : URI | String | IO)
    new.process(source).try &.dimensions
  end

  def self.dimensions!(source : URI | String | IO)
    new(
      raise_on_failure: true
    ).process(source).try &.dimensions
  end

  def self.type(source : URI | String | IO)
    new(
      type_only: true
    ).process(source).try &.type
  end

  def self.type!(source : URI | String | IO)
    new(
      type_only: true,
      raise_on_failure: true
    ).process(source).try &.type
  end

  def initialize(**options)
    @type_only = options[:type_only]? || false
    @raise_on_failure = options[:raise_on_failure]? || false
  end

  def process(source : String) : FastImage::Meta?
    if source.starts_with?("data:")
      fetch_using_base64(source)
    else
      process(URI.parse(source))
    end
  end

  def process(uri : URI) : FastImage::Meta?
    if uri.scheme == "http" || uri.scheme == "https"
      fetch_using_http(uri)
    elsif (uri.scheme.nil? || uri.scheme == "file") && !uri.path.nil?
      fetch_using_file(uri)
    end
  end

  def process(io : IO) : FastImage::Meta?
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
      parse_type(response.body_io) if response.status == HTTP::Status::OK
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
      type_only? ? BMP.new : BMP.new(io, 2)
    when GIF::MAGICK
      type_only? ? GIF.new : GIF.new(io, 2)
    when PNG::MAGICK
      type_only? ? PNG.new : PNG.new(io, 2)
    when JPEG::MAGICK
      type_only? ? JPEG.new : JPEG.new(io, 2)
    when PSD::MAGICK
      type_only? ? PSD.new : PSD.new(io, 2)
    when [77, 77]
      type_only? ? TIFF.new : TIFF.new(io, 2)
    when ICO::MAGICK
      byte = io.read_byte
      if byte == 1
        type_only? ? ICO.new : ICO.new(io, 3)
      elsif byte == 2
        type_only? ? CUR.new : CUR.new(io, 3)
      else
        nil
      end
    when WEBP::MAGICK[0..1]
      io.read(tmp)

      if tmp == WEBP::MAGICK[2..3]
        type_only? ? WEBP.new : WEBP.new(io, 4)
      end
    when [60, 63], [60, 33] # <?xml, <!D
      # if cache.gets(250).includes?("<svg")
      #   type_only? ? SVG.new : SVG.new(cache)
      # end
    when [60, 115]
      type_only? ? SVG.new : SVG.new(io, 3)
    else
      raise_on_failure? ? raise UnknownTypeError.new : nil
    end
  end
end
