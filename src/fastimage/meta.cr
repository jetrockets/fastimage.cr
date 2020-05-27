require "./buffer"

class FastImage
  abstract struct Meta
    getter width : UInt32? = nil
    getter height : UInt32? = nil

    def initialize
    end

    def initialize(buffer : FastImage::Buffer)
      decode(buffer)
    end

    macro inherited
      def type
        "{{@type.name.id}}".gsub(/.*::/, "").downcase
      end
    end

    def dimensions
      [width, height]
    end

    private abstract def decode(buffer : FastImage::Buffer)
  end

  struct BMP < Meta
    MAGICK = "BM".to_slice

    private def decode(buffer : FastImage::Buffer)
      header = IO::ByteFormat::SystemEndian.decode(UInt8, buffer.bytes(14..15))

      if header >= 40
        @width = IO::ByteFormat::LittleEndian.decode(Int32, buffer.bytes(18..21)).abs.to_u32
        @height = IO::ByteFormat::LittleEndian.decode(Int32, buffer.bytes(22..25)).abs.to_u32
      else
        @width = IO::ByteFormat::LittleEndian.decode(UInt8, buffer.bytes(18..19)).to_u32
        @height = IO::ByteFormat::LittleEndian.decode(UInt8, buffer.bytes(20..21)).to_u32
      end
    end
  end

  struct GIF < Meta
    MAGICK = Bytes[71, 73]

    private def decode(buffer : FastImage::Buffer)
      @width = IO::ByteFormat::BigEndian.decode(UInt16, buffer.bytes(6..7)).to_u32
      @height = IO::ByteFormat::BigEndian.decode(UInt16, buffer.bytes(8..9)).to_u32
    end
  end

  struct PNG < Meta
    MAGICK = "\x89P".to_slice

    private def decode(buffer : FastImage::Buffer)
      @width = IO::ByteFormat::BigEndian.decode(UInt32, buffer.bytes(16..19))
      @height = IO::ByteFormat::BigEndian.decode(UInt32, buffer.bytes(20..23))
    end
  end

  struct JPEG < Meta
    # MAGICK = "BM".bytes

    private def decode(buffer : FastImage::Buffer)
    end
  end

  struct PSD < Meta
    # MAGICK = "BM".bytes

    private def decode(buffer : FastImage::Buffer)
    end
  end

  struct TIFF < Meta
    # MAGICK = "BM".bytes

    private def decode(buffer : FastImage::Buffer)
    end
  end

  struct ICO < Meta
    # MAGICK = "BM".bytes

    private def decode(buffer : FastImage::Buffer)
    end
  end

  struct CUR < Meta
    # MAGICK = "BM".bytes

    private def decode(buffer : FastImage::Buffer)
    end
  end

  struct WEBP < Meta
    # MAGICK = "BM".bytes

    private def decode(buffer : FastImage::Buffer)
    end
  end

  struct SVG < Meta
    # MAGICK = "BM".bytes

    private def decode(buffer : FastImage::Buffer)
    end
  end
end
