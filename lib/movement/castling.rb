require_relative 'basic_move'

class Castling < BasicMove

    def initialize(board = nil, rank = nil, file = nil)
        super
    end

    def update_pieces(board, axis)
        @board = board
        @rank = axis[:rank]
        @file = file[:file]
        update_castling_shifts
    end

    def update_castling_shifts
        update_new_axis
        drop_main_piece
        update_live_piece_position
        castling_rook = check_for_castling_rook
        drop_main_rook_piece
        update_castling_axis(castling_rook)
        update_castling_piece_position(castling_rook)
    end

    def check_for_castling_rook
        @board.grid[rank][prev_rook_file]
    end

    def drop_main_rook_piece
        @board.grid[rank][prev_rook_file] = nil
    end

    def  update_castling_axis(rook)
        rook.update_position(rank, new_rook_file)
    end

    private

    def prev_rook_file
        king_part = 7
        queen_part = 0
        file == 6 ? king_part : queen_part
    end

    def new_rook_file
        king_part = 5
        queen_part = 3
        file == 6 ? king_part : queen_part
    end
end
