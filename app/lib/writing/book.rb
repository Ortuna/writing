module Kitana
  class Book
    attr_accessor :book_path,    :title, 
                  :description,  :author, 
                  :author_email, :chapters_dir

    def initialize(book_path)
      @book_path = book_path
      load_book
    end

    ###
    ## Gives all the chapters in this
    #  book.
    #
    def chapters
      []
    end

    private
    def load_book
      @config ||= {}
      @config.merge! read_config
      set_config(@config)
    end

    def set_config(config)
      config.each do |option, value|
        send("#{option}=", value) if respond_to?("#{option}=")
      end
    end

    def read_config
      YAML::load( File.open("#{book_path}/#{config_path}") )
    end

    def config_path
      "_config.yml"
    end
  end
end