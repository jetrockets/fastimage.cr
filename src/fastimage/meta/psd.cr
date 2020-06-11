class FastImage
  struct PSD < Meta
    MAGICK = Bytes[56, 66]

    private def decode(io : IO)
      tmp = Bytes.new(26 - initial_pos)
      io.read_fully(tmp)

      @height = IO::ByteFormat::BigEndian.decode(UInt32, tmp[relative(14..17)]).to_u16
      @width = IO::ByteFormat::BigEndian.decode(UInt32, tmp[relative(18..21)]).to_u16
    end
  end
end
