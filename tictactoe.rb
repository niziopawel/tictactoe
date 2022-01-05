require 'player'

class TicTacToe
  attr_reader :board, :current_player, :players

  def initialize(args)
    @board = args[:board]
    @players = []
  end

  def start
    raise StandardError, 'Two players are required to play TicTacToe' if @players.count != 2

    @current_player = players.first

    until board.win? || board.draw?
      board.render
      read_input
      switch_player
    end

    print_result
  end

  def add_player(player)
    players << player
  end

  private

  def switch_player
    @current_player = current_player == players.first ? players.last : players.first
  end

  def print_result
    winner = board.win?

    board.render
    if winner
      puts "Congratulations #{winner.name}. You won!"
    else
      puts 'The match has been finished with a draw.'
    end
  end

  def read_input
    loop do
      puts "#{@current_player.name} where would you like to go? [1 - #{board.size**2}]"

      location = gets.chomp.to_i

      if board.available?(location)
        board.set_move(location, current_player)
        break
      else
        puts 'That spot is already taken'
      end
    end
  end
end
