require Rails.root.join('lib/tictactoe/game_options_builder')
require Rails.root.join('lib/tictactoe/params_parser')
require Rails.root.join('lib/tictactoe/game_state_builder')

RSpec.describe Tictactoe::GameOptionsBuilder do
  let(:path) { nil }
  let(:player_x_type) { 'human' }
  let(:player_o_type) { 'human' }
  let(:controller) { 'tictactoe' }
  let(:action) { 'game' }
  let(:params) { {
    'controller' => controller,
    'action' => action,
    'player_x_type' => player_x_type,
    'player_o_type' =>  player_o_type,
    'moves' => moves,
    'move' => move
  } }
  let(:parsed_params) { Tictactoe::ParamsParser.parse(params) }
  let(:game) { Tictactoe::GameBuilder.build(parsed_params.slice(
      :player_x_type, :player_o_type, :move, :moves)) }
  let(:game_state) { Tictactoe::GameStateBuilder.build(
      controller: controller,
      action: action,
      game: game) }

  context 'new game' do
    let(:move) { nil }
    let(:moves) { [] }
    let(:game_options) { Tictactoe::GameOptionsBuilder.new(params).build }

    it 'creates empty game options' do 
      expect(game_options[:board_data]).to eq(
        game.board.rows_as_square_numbers_and_statuses)
      expect(game_options[:game_state]).to eq(game_state)
      expect(game_options[:type]).to be :playable
      expect(game_options[:is_game_complete]).to be false
      expect(game_options[:winner]).to be nil
    end
  end
  
  context 'completed game' do
    let(:move) { 3.to_s }
    let(:moves) { [1, 4, 2, 5].map(&:to_s) }
    let(:game_options) { Tictactoe::GameOptionsBuilder.new(params).build }

    it 'reports draw' do
      expect(game_options[:is_game_complete]).to be true
      expect(game_options[:winner]).to be :x
    end
  end
end
