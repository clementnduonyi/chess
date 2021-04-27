require_relative 'piece'

class Knight < Piece
    def initialize(board, params)
        super(board, params)
        @symbol = " \u265E "
        @captures = []
    end

    def check_for_possible_shifts(board)
        eventualities = []
        shift_set.each do |shift|
            rank = @position[0] + shift[0]
            file = @position[1] + shift[1]
            if !valid_position?(rank, file)
                next
            elsif !board.grid[rank][file]
                eventualities << [rank, file]
            end
        end
        eventualities
    end

    def check_for_possible_captures(board)
        res = []
        shift_set.each do |shift|
            rank = @position[0] + shift[0]
            file = @position[1] + shift[1]
            if !valid_position?(rank, file)
                next
            elsif enemy_piece?(rank, file, board.grid)
                res << [rank, file]
            end
        end
       @captures = res
    end

    private

    def shift_set
        [[-1, -2], [1, 2], [-1, 2], [1, -2], [-2, -1],[2, 1],[-2, 1], [2, -1]]
    end
end