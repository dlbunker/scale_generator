require 'rvg/rvg' # rmagick's RVG (Ruby Vector Graphics) 

module ScaleGenerator
  Magick::RVG::dpi = 72
  # Formats a single fingering as png data
  class PNGFormatter

    def initialize(scale_hash, strings)
      @scale_hash = scale_hash
      @strings = strings
    end

    def print(options={}, show_intervals = false)
      @label = @scale_hash[:label]
      @show_intervals = show_intervals
      @hide_fret_numbers = options[:hide_fret_numbers]
      @frets = []
      
      @scale_hash.each do |key, val| 
        if key.is_a?(Numeric)
          @frets << val[:frets]
        end
      end
      
      @max_fret = @frets.flatten.max
      @min_fret = @frets.flatten.min
      @min_fret = 1 if @min_fret == 0
      @min_fret = 1 if @max_fret <= 4
      @number_of_frets = [@max_fret - @min_fret + 1, 4].max

      get_png_data
    end

    private

    def get_png_data
      width = 160 + (@strings.size * 40)
      height = 340
      
      rvg = Magick::RVG.new(40 + (@strings.size * 40), 210).viewbox(0,0,width,height) do |canvas|
        canvas.background_fill = 'white'
        
        width_of_chord = 20 + (@strings.size * 40)
        margin_side_of_chord = (width - width_of_chord) / 2

        height_of_chord = 200
        margin_top_of_chord = ((height - height_of_chord) * 2 / 3.0).floor
        margin_bottom_of_chord = ((height - height_of_chord) / 3.0).ceil
        
        height_of_fret = height_of_chord / @number_of_frets
        radius_of_finger = (height_of_fret * 0.6) / 2
        
        width_of_fret = width_of_chord / (@strings.size - 1)

        # Draw all horizontal lines
        (@number_of_frets+1).times do |n|
          if n == 0 && @min_fret == 1
            canvas.line(margin_side_of_chord, n*height_of_fret+margin_top_of_chord, width - margin_side_of_chord, n*height_of_fret+margin_top_of_chord).styles(:stroke=>'black', :stroke_width => 5)
          else
            canvas.line(margin_side_of_chord, n*height_of_fret+margin_top_of_chord, width - margin_side_of_chord, n*height_of_fret+margin_top_of_chord)
          end
        end
        
        unless @hide_fret_numbers
          (@number_of_frets).times do |i|
            canvas.text(margin_side_of_chord - radius_of_finger - 4, i*height_of_fret+margin_top_of_chord + height_of_fret / 2 + 10) do |txt|
              txt.tspan(@min_fret + i).styles(
                :text_anchor => 'end',
                :font_size => 24,
                :font_family => 'helvetica',
                :fill => 'black')
            end
          end
        end
        
        # bar_drawn = false
        fret_index = @strings.size
        @strings.each_with_index do |note, i|
          # Draw vertical lines
          canvas.line(i*width_of_fret+margin_side_of_chord, margin_top_of_chord, i*width_of_fret+margin_side_of_chord, height - margin_bottom_of_chord)

          str_ctx = @scale_hash[fret_index]
          fret_index = fret_index - 1
          str_ctx[:frets].each_with_index do | fret, ii |
            if fret == 0
              # Add a letter at the top. Either X or O.
              canvas.text(i*width_of_fret+margin_side_of_chord, margin_top_of_chord - 6) do |txt| 
                txt.tspan((fret == 0 ? "O" : 'X').to_s).styles(
                :text_anchor => 'middle',
                :font_size => 24, 
                :font_family => 'helvetica',
                :fill => 'black')
              end            
            else
              # Add a finger
              if str_ctx[:intervals][ii] == 1
                canvas.circle(radius_of_finger, i*width_of_fret+margin_side_of_chord,
                  (fret - @min_fret + 1)*height_of_fret - (height_of_fret / 2) + margin_top_of_chord).styles(:fill => 'green')
              else
                canvas.circle(radius_of_finger, i*width_of_fret+margin_side_of_chord,
                  (fret - @min_fret + 1)*height_of_fret - (height_of_fret / 2) + margin_top_of_chord)
              end

              # Add fingering to finger dot
              if str_ctx[:fingers][ii] && !@show_intervals
                canvas.text(i*width_of_fret+margin_side_of_chord + 1, (fret - @min_fret + 1)*height_of_fret - (height_of_fret / 2) + margin_top_of_chord + 8) do |txt| 
                  txt.tspan(str_ctx[:fingers][ii].to_s).styles(:text_anchor => 'middle',
                  :font_size => 24, 
                  :font_family => 'helvetica',
                  :fill => 'white')
                end
              elsif @show_intervals
                canvas.text(i*width_of_fret+margin_side_of_chord + 1, (fret - @min_fret + 1)*height_of_fret - (height_of_fret / 2) + margin_top_of_chord + 8) do |txt| 
                  txt.tspan(str_ctx[:intervals][ii].to_s).styles(:text_anchor => 'middle',
                  :font_size => 24, 
                  :font_family => 'helvetica',
                  :fill => 'white')
                end
              end
            end
          end
          
          canvas.text(i*width_of_fret+margin_side_of_chord, height - margin_bottom_of_chord + 20) do |txt| 
            txt.tspan(note).styles(:text_anchor => 'middle',
            :font_size => 18, 
            :font_family => 'helvetica',
            :fill => 'black')
          end
        end
        
        if @label
          canvas.text(width / 2, margin_top_of_chord / 2) do |txt|
            txt.tspan(@label).styles(:text_anchor => 'middle',
              :font_size => 36,
              :font_family => 'helvetica',
              :fill => 'black',
              :font_weight => 'bold')
          end
        end

      end
      img = rvg.draw
      img = img.trim
      img.format = 'PNG'
      img.to_blob
    end
  end

end