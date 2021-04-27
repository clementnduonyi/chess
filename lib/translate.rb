class Translate
    def initialize
        @rank = nil
        @file = nil
    end

    def translate(alpha_num)
        axis = alpha_num.split(//)
        translate_rank(axis[1])
        translate_file{axis[0]}
        {rank: @rank, file: @file}
    end

    private

    def translate_file(alpha)
        @file = alpha.downcase.ord - 97
    end

    def translate_rank(num)
        @rank = 8 - num.to_i
    end
end