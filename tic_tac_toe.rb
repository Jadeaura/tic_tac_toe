class GameBoard
  @@WIN_CONDITIONS = [[:top_left, :top, :top_right],
                      [:middle_left, :middle, :middle_right],
                      [:bottom_left, :bottom, :bottom_right],
                      [:top_left, :middle_left, :bottom_left],
                      [:top, :middle, :bottom],
                      [:top_right, :middle_right, :bottom_right],
                      [:top_left, :middle, :bottom_right],
                      [:top_right, :middle, :bottom_left]]

  def initialize(player_start)
    @player_start = player_start
    @turn = 0
    @board = {top_left: " ", top: " ", top_right: " ",
              middle_left: " ", middle: " ", middle_right: " ",
              bottom_left: " ", bottom: " ", bottom_right: " "}
  end
  def set_piece(position)
    position = position.to_i
    square = case position
    when 1 then :top_left
    when 2 then :top
    when 3 then :top_right
    when 4 then :middle_left
    when 5 then :middle
    when 6 then :middle_right
    when 7 then :bottom_left
    when 8 then :bottom
    when 9 then :bottom_right
    else
      return false
    end
    if @board[square] == " "
      @board[square] = "X"
      @turn += 1
    else
      return false
    end
  end
  def show_board
    puts "#{@board[:top_left]}\|#{@board[:top]}\|#{@board[:top_right]}"
    puts "-----"
    puts "#{@board[:middle_left]}\|#{@board[:middle]}\|#{@board[:middle_right]}"
    puts "-----"
    puts "#{@board[:bottom_left]}\|#{@board[:bottom]}\|#{@board[:bottom_right]}"
  end
  def game_over?
    if @turn > 4
      if self.winner?
        return true
      elsif @turn == 9
        puts "Tie game!"
        return true
      end
      return false
    else
      return false
    end
  end
  def winner?
    @@WIN_CONDITIONS.each do |cond|
      x_counter = 0
      o_counter = 0

      cond.each do |key|
        case @board[key]
        when "X"
          x_counter += 1
        when "O"
          o_counter += 1
        end
      end
      if o_counter == 3 || x_counter == 3
        puts o_counter == 3 ? "O's wins!" : "X's wins!"
        return true
      end
    end
    return false
  end
  def random_viable
    viable_moves = []
    @board.keys.each do |box|
      if @board[box] == " "
        viable_moves << box
      end
    end
    @board[viable_moves[rand(0...viable_moves.size)]] = "O"
    @turn += 1
  end
end

gb = GameBoard.new("Keegan")
gb.show_board

while gb.game_over? == false
  if gb.set_piece(gets)
    gb.show_board
    if gb.game_over? then break end
    gb.random_viable
    puts "\n"
    gb.show_board
  end
end