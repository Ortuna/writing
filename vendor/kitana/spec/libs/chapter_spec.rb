require "#{File.dirname(__FILE__)}/../spec_helper.rb"

describe Kitana::Chapter do
  before :each do 
    path  = "#{FIXTURE_ROOT}/sample_book"
    @book = Kitana::Book.new(path)
  end

  it 'Should take the name of the folder' do
    @book.chapters.map{|c| c.title }.include?('Chapter 1').should == true
  end

  it 'Should take the name in _config.yml if present inside of folder' do
    @book.chapters.map{|c| c.title }.include?('Title From Configuration').should == true
  end

  it 'Should have sections' do
    chapter_1 = @book.chapters.select {|chapter| chapter.title == 'Chapter 1'}.first
    section   = chapter_1.sections.first

    section.title.should == 'Section 1'
    section.markdown.should_not be_empty
  end

  it 'Should have the correct base name' do
    @book.chapters.first.basename.should == 'Chapter 1'
  end

  it 'Should give a combination of book name and chapter' do
    @book.chapters.first.relative_path.should == 'sample_book/Chapter 1'
  end

  it 'Should have the book associated with it' do
    chapter = @book.chapters.first
    chapter.book.title.should == 'Sample Book'
  end
end