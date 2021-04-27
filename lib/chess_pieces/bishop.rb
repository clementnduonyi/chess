require_relative 'piece'

class Bishop < Piece
    def initialize(board, params)
        super(board, params)
        @symbol = " \u265D "
    end

    private

    def shift_set
        [[1, 1], [1, -1], [-1, 1], [-1, -1]]
    end
end