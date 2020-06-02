class FastImage
  struct PNG < Meta
    MAGICK = Bytes[137, 80]

    private def decode(io : IO)
      tmp = Bytes.new(24 - initial_pos)
      io.read_fully(tmp)

      @width = IO::ByteFormat::BigEndian.decode(UInt32, tmp[relative(16..19)])
      @height = IO::ByteFormat::BigEndian.decode(UInt32, tmp[relative(20..23)])
    end
  end
end
