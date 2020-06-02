class FastImage
  struct BMP < Meta
    MAGICK = "BM".bytes

    private def decode(io : IO)
      tmp = Bytes.new(26 - initial_pos)
      io.read_fully(tmp)

      header = IO::ByteFormat::SystemEndian.decode(UInt8, tmp[relative(14..15)])

      if header >= 40
        @width = IO::ByteFormat::LittleEndian.decode(Int32, tmp[relative(18..21)]).abs.to_u32
        @height = IO::ByteFormat::LittleEndian.decode(Int32, tmp[relative(22..25)]).abs.to_u32
      else
        @width = IO::ByteFormat::LittleEndian.decode(UInt8, tmp[relative(18..19)]).to_u32
        @height = IO::ByteFormat::LittleEndian.decode(UInt8, tmp[relative(20..25)]).to_u32
      end
    end
  end
end
