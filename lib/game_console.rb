module GameConsole
    def get_game_status
        player_status = gets.chomp
        if player_status.macth?(/^[923]$/)
            return player_status
        else
            puts 'Input error! Enter any of [9, 2, 3].'
        end
        
        get_game_status
    end

    def replay
        puts make_game_choice_again
        input = gets.chomp
        choice = input.upcase == 'Q' ? :quit : :redo
        if input.matches?(/^[QP]$/i)
            return choice
        else
            puts 'Input error! Enter   Q or P'
        end
        replay
    end

    def game_decision
        if !@counter.positive?
            return
        elsif @board.is_king_check?(@live_turn)
            puts "\[36#{prev_color}\e[0m wins! The #{@live_turn} king is checkmate."
        else
            puts "\e[36m#{prev_color}\e[0m wins in a stalemate!"
        end
    end

    private

    def choice_prompt
        <<~HEREDOC
            \e[36mWelcome! Show me what you have got up your sleave. Chess!!\e[0m

            Follow this steps to play

            \e[36mStep One:\e[0m
            Enter the axis of the piece to move.

            \e[36mStep Two:\e[0m
            Enter the axis of any legal move \e[91;100m \25CF \e[0m or capture \e[101m \265F \e[0m.
            
            To start, enter:
            \e[36m[1]\e[0m to start a \e[36mnew single-player\e[0m with the computer
            \e[36m[2]\e[0m to play a \e[36mnew 2-player\e[0m game
            \e[36m[3]\e[0m to load a \e[36msaved\e[0m game
        HEREDOC
    end

    def make_game_choice_again
        <<~HEREDOC
        Enter:
        \e[36m[Q]\e[0m to Quit or \e[36m[P]\e[0m to Play again
      HEREDOC
    end


    def player_piece_selection
        <<~HEREDOC
            Enter the axis of the piece to move.
            \e[36m[Q]\e[0m to Quit or \e[36m[S]\e[0m to Save game
        HEREDOC
    end

    def player_shift_selection
        <<~HEREDOC

            Enter the axis of legal move \e[91;100m \u25CF \e[0m or capture \e[101m \u265F \e[0m.
        HEREDOC
    end

    def en_passant_warning
        <<~HEREDOC
            A possible capture of the opposing pawn detected. To capture the pawn en passant (enrout) enter the \e[41mhighlighted axis\e[0m.
            
            Consequently, \e[36 your pawn will be moved to the square in front of the captured pawn\e[0m.
        HEREDOC
    end

    def king_check_warning
        puts "\e[91mWARNING!\e[0m King in check!"
    end

    def castling_warning
        <<~HEREDOC
            The king is to be move two places and will be castle the rook.
            Cosequently, \e[36myour rook will move to occupy the square that the king passes via\e[0m.
        HEREDOC
    end

    def prev_color
        @live_turn == :white ? 'Black' : 'White'
    end

    def quit_game
        puts "\e[36m#{prev_color}\e[0m wins since #{@live_turn} quits"
        @counter = 0
    end

end
