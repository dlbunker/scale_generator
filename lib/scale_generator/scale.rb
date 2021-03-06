require 'scale_generator/png_formatter'
require 'scale_generator/dictionary'

module ScaleGenerator
  class Scale
    def initialize(scale_hash, tuning = nil)
      @scale_hash = scale_hash
    end
  
    def to_png(show_intervals = false, options = {})
      tuning = (options[:tuning].nil?) ? ScaleGenerator::Dictionary::GUITAR_TUNINGS[:standard] : options[:tuning]

      ScaleGenerator::PNGFormatter.new(@scale_hash, tuning).print(options, show_intervals)
    end
    
    def name
      ScaleGenerator::Dictionary.name_for(frets)
    end
  
  end
end