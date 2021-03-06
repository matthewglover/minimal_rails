require Rails.root.join('lib/tictactoe/game_state_builder')

RSpec.describe Tictactoe::GameStateBuilder do
  let(:controller) { 'tictactoe' }
  let(:action) { 'game' }
  let(:computer_move) { 7 }
  let(:computer_player) do
    computer_player = MattsTictactoeCore::ComputerPlayer.new
    allow(computer_player).to receive(:get_move).and_return(computer_move)
    computer_player
  end
  let(:game) { MattsTictactoeCore::Game.new(
    board_size: 3, player_x_type: :human, player_o_type: :computer, board: board, computer_player: computer_player) }

  context 'New Human vs Computer game (3x3)' do
    let(:board) { MattsTictactoeCore::Board.new([]) }

    it 'creates game state for current game' do
      game_state = Tictactoe::GameStateBuilder.build(
        controller: controller, action: action, game: game)
      expect(game_state).to eq({
        controller: controller,
        action: action,
        board_size: 3,
        player_x_type: game.player_x_type,
        player_o_type: game.player_o_type,
        moves: game.board.moves,
        move: nil
      })
    end
  end

  context 'New Human vs Computer game (4x4)' do
    let(:board) { MattsTictactoeCore::Board.new([1], size: 4) }

    it 'creates game state for current game' do
      game_state = Tictactoe::GameStateBuilder.build(
        controller: controller, action: action, game: game)
      expect(game_state).to eq({
        controller: controller,
        action: action,
        board_size: 4,
        player_x_type: game.player_x_type,
        player_o_type: game.player_o_type,
        moves: game.board.moves,
        move: computer_move
      })
    end
  end

  context 'Completed game (3x3)' do
    let(:board) { MattsTictactoeCore::Board.new([1, 4, 2, 5, 3]) }

    it 'creates game state for current game' do
      game_state = Tictactoe::GameStateBuilder.build(
        controller: controller, action: action, game: game)
      expect(game_state).to eq({
        controller: controller,
        action: action,
        board_size: 3,
        player_x_type: game.player_x_type,
        player_o_type: game.player_o_type,
        moves: game.board.moves,
        move: computer_move
      })
    end
  end
end
