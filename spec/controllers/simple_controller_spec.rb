require 'rails_helper'

RSpec.describe 'GET #index', type: :request do
  before(:each) do
    get('/simple/index')
  end

  it 'has 200 status' do
    expect(response.status).to eq(200)
  end

  it 'has heading of Hello world' do
    doc = Nokogiri::HTML(response.body)
    heading = doc.xpath('.//div')
    expect(heading.length).to eq(1)
    expect(heading.text).to include('Hello, world!')
  end
end
