module Tictactoe
  class ParamsParser
    def self.parse(params)
      { controller: params['controller'],
        action: params['action'],
        player_x_type: params['player_x_type'], 
        player_o_type: params['player_o_type'],
        moves: params['moves'] || [],
        move: params['move'] || nil }
    end
  end
end
