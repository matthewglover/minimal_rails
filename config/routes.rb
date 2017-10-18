Rails.application.routes.draw do
  get 'simple/index' => 'simple#index'
  get 'tictactoe/game' => 'tictactoe#game'
  get 'tictactoe/result' => 'tictactoe#result'
end
