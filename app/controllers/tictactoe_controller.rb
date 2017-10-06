require Rails.root.join('lib/tictactoe/game_options_builder')

class TictactoeController < ActionController::Base
  def game
    @options = Tictactoe::GameOptionsBuilder.new(params).build
    if @options[:is_game_complete]
      redirect_to(@options[:game_state].merge({action: :result})) 
    end
  end

  def result
    @options = Tictactoe::GameOptionsBuilder.new(params).build
  end
end
