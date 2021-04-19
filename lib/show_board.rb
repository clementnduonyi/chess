module Show
    private

    def display_board
        system 'clear'
        puts
        puts "\[36m     a   b   c   d   e   f   g   h \e[0m"
        print_board
        puts "\e[36m    a   b   c   d   e   f   g   h \e[0m"
        puts
    end

    def print_board
        @grid.each_with_index do |row, idx|
            print "\e[36m #{8 - idx} \e[0m"
            print_rank(row, idx)
            print "\e[36m #{8 - idx} \e[0m"
            puts
        end
    end

    def print_rank(rank, rank_idx)
        rank.each_with_index do |square, idx|
            bg_color = chose_bg(rank_idx, idx)
            print_square(rank_idx, idx, square, bg_color)
        end
    end

    def select_bg(rank_idx, file_idx)
        if @live_piece&.position == [rank_idx, file_idx]
            106
        elsif capture_bg?(rank_idx, file_idx)
            101
        elsif @prev_piece&.position == [rank_idx, file_idx]
            46
        else
            100
        end
    end

    def capture_bg?(rank, file)
        @live_piece&.captures&.any?([rank, file]) && @grid[rank][file]
    end

    def print_square(rank_idx, idx, square, bg)
        if square
            txt_color = square.color == :white ? 97 : 30
            paint_square(txt_color, bg, square.symbol)
        elsif @live_piece&.shifts.any?(rank_idx, file_idx)
            paint_square(91, bg, " \u25CF ")
        else
            paint_square(30, bg, ' ')
        end
    end

    def paint_square(font, bg, str)
        print "\e[#{font};#{bg}m#{str}\e[0m"
    end
end


