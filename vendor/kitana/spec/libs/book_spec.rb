require "#{File.dirname(__FILE__)}/../spec_helper.rb"

describe Kitana::Book do
  before :each do 
    @path  = "#{FIXTURE_ROOT}/sample_book"
    @book  = Kitana::Book.new(@path)
  end

  #Basic required features
  describe "Configuration" do
    it 'Should have a title' do
      @book.title.should == 'Sample Book'
    end

    it 'Should have a description' do
      @book.description.should == 'This is a sample book'
    end

    it 'Should have an author' do
      @book.author.should == 'Your Name'
    end

    it 'Should have an author email' do
      @book.author_email.should == 'you@example.com'
    end

    it 'Should have a chapters_dir' do
      @book.chapters_path.should == '/chapters'
    end

    it 'Should have chapters as an array' do
      @book.chapters.should_not be_nil
    end

    it 'Should give the basename correctly' do
      @book.basename.should == 'sample_book'
    end

    it 'Should only have 3 chapters' do
      @book.chapters.size.should be 3
    end
  end

end