class Writing < Padrino::Application
  register Padrino::Rendering
  register Padrino::Helpers
  layout :writing

  get :index do
    render :index
  end


  private
  def page_slug
    request.path == '/' ? 'home' : request.path.parameterize
  end
end
