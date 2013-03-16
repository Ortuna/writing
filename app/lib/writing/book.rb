module Kitana
  class Book
    include Kitana::Common
    attr_accessor :title, 
                  :description,  :author, 
                  :author_email, :chapters_path,
                  :chapters,     :config

    attr_reader   :path, :repo

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

    ###
    ## Creates a repo at @path
    #
    def create
      return if repo_exists?
      create_init_git_repo
    end

    ### **Danger**
    ## rm -rf the folder
    #
    def delete!
      FileUtils.rm_rf @path
    end

    private
    def create_init_git_repo
      @repo = Grit::Repo.init(@path)
      new_config_path = "#{@path}/#{config_path}"
      FileUtils.touch new_config_path
      @repo.add new_config_path
      @repo.commit_index "First Commit"
    end

    def repo_exists?
      Grit::Repo.new(@path)
      return true
    rescue
      false
    end

    def configurable_options
      [:title, :description, :author, :author_email, :chapters_path]
    end

    def set_config(config)
      return if !config.respond_to?(:each)
      config.each do |option, value|
        next unless respond_to?("#{option}=") and
                    configurable_options.include?(option.downcase.to_sym)
          send("#{option}=", value)
      end
    end

    def load_book
      @config ||= {}
      @config.merge! read_config
      set_config(@config)
    end
  end
end