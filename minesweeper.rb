require 'pry'
class Board
  # start with a simpler case.  one asterict
  # each place needs to look to left, right, previous array same spot, and next array same spot.
  # i could create a data structure where a space knows it's neighbors.  maybe like a binary tree kinda.
  # might be good to create a cla
  # def initialize(board)
  #   # create object for 
  #   board.each do |row|
  #     row.chars.each do |space|
  #       Space.new
  # i think the easy solution seems not easy now.  wasn't thinking about 8.  
  attr_accessor :board, :trimmed_board
  def initialize(board)
    @board = board
    @trimmed_board = trim_board
    @out = board_of_zeros
  end
  
  def trim_board
    first_step = @board.slice(1..@board.size - 1)
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
          
          score_other_row(v_index + 1, h_index)
          # if @out[v_index + 1][h_index]
          #   @out[v_index + 1][h_index] = @out[v_index + 1][h_index] + 1
          # end
          score_other_row(v_index - 1, h_index)
          # if @out[v_index - 1 ][h_index + 1]
          #   @out[v_index - 1 ][h_index + 1] = @out[v_index + 1][h_index] + 1
          # end
        end
      end
    end
    @out.pop.shift
    @out
  end
  
  def score_row(v_index, h_index)
    row = @out[v_index]
    if row[h_index + 1]
      row[h_index + 1] = row[h_index + 1] + 1
    end
    if row[h_index + -1]
      row[h_index + -1] = row[h_index + -1] + 1
    end
    @out[v_index] = row
  end
  
  def score_other_row(v_index, h_index)
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
    # out = board.board_of_zeros
    # board.each_with_index do |row, v_index|
    #   row.chars.each_with_index do |space, h_index|
    #     # if space == "*"
    #     #   out[v_index][h_index + 1] = out[v_index][h_index + 1] + 1
    #     #   out[v_index][h_index + -1] = out[v_index][h_index + -1] + 1

    #     #   out[v_index + 1][h_index] = out[v_index + 1][h_index] + 1
    #     #   out[v_index - 1 ][h_index + 1] = out[v_index + 1][h_index] + 1
    #     # end
    #     # out[v_index + 1][h_index] = space
    #     # out[v_index - 1 ][h_index + 1] = space
    #   end
    # end
    # out.pop.shift
    # out
    # ['+------+', '|1*22*1|', '|12*322|', '| 123*2|', '|112*4*|',
    #     '|1*22*2|', '|111111|', '+------+']
         
    # inp = ['+------+',
    #       '| *  * |',
    #       '|  *   |',
    #       '|    * |',
    #       '|   * *|',
    #       '| *  * |',
    #       '|      |',
    #       '+------+']
    # out = ['+------+',
    #       '|1*22*1|',
    #       '|12*322|',
    #       '| 123*2|',
    #       '|112*4*|',
    #       '|1*22*2|',
    #       '|111111|',
    #       '+------+']
  end
end