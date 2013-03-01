require File.dirname(__FILE__) + "/../spec_helper.rb"

describe Post do
  before :each do
    @post = Post.new
    @post.body = "Example blog post body"
    @post.title = "this is an example"
  end

  it "Should require body" do
    post = Post.new
    post.title = "Example Blog title"
    post.save
    post.errors[:body].should_not be_empty
  end

  it "Should require title" do
    post = Post.new
    post.body = "Example Blog body"
    post.save
    post.errors[:title].should_not be_empty
  end

  it "Should generate the path from the title and change on modify" do
    @post.save
    @post.path.should == "this-is-an-example"

    @post.title = "Another example"
    @post.save
    @post.path.should == "another-example"
  end

  it "Should have a updated_at timestamp on create and on modify" do
    time = Time.parse("Feb 24 1981")
    Time.stub!(:now).and_return(time)
    @post.save
    @post.updated_at.should == time

    time = Time.parse("Feb 24 1985")
    Time.stub!(:now).and_return(time)
    @post.title = 'Outta time!'
    @post.save
    @post.updated_at.should == time
  end

  it "Should have a created_at timestamp on create" do
    time = Time.parse("Feb 24 1982")
    Time.stub!(:now).and_return(time)
    @post.save
    @post.created_at.should == time
  end

  it "Should render the bodys markdown in HTML" do
    @post.body = "this is my text"
    @post.save
    @post.body.should == "<p>this is my text</p>\n"
  end
end
