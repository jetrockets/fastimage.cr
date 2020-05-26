require "uri"

class FastImage
  getter :uri

  getter size : Array(Int32)?
  getter type : String?

  def self.size(uri : URI | String)
    new(uri).size
  end

  def self.type(uri : URI | String)
    new(uri).type
  end

  def initialize(uri : String)
    @uri = nil
    initialize(URI.parse(uri))
  end

  def initialize(@uri : URI)
    if uri.scheme == "http" || uri.scheme == "https"
      fetch_using_http
    elsif (uri.scheme.nil? || uri.scheme == "file") && !uri.path.nil?
      fetch_using_read
    end
  end

  def fetch_using_http
    # pp! uri
    HTTP::Client.get(uri.to_s, headers: HTTP::Headers{"Accept-Encoding" => "identity"}) do |response|
      parse_type(response.body_io)
    end
  end

  def fetch_using_read
    File.open(uri.to_s) do |file|
      parse_type(file)
    end
  end

  def parse_type(io : IO)
    slice = Bytes.new(16)
    io.read(slice)

    # pp! slice
    case slice[0..1]
    when Bytes[66, 77]
      @type = "bmp"
    when Bytes[71, 73]
      @type = "gif"
    when Bytes[137, 80]
      @type = "png"

      @width = UInt32.from_io io, IO::ByteFormat::BigEndian
      @height = UInt32.from_io io, IO::ByteFormat::BigEndian
    when Bytes[255, 216]
      @type = "jpeg"
    when Bytes[56, 66]
      @type = "psd"
    when Bytes[77, 77]
      @type = "tiff"
    when Bytes[0, 0]
      if slice[2] == 1
        @type = "ico"
      elsif slice[2] == 2
        @type = "cur"
      else
        nil
      end
    when Bytes[82, 73]
      @type = "webp" if slice[8..11] == Bytes[87, 69, 66, 80]
    when Bytes[60, 63], Bytes[60, 33] # <?xml, <!D
      slice = Bytes.new(250)

      io.rewind
      io.read(slice)
      @type = "svg" if String.new(slice).includes?("<svg")
    when Bytes[60, 115]
      @type = "svg"
    else
      @type = nil
    end
  end
end
