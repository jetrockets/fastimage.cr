class FastImage
  # Struct to support different file types
  abstract struct Meta
    getter width : UInt16? = nil
    getter height : UInt16? = nil
    getter initial_pos = 0

    def initialize
    end

    # Creates a new `FastImage::Meta` struct.
    # *initial_pos* should be passed because some IOs (eg. `HTTP`) does not support `IO#pos` method.
    def initialize(io : IO, initial_pos = 0)
      @initial_pos = initial_pos

      decode(io)
    end

    macro inherited
      def type
        "{{@type.name.id}}".gsub(/.*::/, "").downcase
      end
    end

    # Returns an `Array` of `#width` and `#height`.
    def dimensions
      [width, height]
    end

    private abstract def decode(io : IO)

    private def relative(pos : Int)
      pos - @initial_pos
    end

    private def relative(range : Range(Int32, Int32))
      ((range.begin - @initial_pos)..(range.end - @initial_pos))
    end
  end
end

require "./simple_exif"
require "./meta/*"
