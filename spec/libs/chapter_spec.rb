require "#{File.dirname(__FILE__)}/../spec_helper.rb"

describe Kitana::Chapter do
  before :each do 
    path  = "#{PADRINO_ROOT}/spec/fixtures/sample_book"
    @book = Kitana::Book.new(path)
  end

  it 'Should take the name of the folder' do
    @book.chapters.map{|c| c.title }.include?('Chapter 1').should == true
  end

  it 'Should take the name in _config.yml if present inside of folder' do
    #chapter 2
    @book.chapters.map{|c| c.title }.include?('Title From Configuration').should == true
  end

  it 'Should have sections' do
    chapter_1 = @book.chapters.select {|chapter| chapter.title == 'Chapter 1'}.first
    section   = chapter_1.sections.first

    #put in sections tests
    section.title.should == 'Section 1'
    section.body.should_not be_empty
  end
end