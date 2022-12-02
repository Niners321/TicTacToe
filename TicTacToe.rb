class Game
  def initialize()
    @player_one = "X"
    @player_two = "O"
    @turn = 0
    @board = [1,2,3,4,5,6,7,8,9]
    @player
    @win_combos = [ 
      [@board[0],@board[1],@board[2]], # top_row 
      [@board[3],@board[4],@board[5]], # middle_row 
      [@board[6],@board[7],@board[8]], # bottom_row 
      [@board[0],@board[3],@board[6]], # left_column 
      [@board[1],@board[4],@board[7]], # center_column 
      [@board[2],@board[5],@board[8]], # right_column 
      [@board[0],@board[4],@board[8]], # left_diagonal 
      [@board[6],@board[4],@board[2]] # right_diagonal 
      ]
  end

  def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts row_separator = "---+---+---"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts row_separator
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end
  
  #take turns
  def take_turns(turn)
    if (turn % 2 == 1)
      @player = @player_two
    else
      @player = @player_one
    end
  end
  
  def win_combo(board)
    [ 
      [@board[0],@board[1],@board[2]], # top_row 
      [@board[3],@board[4],@board[5]], # middle_row 
      [@board[6],@board[7],@board[8]], # bottom_row 
      [@board[0],@board[3],@board[6]], # left_column 
      [@board[1],@board[4],@board[7]], # center_column 
      [@board[2],@board[5],@board[8]], # right_column 
      [@board[0],@board[4],@board[8]], # left_diagonal 
      [@board[6],@board[4],@board[2]] # right_diagonal 
      ]
    end

  #determine whether X or O
  def playing_piece(player)
    if @player == @player_one
      @player_one = "X"
    else
      @player_two = "O"
    end
  end

  #convert user selection into integer 
  def input_to_index(user_input)
    user_input.to_i
  end

  #place move
  def move(board, position, player)
    @board[@board.index(position)] = player
  end

  #determine if position has been played
  def position_taken?(board, index)
    if(@board[index] == Integer)
      return false
    else 
      return true
    end
  end



  #check to see if game has been won
  def win_game?(board)
    win_combo(@board).any? do |line|
      line.uniq.size == 1
    end
  end

  def winner(board, player)
    if(win_game?(@board) && @player == @player_one)
      display_board(@board)
      puts "Player ONE won!!"
    elsif(win_game?(@board) && @player == @player_two)
      display_board(@board)
      puts "Player TWO won!!"
   end
  end

  #check to see if board is full
  def full_board?(board)
    if (board.all? {|i| i == "X" || i == "O"})
      puts "Draw Game"
      new_game = Game.new()
      new_game.play_game
    end
  end

  def over?(board)
    if (win_game?(@board) || full_board?(@board))
      puts "Game Over"
      return true
    end
  end

  


  #play TicTacToe
  def play_game
    puts "New Game"
    until over?(@board) do
      display_board(@board)
      puts take_turns(@turn) == @player_one ? "Player ONE make your move!" : "Player TWO make your move!"
      user_input = gets.chomp
      if(position_taken?(@board, input_to_index(user_input)))
        move(@board, input_to_index(user_input), playing_piece(@player))
        @turn += 1
        winner(@board, @player)
      end
    end
  end
end

new_game = Game.new()
new_game.play_game
