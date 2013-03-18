class Writing
  def get_book(id)
    books_path = "#{PADRINO_ROOT}/spec/fixtures"
    @book = Kitana::Book.new("#{books_path}/#{id}")    
  end

end

Writing.controllers :book do
  register Padrino::Admin::AccessControl
  enable :sessions

  get :show_book, :map => '/book/:id' do |id|
    @book = get_book id
    render 'author/book/book'
  end

  get :show_chapter, :map => '/book/:id/:chapter' do
    id      = params[:id]
    chapter = params[:chapter]
    @book   = get_book id

    @chapter   = @book.chapters.detect do |c|
        c.title == chapter
    end

    render 'author/book/chapter'
  end

  get :show_section, :map => '/book/:id/:chapter/:section' do
    id      = params[:id]
    chapter = params[:chapter]
    section = params[:section]
    @book   = get_book id

    @chapter   = @book.chapters.detect do |c|
        c.title == chapter
    end

    @section = @chapter.sections.detect do |s|
        s.basename == section
    end
    @editor = true
    @code = @section.markdown
    render 'author/editor/editor'
  end
end