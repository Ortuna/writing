class Writing < Padrino::Application
  register Padrino::Rendering
  register Padrino::Helpers
  
  get :index do
    render :index
  end

end
