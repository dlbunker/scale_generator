module ScaleDSL
  def scale(scale_label, &block)
    scale_ctx = ScaleContext.new scale_label
    scale_ctx.instance_exec &block
    scale_ctx.scale_hash
  end

  class ScaleContext
    attr_reader :scale_hash

    def initialize(scale_label)
      @scale_hash = {:label => scale_label}
    end

    def inst_string(string_num, &block)
      str_ctx = StringContext.new
      str_ctx.instance_exec &block
      string_hash = {:frets => str_ctx.fret_array, :fingers => str_ctx.finger_array, :intervals => str_ctx.interval_array}
      @scale_hash[string_num] = string_hash
    end
  end

  class StringContext
    attr_reader :fret_array
    attr_reader :finger_array
    attr_reader :interval_array

    def initialize()
      @fret_array = []
      @finger_array = []
    end

    def frets(*frets)
      @fret_array = frets
    end

    def fingering(*fingers)
      @finger_array = fingers
    end

    def intervals(*vals)
      @interval_array = vals
    end
  end
end

include ScaleDSL
