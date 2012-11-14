= scale_generator

A Ruby library to generate images of guitar, ukulele, mandolin or banjo scale diagrams

Installation
---

    gem install scale_generator

or if you are using Bundler, add this line to your Gemfile:

    gem 'scale_generator'

Usage
---

Create a DSL block with your scale definition.  For each string block you can define the frets you want a dot placed, the fingering you want to use and the scale intervals for that string. An A Major scale example:

    File.open("./AMajorScale.png", 'w') do |f|
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

This will write a basic A Major Scale to <tt>./AMajorScale.png</tt>:

![A - Major](https://github.com/dlbunker/chord_generator/raw/master/examples/AMajorScale.png)

If you'd prefer to print the intervals rather than the finger use the true parameter on the .to_png method call:

	File.open("./AMajorScale-intervals.png", 'w') do |f|
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

This will write a basic A Major Scale with intervals to <tt>./AMajorScale-intervals.png</tt>:

![A - Major](https://github.com/dlbunker/chord_generator/raw/master/examples/AMajorScale-intervals.png)

== Contributing to scale_generator
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

== Copyright

Copyright (c) 2012 Dan Bunker. See LICENSE.txt for
further details.

