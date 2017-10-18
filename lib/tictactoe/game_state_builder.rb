module Tictactoe
  class GameStateBuilder
    def self.build(action: nil, controller: nil, game:)
      { action: action,
        controller: controller,
        board_size: game.board.size,
        player_x_type: game.player_x_type,
        player_o_type: game.player_o_type,
        moves: game.board.moves,
        move: get_move(game) }
    end

    private

    def self.get_move(game)
      if game.next_player.type == :computer
        game.next_player.get_move(game.board)
      end
    end
  end
end
