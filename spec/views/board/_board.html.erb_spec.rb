require 'rails_helper'

RSpec.describe 'Rendering the board template', type: :view do
  let(:board_data) { MattsTictactoeCore::Board.new.rows_as_square_numbers_and_statuses }
  let(:fragment) do 
    render(partial: 'board/board', locals: { 
      board_data: board_data, game_state: {}, type: :static })
    Nokogiri::HTML::fragment(rendered)
  end

  it 'has a root board node' do
    board_node = fragment.xpath('./div[@class="board"]')
    expect(board_node.length).to eq(1)
  end

  it 'has three row nodes' do
    row_nodes = fragment.xpath('.//div[@class="row"]')
    expect(row_nodes.length).to eq(3)
  end

  it 'has nine square nodes' do
    square_nodes = fragment.xpath('.//div[@class="square"]')
    expect(square_nodes.length).to eq(9)
  end
end
