require_relative '../board'
require_relative '../validate_move'

class Piece
    attr_reader :color, :position, :symbol, :shifts, :captures, :shifted

    def initialize(board, params)
        board.add_observer(self)
        @color = params[:color]
        @position = params[:position]
        @symbol = nil
        @shifts = []
        @captures = []
        @shifted = false
    end

    def update_position(rank, file)
        @position = [rank, file]
        @shifted = true
    end

    def live_moves(board)
        possible_shifts = check_for_possible_shifts(board)
        @shifts = drop_illegal_shifts(board, possible_shifts)
    end

    def live_captures(board)
        possible_captures = check_for_possible_captures(board)
        @captures = drop_illegal_shifts(board, possible_captures)
    end

    def check_for_possible_shifts(board)
        shifts = shift_set.inject([]) do |info, shift|
            info << make_shifts(board.grid, shift[0], shift[1])
        end
        shifts.compact.flatten(1)
    end

    def check_for_possible_captures(board)
        captures = shift_set.inject([]) do |info, shift|
            info << make_captures(board.grid, shift[0], shift[1])
        end
        captures.compact
    end

    def drop_illegal_shifts(board, shifts)
        return shifts unless shifts.size.positive?

        test_board = YAML.load(YAML.dump(board))
        validator = ValidatMove.new(position, test_board, shifts)
        validator.ckeck_possible_shifts
    end

    def update(board)
        live_captures(board)
        live_moves(board)
    end

    private

    def shift_set
        raise 'Called abstract moethod: shift_set'
    end

    def make_shifts(grid, rank_disorder, file_disorder)
        rank = @position[0] + rank_disorder
        file = @position[1] + file_disorder
        result = []
        while valid_position?(rank, file)
            break if grid[rank][file]

            result << [rank, file]
            rank += rank_disorder
            file += file_disorder
        end
        result
    end


    def make_captures(grid, rank_disorder, file_disorder)
        rank = @position[0] + rank_disorder
        file = @position[1] + file_disorder
        while valid_position?(rank, file)
          break if grid[rank][file]
    
          rank += rank_disorder
          file += file_disorder
        end
        [rank, file] if enemy_piece?(rank, file, grid)
      end
    
    def valid_position?(rank, file)
        rank.between?(0, 7) && file.between?(0, 7)
    end

    def enemy_piece?(rank, file, grid)
        return unless valid_position?(rank, file)

        piece = grid[rank][file]
        piece && piece.color != color
    end
end


