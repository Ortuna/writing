  require "#{File.dirname(__FILE__)}/../spec_helper.rb"

describe Kitana::Book do
  before :each do 
    path  = "#{PADRINO_ROOT}/spec/fixtures/sample_book"
    @book = Kitana::Book.new(path)
  end

  #Checkout a certain date feature
  describe "Checkout" do
    xit 'Should be able to display changes from a minute ago' do
      @book.checkout(1.minute.ago)
    end
  end
end