require_relative 'params_parser'
require_relative 'game_builder'
require_relative 'game_state_builder'

module Tictactoe
  class GameOptionsBuilder
    def initialize(params)
      @parsed_params = Tictactoe::ParamsParser.parse(params)
      @game = Tictactoe::GameBuilder.build(game_builder_params)
    end

    def build
      {
        board_data: board_data,
        game_state: game_state,
        type: type,
        is_game_complete: @game.complete?,
        moves: board.moves,
        winner: winner
      }
    end

    private

    def game_builder_params
      @parsed_params.slice(:board_size, :player_x_type, :player_o_type, :move, :moves)
    end

    def board_data
      board.rows_as_square_numbers_and_statuses
    end

    def board
      @game.board
    end

    def game_state
      Tictactoe::GameStateBuilder.build(
              controller: @parsed_params[:controller],
              action: @parsed_params[:action],
              game: @game)
    end

    def type
       is_playable_game ? :playable : :static
    end

    def is_playable_game
      @game.next_player.type == :human && !@game.complete?
    end

    def winner
      @game.complete? && @game.board.winner? ? @game.board.winner : nil
    end
  end
end
