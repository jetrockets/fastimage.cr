class FastImage
  # Struct to support different file types parsing
  abstract struct Meta
    getter width : UInt32? = nil
    getter height : UInt32? = nil
    getter initial_pos = 0

    def initialize
    end

    # We pass original position to #initialize, because some IOs (like HTTP) does not support #pos
    def initialize(io : IO, initial_pos = 0)
      @initial_pos = initial_pos
      decode(io)
    end

    macro inherited
      def type
        "{{@type.name.id}}".gsub(/.*::/, "").downcase
      end
    end

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

require "./meta/*"
