require 'pry'
class Board
  attr_accessor :board, :trimmed_board
  def initialize(board)
    @board = board
    @trimmed_board = trim_board
    @out = board_of_zeros
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
  
  def transform
    @trimmed_board.each_with_index do |row, v_index|
      row.chars.each_with_index do |space, h_index|
        if space == "*"
          score_row(v_index, h_index)
          score_row(v_index + 1, h_index)
          score_row(v_index - 1, h_index)
        end
      end
    end
    @out.pop #shouldn't need this.
    
    @out
  end
  
  def score_row(v_index, h_index)
    row = @out[v_index]
    row[h_index] = row[h_index] + 1
    if row[h_index + 1]
      row[h_index + 1] = row[h_index + 1] + 1
    end
    if row[h_index + -1]
      row[h_index + -1] = row[h_index + -1] + 1
    end
    @out[v_index] = row
  end
  
  def self.transform(board)
    board = Board.new(board)
    board.transform
  end
end