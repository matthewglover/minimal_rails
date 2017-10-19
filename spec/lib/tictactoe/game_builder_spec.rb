require Rails.root.join('lib/tictactoe/game_builder')

RSpec.describe Tictactoe::GameBuilder do
  let(:controller) { :tictactoe }
  let(:action) { :game }

  context 'with params for human vs human, new game (3x3)' do
    let(:params) { {board_size: 3, player_x_type: 'human', player_o_type: 'human'} }

    it 'creates correct game' do
      game = Tictactoe::GameBuilder.build(params)
      validate_game(game, 3, :human, :human, [])
    end
  end

  context 'with params for human vs human, new game (4x4)' do
    let(:params) { {board_size: 4, player_x_type: 'human', player_o_type: 'human'} }

    it 'creates correct game' do
      game = Tictactoe::GameBuilder.build(params)
      validate_game(game, 4, :human, :human, [])
    end
  end

  context 'with params for human vs computer, with first move made (3x3)' do
    let(:params) { {board_size: 3, player_x_type: 'human', player_o_type: 'computer', move: '1'} }

    it 'creates correct game' do
      game = Tictactoe::GameBuilder.build(params)
      validate_game(game, 3, :human, :computer, [1])
    end
  end

  context 'with params for computer vs computer, with second move made (3x3)' do
    let(:params) { {board_size: 3, player_x_type: 'computer', player_o_type: 'computer', moves: ['2'], move: '1'} }

    it 'creates correct game' do
      game = Tictactoe::GameBuilder.build(params)
      validate_game(game, 3, :computer, :computer, [2, 1])
    end
  end

  def validate_game(game, board_size, player_x_type, player_o_type, moves)
    expect(game.board.size).to eq(board_size)
    expect(game.player_x_type).to eq(player_x_type)
    expect(game.player_o_type).to eq(player_o_type)
    expect(game.board.moves).to eq(moves)
  end
end
