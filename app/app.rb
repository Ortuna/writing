class Writing < Padrino::Application
  register Padrino::Rendering
  register Padrino::Helpers
  layout :writing

  get :index do
    render :index
  end

end
