module Kitana
  class Section
    include Kitana::Common
    
    attr_accessor :title, :markdown, :metadata
    attr_reader   :path

    def initialize(path)
      @path     = path
      @markdown = read_markdown
      @metadata = Md::Helper.extract_metadata(@markdown)
      @title    = @metadata["title"] || ""
    end

    def save
      save_markdown
    end

    def self.create(chapter, name)
      self.new "#{chapter.path}/#{name}.md"
    end

    private
    def save_markdown
      File.open(path,'w+') { |f| f.write markdown }
    end

    def read_markdown
      File.read(path) if File.exists?(path)
    end
  end
end