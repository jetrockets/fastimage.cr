require "uri"
require "http/client"

require "./fastimage/meta"

class FastImage
  class Error < Exception; end

  class FormatError < Error; end

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
      fetch_using_file(**options)
    end
  end

  def fetch_using_http(**options)
    HTTP::Client.get(uri.to_s, headers: HTTP::Headers{"Accept-Encoding" => "identity"}) do |response|
      @meta = parse_type(response.body_io, **options)
    end
  end

  def fetch_using_file(**options)
    File.open(uri.to_s) do |file|
      @meta = parse_type(file, **options)
    end
  end

  def parse_type(io : IO, type_only = false, **options)
    tmp = Bytes.new(2)
    io.read(tmp)
    # tmp = [io.read_byte, io.read_byte]
    case tmp
    when BMP::MAGICK
      type_only ? BMP.new : BMP.new(io, 2)
    when GIF::MAGICK
      type_only ? GIF.new : GIF.new(io, 2)
    when PNG::MAGICK
      type_only ? PNG.new : PNG.new(io, 2)
    when JPEG::MAGICK
      type_only ? JPEG.new : JPEG.new(io, 2)
    when [56, 66]
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
