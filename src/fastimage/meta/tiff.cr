class FastImage
  struct TIFF::LittleEndian < Meta
    MAGICK = Bytes[0x49, 0x49]

    def type
      "tiff"
    end

    private def decode(io : IO)
      io.skip(relative(2))
      @width, @height, orientation = FastImage::SimpleExif.decode(io, IO::ByteFormat::LittleEndian)
      @width, @height = @height, @width if orientation.rotated?
    end
  end

  struct TIFF::BigEndian < Meta
    MAGICK = Bytes[0x4d, 0x4d]

    def type
      "tiff"
    end

    private def decode(io : IO)
      io.skip(relative(2))
      @width, @height, orientation = FastImage::SimpleExif.decode(io, IO::ByteFormat::BigEndian)
      @width, @height = @height, @width if orientation.rotated?
    end
  end
end
