require 'rails_helper'

RSpec.describe 'GET #game', type: :request do
  context 'New Human vs Human game' do
    before(:each) do
      get('/tictactoe/game?player_x_type=human&player_o_type=human')
    end

    it 'has 200 status' do
      is_valid_query
    end

    it 'returns a valid HTML document' do
      is_valid_html
    end

    it 'has container div' do
      has_container
    end

    it 'contains board' do
      has_board
    end

    it 'contains an empty board' do
      squares = get_board_squares
      expect(squares.length).to eq(9)
      squares.each do |square|
        expect(square.xpath('./a').length).to eq(1)
      end
    end
  end

  context 'Human vs Human after two moves' do
    before(:each) do
      params = {
        player_x_type: :human,
        player_o_type: :human,
        moves: [1, 2],
        move: 5
      }
      get("/tictactoe/game?#{params.to_query}")
    end

    it 'has 200 status' do
      is_valid_query
    end

    it 'returns a valid HTML document' do
      is_valid_html
    end

    it 'has container div' do
      has_container
    end

    it 'contains board' do
      has_board
    end

    it '1st square is an X' do
      squares = get_board_squares
      expect(squares[0].text).to include('X')
    end

    it '2nd square is an O' do
      squares = get_board_squares
      expect(squares[1].text).to include('O')
    end

    it '5th square is an X' do
      squares = get_board_squares
      expect(squares[4].text).to include('X')
    end

    it 'has links on all other squares' do
      squares = get_board_squares
      expect(squares.length).to eq(9)
      empty_squares = (squares.map.with_index {
        |s,i| [0,1,4].include?(i) ? nil : s }).grep(Integer)
      empty_squares.each do |square|
        expect(square.xpath('./a').length).to eq(1)
      end
    end
  end

  def is_valid_query
    expect(response.status).to eq(200)
  end
  
  def is_valid_html
    doc = Nokogiri::HTML(response.body) 
    expect(doc.errors.any?).to be false
  end

  def has_container
    doc = Nokogiri::HTML(response.body)
    container = doc.xpath('.//div[@class="container"]')
    expect(container.length).to eq(1)
  end

  def has_board
    doc = Nokogiri::HTML(response.body)
    container = doc.xpath('.//div[@class="container"]')
    board = container.xpath('./div[@class="board"]')
    expect(board.length).to eq(1)
  end

  def get_board_squares
    doc = Nokogiri::HTML(response.body)
    container = doc.xpath('.//div[@class="container"]')
    board = container.xpath('./div[@class="board"]')
    board.xpath('.//div[@class="square"]')
  end
end
