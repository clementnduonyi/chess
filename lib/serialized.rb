require 'yaml'
module Serailized

    def to_yml
        YAML.dump(self)
    end

    def from_yml
        YAML.load(File.read(game))
    end


    def save_game
        if !Dir.exist? 'games'
            Dir.mkdir 'games'
        end
        file_name = create_file
        File.open("./games/#{my_game}.yml", 'w') do |file|
            YAML.dump([].push(self), file)
        end
        puts "Game saved as \e[36m#{file_name}\e[0m"
        @counter = 0
    rescue SystemCallError => e
        puts "Error! cannot write to file #{file_name}."
        puts e
    end

    def create_file
        date = Time.now.strtime('%Y-%m-%d').to_s
        time = Time.now.strtime('%H:%M:%S').to_s
        "Chess #{date} at #{time}"
    end

    def load_saved_game
        filename = saved_games
        File.open("games/#{filename}") do |file|
            YAML.load(file)
        end
    end

    def saved_games
        games = generate_game_list
        if games.empty?
            puts 'No saved games found'
            exit
        else
            display_saved_games(games)
            file_num = select_saved_game(saved_games.size)
            saved_games[file_num.to_i - 1]
        end
    end

    def display_saved_games(game_list)
        puts "\e[36m[#]\e[0m File Name(s)"
        game_list.each_with_index do |name, idx|
            puts "\e[36m[#{idx + 1}]\e[0m #{name}"
        end
    end

    def select_saved_game(num)
        file_num = gets.chomp
        if file_num.to_i.between(1, num)
            return file_num
        else
            puts 'Input errror! Enter valid file name.'

            select_saved_game(num)
        end
    end

    def generate_game_list
        game_list = []
        if !Dir.exist? 'games'
            return game_list
        end
        Dir.entries('games').each do |name|
            if name.match(/(Chess)/)
                game_list.concat(name)
            end
        end
      
    end
end
