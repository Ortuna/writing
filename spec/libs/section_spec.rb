require "#{File.dirname(__FILE__)}/../spec_helper.rb"

describe Kitana::Section do
  
  before :each do 
    path  = "#{PADRINO_ROOT}/spec/fixtures/sample_book/chapters/Chapter 1/Section 1.md"
    @section = Kitana::Section.new(path)
  end

  it 'Should have a title' do
    @section.title.should == 'Section 1'
  end

  it 'Should have markdown' do
    @section.markdown.should_not be_nil
  end

  it 'Should have metadata' do
    @section.metadata.should_not be_empty
    @section.metadata["author"].should_not be_blank
  end

  it 'Should have body' do
    @section.body.should_not be_empty
  end
end