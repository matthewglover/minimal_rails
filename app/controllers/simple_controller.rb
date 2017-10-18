class SimpleController < ActionController::Metal
  include AbstractController::Rendering
  include ActionView::Layouts
  append_view_path "#{Rails.root}/app/views"
  
  def index
    render 'simple/index'
  end
end
