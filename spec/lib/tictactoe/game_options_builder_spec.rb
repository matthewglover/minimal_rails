require Rails.root.join('lib/tictactoe/game_options_builder')
require Rails.root.join('lib/tictactoe/params_parser')
require Rails.root.join('lib/tictactoe/game_state_builder')

include Tictactoe

RSpec.describe GameOptionsBuilder do
  let(:player_x_type) { 'human' }
  let(:player_o_type) { 'human' }
  let(:controller) { 'tictactoe' }
  let(:action) { 'game' }
  let(:board_size) { 3 }
  let(:params) { {
    'controller' => controller,
    'action' => action,
    'player_x_type' => player_x_type,
    'player_o_type' =>  player_o_type,
    'moves' => moves,
    'move' => move,
    'board_size' => board_size.to_s
  } }
  let(:parsed_params) { ParamsParser.parse(params) }
  let(:game) { GameBuilder.build(parsed_params.slice(
      :board_size, :player_x_type, :player_o_type, :move, :moves)) }
  let(:game_state) { GameStateBuilder.build(
      controller: controller,
      action: action,
      game: game) }

  context 'new game (default size = 3x3)' do
    let(:move) { nil }
    let(:moves) { [] }
    let(:game_options) { GameOptionsBuilder.new(params).build }

    it 'creates empty game options' do 
      expect(game_options[:board_data]).to eq(game.board.rows_as_square_numbers_and_statuses)
      expect(game_options[:board_data].length).to eq(board_size)
      expect(game_options[:game_state]).to eq(game_state)
      expect(game_options[:type]).to be :playable
      expect(game_options[:is_game_complete]).to be false
      expect(game_options[:winner]).to be nil
    end
  end

  context 'new game (default size = 4x4)' do
    let(:move) { nil }
    let(:board_size) { 4 }
    let(:moves) { [] }
    let(:game_options) { GameOptionsBuilder.new(params).build }

    it 'creates empty game options' do 
      expect(game_options[:board_data]).to eq(game.board.rows_as_square_numbers_and_statuses)
      expect(game_options[:board_data].length).to eq(board_size)
      expect(game_options[:game_state]).to eq(game_state)
      expect(game_options[:type]).to be :playable
      expect(game_options[:is_game_complete]).to be false
      expect(game_options[:winner]).to be nil
    end
  end
  
  context 'completed game' do
    let(:move) { 3.to_s }
    let(:moves) { [1, 4, 2, 5].map(&:to_s) }
    let(:game_options) { GameOptionsBuilder.new(params).build }

    it 'reports draw' do
      expect(game_options[:is_game_complete]).to be true
      expect(game_options[:winner]).to be :x
    end
  end
end
