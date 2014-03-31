module Sinatra
  module App
    module Helpers

      def md5(user_file)

        @md5_hash = Digest::MD5.hexdigest(File.read(user_file))

      end

      def artists(user_file)
        @file = File.open(user_file).read
        @artists = []
        @file.each_line do |line|
          if line.include?('<key>Artist</key>')
            @artists << line.match(/(?<=string>)(.*)(?=<\/string)/)[0].strip
          end
        end
        @artists.uniq
      end

      def unique_genres(user_file)
        @file = File.open(user_file).read
        @genres = []
        @file.each_line do |line|
          if line.include?('<key>Genre</key>')
            @genres << line.match(/(?<=string>)(.*)(?=<\/string)/)[0].strip
          end
        end
        @genres.uniq
      end

      def total_genres(user_file)
        @file = File.open(user_file).read
        @genres = []
        @file.each_line do |line|
          if line.include?('<key>Genre</key>')
            @genres << line.match(/(?<=string>)(.*)(?=<\/string)/)[0].strip
          end
        end
        @genres.size
      end

      def metal_genres_count(user_file)
        @file = File.open(user_file).read
        genres = ["Thrash","Metal","Black Metal","Power Metal","Death Metal","Technical Death Metal","Thrash Metal","Grind","Grindcore","Progressive Metal","Instrumental Metal","Tech Metal","Heavy Metal","Doom","Speed Metal","Symphonic Metal","Hard Rock", "Shred", "Math Rock"]
        @metal_genres = []
        @file.each_line do |line|
          if line.include?('<key>Genre</key>')
            if genres.any?{ |g| line.match(g)}
              @metal_genres << line.match(/(?<=string>)(.*)(?=<\/string)/)[0].strip
            end

          end
        end
        @metal_genres

      end

      def metal_percent(user_file)
        @file = File.open(user_file).read

        @percent = (metal_genres_count(user_file).size.to_f / total_genres(user_file).to_f)
      end

      def songs(user_file)
        @file = File.open(user_file).read
        @songs = []
        @file.each_line do |line|
          if line.include?('<key>Name</key>')
            @songs << line.match(/(?<=string>)(.*)(?=<\/string)/)[0].strip
          end
        end
        @songs
      end

      def lengths(user_file)
        @file = File.open(user_file).read

        @lengths = []
        @file.each_line do |line|
          if line.include?('<key>Total Time</key>')
            ms = line.match(/(?<=integer>)(.*)(?=<\/integer)/)[0].strip.to_i
            s = ms/1000
            time = Time.at(s).strftime("%M:%S")
            @lengths << time
          end
        end
        @lengths
      end

      def years(user_file)
        @file = File.open(user_file).read
        @years = []
        @file.each_line do |line|
          if line.include?('<key>Year</key>')
            @years << line.match(/(?<=integer>)(.*)(?=<\/integer)/)[0].strip
          end
        end
        @years
      end

      def avg_length(user_file)
        @file = File.open(user_file).read
        total_time = 0
        ms = 0
        @lengths = []
        @file.each_line do |line|
          if line.include?('<key>Total Time</key>')
            ms = line.match(/(?<=integer>)(.*)(?=<\/integer)/)[0].strip.to_i
            #s = ms/1000
            #time = Time.at(s).strftime("%M:%S")
            @lengths << ms
            total_time += ms
          end
        end
        #binding.pry
        avg_ms = (total_time.to_f / @lengths.size.to_f)
        s = avg_ms/1000
        @time = Time.at(s).strftime("%M:%S")
        @time
      end

      def frequency_hash(user_file)
        @file = File.open(user_file).read
        @genres = []
        hash = Hash.new(0)
        @file.each_line do |line|
          if line.include?('<key>Genre</key>')
            @genres << line.match(/(?<=string>)(.*)(?=<\/string)/)[0].strip
          end
        end

        @genres.each { |genre| hash[genre] += 1 }
        @sorted = hash.sort_by &:last
        @sorted
      end

      def songs_without_genres(user_file)
        @file = File.open(user_file).read

        @total = @songs.size - @genres.size
        @total
      end

      def sanity_check(user_file)
        @file = File.open(user_file).read
        frequency_hash.inject(0) { |sum, tuple| sum += tuple[1] }

      end

      def metal_cred(user_file)

        if artists(user_file).include?("bieber")
          @user_cred = "WEENIE"
          @cred_pic = "bieber.jpg" 

        elsif metal_percent(user_file) > 0.4
          @user_cred = "BRUTAL"
          @cred_pic = "immortal.jpg"
        elsif metal_percent(user_file) > 0.3
          @user_cred = "SHREDDER"
          @cred_pic = "batio.jpg"
        elsif metal_percent(user_file) > 0.2
          @user_cred = "Prog Elitist"
          @cred_pic = "rush.jpg"
        elsif metal_percent(user_file) > 0.1
          @user_cred = "Old Rocker"
          @cred_pic = "ozzy.jpg"
        elsif metal_percent(user_file) > 0.05
          @user_cred = "WANNABE"
          @cred_pic = "horizon.jpg"
        elsif metal_percent(user_file) < 0.05
          @user_cred = "WEENIE"
          @cred_pic = "bieber.jpg" 
        else
          @user_cred = "error"
        end
      end



      def youtube

        @playlists = [
          "PL8ACFF7C60F29BE6B",
          "PLB6C19F09F75D9D15",
          "PL7BBA3BE2CF1582EA",
          "PLF7CAE124DA6FF756",
          "PLC76B07008B0EDD5D",
          "PL561322A9D5B76C67",
          "PL9A369B0AA5BC1989",
          "PLBDDBC1710E72488D"
        ]

        @rand = rand(45)+1

      end

    end
  end
end
