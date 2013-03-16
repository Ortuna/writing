  require "#{File.dirname(__FILE__)}/../spec_helper.rb"

describe Kitana::Book do
  before :each do 
    @path  = "#{PADRINO_ROOT}/tmp/sample_book_test"
    @book = Kitana::Book.new(@path)
    @book.create
  end

  after :each do
    @book.delete!
  end

  #Checkout a certain date feature
  describe "Checkout" do
    it 'Should not exist for invalid paths' do
      book = Kitana::Book.new('/tmp')
      book.send(:repo_exists?).should == false
    end

    it 'Should create a book repo' do
      repo = @book.send(:repo)
      repo.should_not be_nil
      repo.commits.first.should_not be_nil
    end

    it 'Should save changed configs to file' do
      # config_path = "#{@path}/_config.yml"
      # output = YAML::dump({'title' => 'Sample Book Test'}, output)
    end

    xit 'Should be able to display changes from a minute ago' do
      # @book.checkout(1.minute.ago)
    end

  end
end