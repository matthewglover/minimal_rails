require 'rails_helper'

RSpec.describe 'Rendering a row partial', type: :view do
  let(:row_data) { [[1, :empty], [2, :empty], [3, :empty]] }

  context 'an empty row' do
    let(:fragment) do 
      render(partial: 'board/row', locals: { row_data: row_data, game_state: {}, type: :static })
      Nokogiri::HTML::fragment(rendered)
    end

    it "has a root row node" do
      row_node = fragment.xpath('./div[@class="row"]')
      expect(row_node.length).to eq(1)
    end

    it 'has three square nodes' do
      square_nodes = fragment.xpath('.//div[@class="square"]')
      expect(square_nodes.length).to eq(3)
    end
  end
end
