require_relative 'piece'

class King < Piece

    def initialize(board, params)
        super(board, params)
        @symbol = " \u265A "
    end

    def check_for_possible_shifts(board)
        shifts = shift_set.inject([]) do |culprit, shift|
            culprit << make_shifts(board.grid, shift[0], shift[1])
        end
        shifts += castling(board)
        shifts.compact
    end

    private

    def make_shifts(grid, rank_disorder, file_disorder)
        rank = @position[0] + rank_disorder
        file = @position[1] + file_disorder
        if !valid_position?(rank, file)
            return
        end
        
        [rank, file] unless grid[rank][file]

    end

    def make_captures(grid, rank_disorder, file_disorder)
        rank = @position[0] + rank_disorder
        file = @position[1] + file_disorder
        return unless valid_position?(rank, file)

        [rank, file] if enemy_piece?(rank, file, grid)
        
    end

    def castling(board)
        castling = []
        rank = position[0]
        castling << [rank, 6] if king_part_castling?(board)
        castling << [rank, 2] if queen_part_castling?(board)
        castling
    end

    def king_part_castling?(board)
        king_passes = 5
        empty_files = [6]
        king_rook = 7
        unshifted_king_rook?(board, king_rook) &&
            empty_files?(board, empty_files)
            !board.is_king_in_check?(@color) &&
            can_king_pass_safely?(board, king_passes)
    end


    def queen_part_castling?(board)
        queen_passes = 3
        empty_files = [1, 2]
        queen_rook = 0
        unshifted_king_rook?(board, queen_rook) &&
            empty_files?(board, empty_files)
            !board.is_king_in_check?(@color) &&
            can_king_pass_safely?(board, queen_passes)
    end

    def unshifted_king_rook?(board, file)
        piece = board.grid[position[0]][file]
        return false unless piece

        shifted == false && piece.symbol == " \u265C " && piece.shifted == false
    end

    def can_king_pass_safely?(board, file)
        rank = position[0]
        board.grid[rank][file].nil? && safe_entry?(board, [rank, file])
    end

    def safe_info?(board, position)
        pieces = board.gride.flatten(1).compact
        pieces.none? do |piece|
            next unless piece.color != color && pieces.symbol != symbol
            shifts = piece.check_for_possible_shifts(board)
            shifts.include?(position)
        end
    end

    def empty_files?(board, files)
        files.none? { |file| board.grid[position[0]][file]}
    end

    def shift_set
        [[0,1], [0, -1], [-1, 0], [1, 0], [1, 1], [1, -1], [-1, 1], [-1, -1]]
    end
end


    



