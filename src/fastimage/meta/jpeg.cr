class FastImage
  struct JPEG < Meta
    MAGICK = Bytes[SEPARATOR, SOI_MARKER]

    SEPARATOR = 0xff

    # Start of image
    SOI_MARKER = 0xd8

    # End of image
    EOI_MARKER = 0xd9

    # Start of frame (baseline sequential)
    SOF_0_MARKER = 0xc0

    # Start of frame (progressive)
    SOF_2_MARKER = 0xc2

    # Restart (0)
    RST_0_MARKER = 0xd0

    # Restart (7)
    RST_7_MARKER = 0xd7

    # Comment
    COM_MARKER = 0xfe

    # Start of scans
    SOS_MARKER = 0xda

    private def decode(io : IO)
      orientation = nil

      while marker = read_next(io)
        case marker
        when 0x00
          next
        when SEPARATOR
          next
        when (RST_0_MARKER..RST_7_MARKER)
          next
        when (SOF_0_MARKER..SOF_2_MARKER)
          length = read_int(io)
          precision = io.read_byte
          @height = read_int(io)
          @width = read_int(io)
          components = io.read_byte.not_nil!

          validate_precision!(precision)
          validate_segment_length!(length, components)

          break
        when EOI_MARKER, SOS_MARKER
          break
        when COM_MARKER
          # TODO: parse comment information here
          io.skip(read_segment_remaining_length(io))
        when 0xE1 # APP1, contains EXIF tag
          length = read_segment_remaining_length(io)
          if io.read_string(4) == "Exif" && !orientation
            io.skip(2)

            tmp = Bytes.new(2)
            io.read(tmp)

            case tmp
            when TIFF::LittleEndian::MAGICK
              _, _, orientation = read_exif(io, length - 8, IO::ByteFormat::LittleEndian)
            when TIFF::BigEndian::MAGICK
              _, _, orientation = read_exif(io, length - 8, IO::ByteFormat::BigEndian)
            else
              raise FormatError.new("Byte format of Exif should be either Big or LittleEndian")
            end
          else
            io.skip(length - 4)
          end
        else
          io.skip(read_segment_remaining_length(io))
        end
      end

      if orientation && orientation.rotated?
        @width, @height = @height, @width
      end
    end

    private def read_next(io : IO)
      tmp = [io.read_byte, io.read_byte]

      # Read next bytes if we are at the beginning of the IO
      if tmp[0] == SEPARATOR && tmp[1] == SOI_MARKER
        tmp = [io.read_byte, io.read_byte]
      end

      while tmp[0] != 0xff
        tmp[0] = tmp[1]
        tmp[1] = io.read_byte
      end

      tmp[1]
    end

    private def read_int(io : IO)
      UInt16.from_io(io, IO::ByteFormat::BigEndian).to_u16
    end

    private def read_segment_remaining_length(io : IO)
      # We remove 2, because we are already at the first byte of segment
      read_int(io) - 2
    end

    private def read_exif(io, length, byte_format)
      memory = IO::Memory.new(length)
      IO.copy(io, memory, length)
      memory.rewind

      FastImage::SimpleExif.decode(memory, byte_format)
    end

    private def validate_precision!(precision)
      raise FormatError.new(
        "JPEG with data precision other then 8 bits are not supported"
      ) unless precision == 8
    end

    private def validate_segment_length!(length, components)
      raise FormatError.new(
        "Length of JPEG segment should equal 8 + number_of_components * 3"
      ) unless (length == 8 + components * 3)
    end
  end
end
