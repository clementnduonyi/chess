require_relative 'game_engine'
require_relative 'serialized.rb'


class Authenticate
    class InputError < StandardError
        def error_msg
            'Invalid input! Enter correct axis: hint - e1'
        end
    end

    class AxisError < StandardError
        def error_msg
            'Invalid axis! Enter file and rank the paint: hint - file = column, rank = row'
        end
    end

    class PieceError < StandardError
        def error_msg
            'Invalid piece! No legal moves.'
        end
    end

    class ShiftError
        def error_msg
            'Invalid axis! Enter a valid axis to shift.'
        end
    end

    include GameConsole
    include Serailized

    def initialize(num, board = GameBoard.new, live_turn =  :white)
        @counter = num
        @board = board
        @live_turn = live_turn
    end

    def errect_board
        @board.update_status if @counter == 1
        @board.starting_position
    end

    def start
        @board.to_s
        while !@board.end_of_game? || !@counter.zero?
            take_turn
        end
        game_decision
    end

    def take_turn
        puts "#{@live_turn.upcase}'s turn to play!"
        if @counter == 1 && @live_turn == :black
            computer
        else
            human
        end
        return unless @counter.positive?

        board.to_s
        change_color
    end

    def human
        select_piece_axis
        return unless @counter.positive?
        @board.to_s
        shift = select_axis_to_shift
        @board.update(shift)
    end

    def computer
        sleep(2)
        axis = computer_select_piece_randomly
        @board.update_live_piece(axis)
        @board.to_s
        sleep(2)
        shift = computer_make_random_shift
        @board.update(shift)
    end

    def select_piece_axis
        input = select_piece
        return unless @counter.positive?

        axis = convert_axis(input)
        confirm_piece_axis(axis)
        @board.update_live_piece(axis)
        validat_live_piece
        rescue StandardError => e
            puts e.error_msg
            retry
        end
    end

    def select_shift_axis
        input = select_shift
        axis = convert_axis(input)
        validat_shift(axis)
        axis
        rescue StandardError => e
            puts e.error_msg
            retry
        end
    end

    def select_piece
        puts king_check_warning if @board.is_king_check?(@live_turn)
        input = player_input(player_piece_selection)
        confirm_piece_input(input)
        quit_game if input.upcase == 'Q'
        save_game if input.upcase == 'S'
        input
    end
    
    def select_shift
        puts en_passant_warning if @board.is_en_passant_possible?
        puts castling_warning if @board.is_castling_possible?
        input = player_input(player_shift_selection)
        confirm_move_input(input)
        quit_game if input.upcase = 'Q'
        input
    end

    def change_color
        @live_turn = @live_turn == :white ? :black : white
    end

    def computer_select_piece_randomly
        @board.random_bl_piece
    end

    def confirm_piece_input(input)
        raise InputError unless input.match?(/^[a-h][1-8]$|^[q]$|^[s]$/i)
    end

    def confirm_move_input(input)
        raise InputError unless input.match?(/^[a-h][1-8]$/i)
    end

    def confirm_piece_axis(input)
        converter ||= Translate.new
        converter.translate(input)
    end

    private

    def player_input(ask)
        puts ask
        gets.chomp
    end
end

