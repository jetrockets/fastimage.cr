class FastImage
  struct WEBP < Meta
    MAGICK = Bytes[82, 73, 70, 70]

    # VP8 chunk ID
    VP8 = Bytes[86, 80, 56, 32]

    # VP8L chunk ID
    VP8L = Bytes[86, 80, 56, 76]

    # VP8L chunk ID
    VP8X = Bytes[86, 80, 56, 88]

    private def decode(io : IO)
      tmp = Bytes.new(16 - initial_pos)
      io.read(tmp)

      case tmp[relative(12..15)]
      when VP8
        decode_vp8(io)
      when VP8L
        decode_vp8l(io)
      when VP8X
        decode_vp8x(io)
      else
        raise FormatError.new(
          "Unsupported WEBP chunk: '#{tmp[relative(12..15)]}'"
        )
      end
    end

    private def decode_vp8(io : IO)
      length = IO::ByteFormat::LittleEndian.decode(Int32, io)
      raise FormatError.new("Invalid WEBP chunk length: '#{length}") if length < 0

      io.skip(6)

      @width = IO::ByteFormat::LittleEndian.decode(UInt16, io).to_u32
      @height = IO::ByteFormat::LittleEndian.decode(UInt16, io).to_u32
    end

    private def decode_vp8l(io : IO)
      length = IO::ByteFormat::LittleEndian.decode(Int32, io)
      raise FormatError.new("Invalid WEBP chunk length: '#{length}") if length < 0

      io.skip(1) # 0x2f

      tmp = Bytes.new(4)
      io.read(tmp)

      tmp = tmp.map { |element| element.to_u32 }

      @width = (1 + (((tmp[1] & 0x3f) << 8) | tmp[0])).to_u32
      @height = (1 + (((tmp[3] & 0xF) << 10) | (tmp[2] << 2) | ((tmp[1] & 0xC0) >> 6))).to_u32
    end

    private def decode_vp8x(io : IO)
      length = IO::ByteFormat::LittleEndian.decode(Int32, io)
      raise FormatError.new("Invalid WEBP chunk length: '#{length}") if length < 0

      # TODO parse flag and EXIF here
      io.skip(4)

      tmp = Bytes.new(6)
      io.read(tmp)

      tmp = tmp.map { |element| element.to_u32 }

      @width = (1 + tmp[0] + (tmp[1] << 8) + (tmp[2] << 16)).to_u32
      @height = (1 + tmp[3] + (tmp[4] << 8) + (tmp[5] << 16)).to_u32
    end
  end
end
