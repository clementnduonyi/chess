
require_relative 'board'
require_relative 'show_board'
require_relative 'play'
require_relative 'console'
require_relative 'translate'
require_relative 'validate_move'
require_relative 'serialized'
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

extend Console
extend Serailized


def play_loop
    loop do
        puts choice_prompt
        status = get_game_status
        start_game(status)
        break if make_game_choice_again == :quit
    end
end


def start_game(input)
    if input == '9'
        single_player = Play.new(9)
        single_player.errect_board
        single_player.start
    elsif input == '2'
        tow_player = Play.new(2)
        tow_player.errect_board
        tow_player.start
    elsif input == '3'
        load_saved_game.start
    end
end

play_loop

