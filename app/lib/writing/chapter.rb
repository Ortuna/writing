module Kitana
  class Chapter
    include Kitana::Common

    attr_reader   :path
    attr_accessor :title, :sections

    def initialize(path)
      @path = path
      set_config(read_config)
    end

    def title
      @title ||= File.basename(path)
    end

    def sections
      sections ||= inject_and_create("#{path}/*.md", Kitana::Section)
    end
  end
end