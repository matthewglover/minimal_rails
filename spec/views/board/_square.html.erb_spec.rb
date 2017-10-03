require 'rails_helper'

RSpec.describe 'Rendering a square partial', type: :view do
  let(:game_state) do
    {
      controller: :simple,
      action: :index,
      player_x_type: :human,
      player_o_type: :human,
      moves: [1, 2]
    }
  end
  let(:square_data) { [square_number, square_value] }
  let(:fragment) do
    render(partial: 'board/square', locals: { 
      square_data: square_data, 
      type: square_type, 
      game_state: game_state })
    Nokogiri::HTML::fragment(rendered)
  end
  let(:square_node) { fragment.xpath('./div[@class="square"]') }

  context 'empty square number' do
    let(:square_number) { 1 }
    let(:square_value) { :empty }
    let(:square_type) { :static }

    it "has a root square node" do
      expect(square_node.length).to eq(1)
    end

    it "has id of square_1" do
      expect(square_node.attribute('id').value).to eq("square_1")
    end
    
    it "has text of 1" do
      expect(square_node.text).to include(square_number.to_s)
    end
  end

  context 'square number 2 taken by X' do
    let(:square_number) { 2 }
    let(:square_value) { :x }
    let(:square_type) { :static }

    it "has id of square_2" do
      expect(square_node.attribute('id').value).to eq("square_2")
    end
    
    it "has text of 2" do
      expect(square_node.text).to include("X")
    end
  end

  context 'square number 2 taken by O and playable' do
    let(:square_number) { 2 }
    let(:square_value) { :o }
    let(:square_type) { :playable }

    it "has id of square_2" do
      expect(square_node.attribute('id').value).to eq("square_2")
    end

    it "does not have link" do
      expect(square_node.xpath('./a').length).to eq(0)
    end
  end

  context 'empty square number 2 and playable' do
    let(:square_number) { 2 }
    let(:square_value) { :empty }
    let(:square_type) { :playable }

    it "has id of square_2" do
      expect(square_node.attribute('id').value).to eq("square_2")
    end

    it "has link" do
      expect(square_node.xpath('./a').length).to eq(1)
    end

    it "sets querystring options to game state" do
      link_string = square_node.xpath('./a').attribute('href').value
      uri = URI(link_string)
      params = Rack::Utils.parse_nested_query(uri.query)
      expect(params).to eq({
        'player_o_type' => game_state[:player_o_type].to_s,
        'player_x_type' => game_state[:player_x_type].to_s,
        'moves' => game_state[:moves].map(&:to_s),
        'move' => square_number.to_s
      })
    end
  end
end
