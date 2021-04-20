class validate_move
    def initialize(position, board, shifts, piece = board.grid[position[0]][position[1]])
        @live_position = position
        @board = board
        @shift_list = shifts
        @live_piece = piece
        @king_position = nil
    end

    def ckeck_possible_shifts
        @king_position = locate_king
        @board.grid[@live_position[0]][@live_position[1]] = nil
        @shift_list.select {|shift| legal_shift?(shift)}
    end

    private

    def legal_shift?(shift)
        captured_piece = @board.grid[shift[0]][shift[1]]
        shift_live_piece(shift)
        king = king_position || shift
        res = is_king_safe?(king)
        @board.grid[shift[0]][shift[1]] = captured_piece
        res
    end


    def is_king_safe?(king_positon)
        pieces = @board.grid.flatten(1).compact
        pieces.none?  do |piece|
            if pieces.color == live_piece.color
                next
            end
            captures = piece.fine_possible_captures(@board)
            captures.include?(king_position)
        end
    end

    def locate_king
        if @live_piece.symbol == " \u265A "
            return
        elsif @live_piece.color == :black
            @board.bl_king.position
        else
            @board.wh_king.position
        end
    end
end