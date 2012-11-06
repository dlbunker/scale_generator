require 'helper'

class TestScaleGenerator < Test::Unit::TestCase
  should "generate a scale diagram" do
    s = scale 'A Major Scale' do
      inst_string 1 do
        frets 4, 5, 7
        fingering 1, 2, 4
        intervals 7, 1, 9
      end
      inst_string 2 do
        frets 5, 7
        fingering 2, 4
        intervals 5, 13
      end
      inst_string 3 do
        frets 4, 6, 7
        fingering 1, 3, 4
        intervals 9, 3, 11
      end
      inst_string 4 do
        frets 4, 6, 7
        fingering 1, 3, 4
        intervals 6, 7, 1
      end
      inst_string 5 do
        frets 4, 5, 7
        fingering 1, 2, 4
        intervals 3, 4, 5
      end
      inst_string 6 do
        frets 5, 7
        fingering 2, 4
        intervals 1, 2
      end
    end
    
    File.open("./#{s[:label]}.png", 'w') do |f|
      diagram = ScaleGenerator::Scale.new(
        scale 'A Major Scale' do
          inst_string 1 do
            frets 4, 5, 7
            fingering 1, 2, 4
            intervals 7, 1, 9
          end
          inst_string 2 do
            frets 5, 7
            fingering 2, 4
            intervals 5, 13
          end
          inst_string 3 do
            frets 4, 6, 7
            fingering 1, 3, 4
            intervals 9, 3, 11
          end
          inst_string 4 do
            frets 4, 6, 7
            fingering 1, 3, 4
            intervals 6, 7, 1
          end
          inst_string 5 do
            frets 4, 5, 7
            fingering 1, 2, 4
            intervals 3, 4, 5
          end
          inst_string 6 do
            frets 4, 5, 7
            fingering 1, 2, 4
            intervals 7, 1, 2
          end
        end
      )
      f.write diagram.to_png()
    end
    
    File.open("./#{s[:label]}-intervals.png", 'w') do |f|
      diagram = ScaleGenerator::Scale.new(
        scale 'A Major Scale' do
          inst_string 1 do
            frets 4, 5, 7
            fingering 1, 2, 4
            intervals 7, 1, 9
          end
          inst_string 2 do
            frets 5, 7
            fingering 2, 4
            intervals 5, 13
          end
          inst_string 3 do
            frets 4, 6, 7
            fingering 1, 3, 4
            intervals 9, 3, 11
          end
          inst_string 4 do
            frets 4, 6, 7
            fingering 1, 3, 4
            intervals 6, 7, 1
          end
          inst_string 5 do
            frets 4, 5, 7
            fingering 1, 2, 4
            intervals 3, 4, 5
          end
          inst_string 6 do
            frets 4, 5, 7
            fingering 1, 2, 4
            intervals 7, 1, 2
          end
        end
      )
      f.write diagram.to_png(true)
    end
    # flunk "something went wrong"
  end
end
