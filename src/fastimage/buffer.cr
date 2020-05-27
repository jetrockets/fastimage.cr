class FastImage
  class Buffer
    getter memory : IO::Memory

    DEFAULT_CAPACITY = 12

    def initialize(@io : IO)
      @memory = IO::Memory.new(DEFAULT_CAPACITY)
      IO.copy(@io, memory, DEFAULT_CAPACITY)
    end

    delegate rewind, to: @memory

    def bytes(range : Range(Int, Int))
      if range.end
        limit = range.exclusive? ? range.end : range.end + 1

        extend_to(limit)
      end

      memory.to_slice[range]
    end

    def byte(at : Int)
      extend_to(at + 1)
      memory.to_slice[at]
    end

    def gets(limit : Int)
      extend_to(limit)

      String.new(memory.to_slice[0...limit])
    end

    private def extend_to(limit)
      if limit > memory.size
        memory.skip_to_end
        IO.copy(@io, memory, (limit - memory.size))
      end
    end
  end
end
