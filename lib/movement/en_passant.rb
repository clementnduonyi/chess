require_relative 'basic_move'


class EnpassantMove < BasicMove
    def initialize(board = nil, rank = nil, file = nile)
        super
    end

    def update_position(board, axis)
        @board = board
        @rank = axis[:rank]
        @file = axis[:file]
        update_en_passant_shifts
    end

    def update_en_passant_shifts
        drop_cap_piece_observer
        update_live_pawn_axis
        drop_main_piece
        drop_en_passant_cap
        update_live_piece_position
    end

    def update_live_pawn_axis
        @board.grid[new_rank][file] = @board.live_piece
    end

    def update_live_piece_position
        @board.live_piece.update_position(new_rank, file)
    end

    private

    def new_rank
        rank + @board.live_piece.rank_path
    end
end