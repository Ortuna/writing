module Kitana
  class Section
    include Kitana::Common
    
    attr_accessor :title, :markdown, :metadata
    attr_reader   :path

    def initialize(path)
      @path     = File.expand_path(path)
      @markdown = read_markdown
      @metadata = Md::Helper.extract_metadata(@markdown)
      @title    = @metadata["title"] || ""
    end

    def save
      save_markdown
    end

    def relative_path
      parts = path.split('/')
      "#{parts[parts.size-4]}/#{parts[parts.size-2]}/#{basename}"
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