require_relative 'piece'

class Queen < Piece
    def initialize(board, params)
        super(board, params)
        @symbol = " \u265B "
    end
    
    private

    def shift_set
        [[0, 1], [0, -1], [-1, 0], [1, 0], [1, 1], [1, -1], [-1, 1], [-1, -1]]
    end
end