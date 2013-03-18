class Writing < Padrino::Application
  register Padrino::Rendering
  register Padrino::Helpers
  layout :writing

  get :index do
    path  = "#{PADRINO_ROOT}/spec/fixtures/sample_book"
    @book = Kitana::Book.new(path)
    render :index
  end


  private
  def page_slug
    request.path == '/' ? 'home' : request.path.parameterize
  end
end
