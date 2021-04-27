
require_relative 'board'
require_relative 'show_board'
require_relative 'game_console'
require_relative 'authenticate'
require_relative 'translate'
require_relative 'serialized'
require_relative 'validate_move'
require_relative 'chess_pieces/piece'
require_relative 'chess_pieces/king'
require_relative 'chess_pieces/queen'
require_relative 'chess_pieces/rook'
require_relative 'chess_pieces/bishop'
require_relative 'chess_pieces/pawn'
require_relative 'chess_pieces/knight'
require_relative 'movement/move_generator'
require_relative 'movement/basic_move'
require_relative 'movement/castling'
require_relative 'movement/en_passant'
require_relative 'movement/pawn_elevation'

extend GameConsole
extend Serailized


def start_game(input)
    if %w[1].include?(input)
        single_player = Authenticate.new(1)
        single_player.errect_board
        single_player.start
    elsif %w[2].include?(input)
        tow_player = Authenticate.new(2)
        tow_player.errect_board
        tow_player.start
    elsif %w[3].include?(3)
        load_saved_game.start
    end
end

play_loop

def play_loop
    loop do
        puts choice_prompts
        status = get_game_status
        start_game(status)
        break if make_game_choice_again == :quit
    end
end
