module Kitana
  class Book
    include Kitana::Common
    attr_accessor :path,    :title, 
                  :description,  :author, 
                  :author_email, :chapters_path,
                  :chapters,     :config

    def initialize(book_path)
      @path = book_path
      load_book
    end

    ###
    ## Gives all the chapters in this
    #  book.
    #
    def chapters
      @chapters ||= inject_and_create("#{path}#{chapters_path}/*", Kitana::Chapter)
    end

    private
    def load_book
      @config ||= {}
      @config.merge! read_config
      set_config(@config)
    end
  end
end