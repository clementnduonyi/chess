class BasicMove
    attr_reader :rank, :file, :board

    def initialize(board = nil, rank = nil, file = nil)
        @board = board
        @rank = rank
        @file = file
    end

    def update_pieces(board, axis)
        @board = board
        @rank = axis[:rank]
        @file = axis[:file]
        update_basic_shifts
    end

    def update_basic_shifts
        if @board.grid[rank][file]
            drop_cap_piece_observer
        end
        update_new_axis
        drop_main_piece
        update_live_piece_position
    end

    

    def drop_cap_piece_observer
        @board.delete_observer(@board.grid[rank][file])
    end



    def update_new_axis
        @board.grid[rank][file] = @board.live_piece
    end


    
    def drop_main_piece
        position = @board.live_piece.position
        @board.grid[position[0]][position[1]] = nil
    end


    def update_live_piece_position
        @board.live_piece.update_position(rank, file)
    end
end

