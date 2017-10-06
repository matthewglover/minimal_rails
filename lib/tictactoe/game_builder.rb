module Tictactoe
  class GameBuilder
    def self.build(player_x_type:, player_o_type:, move: nil, moves: [])
      MattsTictactoeCore::Game.new(
        player_x_type: player_x_type.to_sym,
        player_o_type: player_o_type.to_sym,
        board: build_board(move, moves))
    end

    private

    def self.build_board(move, moves)
      MattsTictactoeCore::Board.new(build_moves(move, moves))
    end

    def self.build_moves(move, moves)
      moves.concat([move]).grep(String).map(&:to_i)
    end
  end
end
