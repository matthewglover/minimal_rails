require 'rails_helper'

RSpec.describe 'Rendering a refresh partial', type: :view do
  let(:player_x_type) { 'human' }
  let(:player_o_type) { 'computer' }
  let(:game_state) { {
    controller: 'tictactoe',
    action: 'game',
    player_x_type: player_x_type,
    player_o_type: player_o_type,
  } }

  let(:fragment) do
    render(partial: 'tictactoe/computer_move_refresh', locals: { game_state: game_state })
    Nokogiri::HTML::fragment(rendered)
  end

  it 'renders http-equiv meta tag' do
    expect(fragment.xpath('./meta').attribute('http-equiv').value).to eq('refresh')
  end

  it 'renders meta tag with content link to next game state' do
    expect(fragment.xpath('./meta').attribute('content').value).to include(
      url_for(game_state))
  end
end
