class FastImage
  struct GIF < Meta
    MAGICK = [71, 73]

    private def decode(io : IO)
      tmp = Bytes.new(10 - initial_pos)
      io.read_fully(tmp)

      @width = IO::ByteFormat::SystemEndian.decode(UInt16, tmp[relative(6..7)]).to_u32
      @height = IO::ByteFormat::SystemEndian.decode(UInt16, tmp[relative(8..9)]).to_u32
    end
  end
end
