require_relative 'basic_move'


class PawnElevationMove < BasicMove

    def initialize(board = nil, file = nil)
        super
    end


    def update_pieces(board, axis)
        @board = board
        @rank = axis[:rank]
        @file = axis[:file]
        update_pawn_elevation_shifts
    end


    def update_pawn_elevation_shifts
        if @board.grid[rank][file]
            drop_cap_piece_observer
        end
        drop_pawn_observer
        drop_main_piece
        new_piece = new_elevation_piece
        update_elevation_axis(new_piece)
        update_board_live_piece(new_piece)
    end


    def new_elevation_piece
        if @board.status == :comouter && @board.live_piece.color == :black
            make_elevation_piece('1')
        else
            puts pawn_elevation_options
            options = chose_elevation_piece
            make_elevation_piece(options)
        end
    end


    def drop_pawn_observer
        position = @board.live_piece.position
        @board.delete_observer(@board.grid[position[0]][position[1]])
    end


    def update_elevation_axis(piece)
        @board.grid[rank][file] = piece
    end


    def chose_elevation_piece
        option = gets.chomp
        if option.match?(/^[1-4]$/)
            return option
        end

        puts 'Input error! Try again with single digit between [1 - 4]'
        chose_elevation_piece
    end

    def make_elevation_piece(piece)
        color = @board.live_piece.color
        case options.to_i
        when 1
            Queen.new(@board, { color: color, position: [rank, file] })
        when 2
            Bishop.new(@board, { color: color, position: [rank, file] })
        when 3
            Knight.new(@board, { color: color, position: [rank, file] })
        else
            Rook.new(@board, { color: color, position: [rank, file] })
        end
    end


    def pawn_elevation_options
        <<~HEREDOC
            To promote your pawn, enter one of the following numbers:
            \e[36m[1]\e[0m for a Queen
            \e[36m[2]\e[0m for a Bishop
            \e[36m[3]\e[0m for a Knight
            \e[36m[4]\e[0m for a Rook
        HEREDOC
    end
end



