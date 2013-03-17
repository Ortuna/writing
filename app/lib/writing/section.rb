module Kitana
  class Section
    include Kitana::Common
    
    attr_accessor :title, :markdown, :metadata
    attr_reader   :path

    def initialize(path)
      @path     = path
      @markdown = read_file
      @metadata = Md::Helper.extract_metadata(@markdown)
      @title    = @metadata["title"] || ""
    end

    def save
      save_markdown
    end

    def self.create(book, name)
      self.new "#{book.path}/#{name}.md"
    end

    private
    def save_markdown
      File.open path { |f| f.write markdown }
    end

    def read_file
      File.read(@path)
    end
  end
end