module Kitana
  class Section
    include Kitana::Common
    
    attr_accessor :title, :body
    attr_reader   :path

    def initialize(path)
      @path = path
      load_section
    end

    private
    def load_section
      body  = read_body
      title = extract_title
    end

    def read_body
      File.read(File.open(path))
    end

    def extract_title
      
    end
  end
end