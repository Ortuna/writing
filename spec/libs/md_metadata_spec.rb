require "#{File.dirname(__FILE__)}/../spec_helper.rb"

describe Md::Helper do 
  def markdown_with_metadata
    """
    ----------
    title: Chapter 1
    author: Sumeet Singh
    email: ortuña@gmail.com
    ----------
    """
  end

  def markdown_without_metadata
    """Chapter 1
    =============
    - List item 1
    - List item 2"""
  end

  it 'Should extract metadata from markdown' do
    md = markdown_with_metadata + markdown_without_metadata
    metadata = Md::Helper.extract_metadata md
    metadata["title"].should == "Chapter 1"
    metadata["author"].should == "Sumeet Singh"
    metadata["email"].should == "ortuña@gmail.com"
  end

  it 'Should skip extracting data from markdown without metadata' do
    md = markdown_without_metadata

    metadata = Md::Helper.extract_metadata md
    metadata.size.should be 0
  end

  it 'Should extract just the markdown from string with metadata' do
    md = markdown_with_metadata + markdown_without_metadata

    markdown_text = Md::Helper.extract_markdown md
    markdown_text.strip.should == markdown_without_metadata
  end

end