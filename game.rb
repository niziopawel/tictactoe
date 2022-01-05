$LOAD_PATH << '.'
require 'tictactoe'
require 'board'
require 'player'

board = Board.new({ size: 3 })
game = TicTacToe.new({ board: board })

player_x = Player.new('John', 'X')
player_o = Player.new('Bob', 'O')

game.add_player(player_x)
game.add_player(player_o)

game.start
