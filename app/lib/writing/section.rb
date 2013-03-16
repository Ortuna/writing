module Kitana
  class Section
    include Kitana::Common
    
    attr_accessor :title, :body, :metadata
    attr_reader   :path,  :markdown

    def initialize(path)
      @path     = path
      @markdown = read_file
      @metadata = Md::Helper.extract_metadata(@markdown)
      @body     = Md::Helper.extract_markdown(@markdown)
      @title    = @metadata["title"] || ""
    end

    private
    def read_file
      File.read(@path)
    end
  end
end