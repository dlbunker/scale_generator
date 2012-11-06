module ScaleGenerator
  class Dictionary
    
    GUITAR_TUNINGS = {
      :standard => ["E", "A", "D", "G", "B", "E"],
      :drop_d => ["D", "A", "D", "G", "B", "E"]
    }
    
    BASS_TUNINGS = {
      :standard => ["E", "A", "D", "G"]
    }

    MANDOLIN_TUNINGS = {
      :standard => ["G", "D", "A", "E"]
    }

    UKULELE_TUNINGS = {
      :c6 => ["G", "C", "E", "A"],
      :baritone => ["D", "G", "B", "E"]
    }

    private
      def self.normalize_frets(frets)
        join_with = frets.any? { |f| f && f >= 10 } ? "-" : ""
        frets.map { |f| f.nil? ? "x" : f.to_s }.join(join_with)
      end
  end
end