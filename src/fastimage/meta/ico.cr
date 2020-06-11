class FastImage
  struct ICO < Meta
    MAGICK = Bytes[0, 0]

    private def decode(io : IO)
      io.skip(relative(4))
      icons = IO::ByteFormat::LittleEndian.decode(UInt16, io)

      tmp = Bytes.new(16)
      sizes = icons.times.map do
        io.read(tmp)
        current = IO::ByteFormat::LittleEndian.decode(UInt8, tmp)
        current.zero? ? 256 : current
      end

      @width = @height = sizes.max.to_u16
    end
  end
end
