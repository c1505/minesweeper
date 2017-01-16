require 'pry'
class Board
  attr_accessor :board, :trimmed_board
  def initialize(board)
    @board = board
    @trimmed_board = trim_board
    @output = board_of_zeros
    @mine_locations = []
  end
  
  def self.transform(board)
    board = Board.new(board)
    board.transform
  end
  
  def transform
    @trimmed_board.each_with_index do |row, v_index|
      row.chars.each_with_index do |space, h_index|
        if space == "*"
          score_row(v_index, h_index)
          score_row(v_index + 1, h_index)
          score_row(v_index - 1, h_index)
          @mine_locations << [v_index, h_index]
        end
      end
    end
    @output.pop #shouldn't need this.
    replace_mines
    add_sides
    
    string_and_join
    remove_zeros
    header_and_footer
  end
  
  private
  
  def remove_zeros
    @output.map! do |row|
      row.gsub("0", " ")
    end
  end
  
  def string_and_join
    @output.map! do |row|
      row.map {|f| f.to_s }.join
    end
  end
      
  
  def replace_mines
    @mine_locations.each do |location|
      @output[location[0]][location[1]] = "*"
    end
  end
  
  def add_sides
    @output.each do |row|
      row << '|'
      row.unshift('|')
    end
  end
  
  def header_and_footer
    @output << "+------+"
    @output.unshift("+------+")
  end
  
  def trim_board
    first_step = @board.slice(1..@board.size - 1) #this should be -2.  kinda hacky.  should fix it
    first_step.map do |row|
      row.slice(1..row.size - 2)
    end
  end
  
  def board_of_zeros
    @trimmed_board.map do |row|
      row.chars.map do |space|
        0
      end
    end
  end
  
  def score_row(v_index, h_index)
    row = @output[v_index]
    row[h_index] = row[h_index] + 1
    if row[h_index + 1]
      row[h_index + 1] = row[h_index + 1] + 1
    end
    if row[h_index + -1]
      row[h_index + -1] = row[h_index + -1] + 1
    end
    @output[v_index] = row
  end
  
end