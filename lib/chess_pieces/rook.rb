require_relative 'piece'

class Rook < Piece
    def initialize(board, params)
      super(board, params)
      @symbol = " \u265C "
    end
  
    private
  
    def shift_set
      [[0, 1], [0, -1], [-1, 0], [1, 0]]
    end
end