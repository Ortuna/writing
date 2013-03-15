module Kitana
  class Section
    include Kitana::Common

    def initialize(path)
      @path = path
    end
  end
end