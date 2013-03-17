class Writing < Padrino::Application
  register Padrino::Admin::AccessControl
  enable :sessions

  get :editor, :map => '/editor' do
    render 'editor/editor'
  end

  def code
    path  = "#{PADRINO_ROOT}/spec/fixtures/sample_book"
    @book = Kitana::Book.new(path)
    @book.chapters.first.sections.first.markdown
  end
end