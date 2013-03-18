module Kitana
  class Chapter
    include Kitana::Common

    attr_reader   :path
    attr_accessor :title, :sections, :book

    def initialize(path)
      @path = File.expand_path(path)
      set_config(read_config)
    end

    def title
      @title ||= basename
    end

    def sections
      @sections ||= inject_and_create("#{path}/*.md", Kitana::Section)
    end

    def save
      save_config
      save_self
      save_sections
    end

    def self.create(book, path)
      self.new "#{book.path}/#{path}"
    end

    def relative_path
      parts = path.split('/')
      "#{parts[parts.size-3]}/#{basename}"
    end

    private
    def save_sections
      sections.each { |section| section.save }
    end

    def save_config

    end

    def save_self
      return if File.exists?(@path)
      FileUtils.mkdir(@path)
    end
  end
end