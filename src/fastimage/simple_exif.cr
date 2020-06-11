class FastImage
  abstract class SimpleExif
    struct Orientation
      getter value : UInt8

      def initialize(value)
        @value = value.to_u8
      end

      def rotated?
        value && value.not_nil! >= 5
      end
    end

    TAG_MARK = 42

    def self.decode(io : IO, byte_format)
      width : UInt16? = nil
      height : UInt16? = nil
      orientation : Orientation? = nil

      validate_tag_mark!(io, byte_format)

      offset = byte_format.decode(UInt32, io)
      io.skip(offset - 8)

      byte_format.decode(UInt16, io).times do
        type = byte_format.decode(UInt16, io)

        io.skip(6)

        case type
        when 0x0100
          width = byte_format.decode(UInt16, io)
          io.skip(2)
        when 0x0101
          height = byte_format.decode(UInt16, io)
          io.skip(2)
        when 0x0112
          orientation = Orientation.new(byte_format.decode(UInt16, io))
          io.skip(2)
        else
          io.skip(4)
        end

        break if width && height && orientation
      end

      orientation ||= Orientation.new(1)

      return width, height, orientation
    end

    private def self.validate_tag_mark!(io, byte_format)
      raise FormatError.new(
        "Exif should start with [0x42, 0x00] or [0x00, 0x42]"
      ) unless byte_format.decode(UInt16, io) == TAG_MARK
    end
  end
end
