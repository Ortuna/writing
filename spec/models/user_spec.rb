require File.dirname(__FILE__) + "/../spec_helper.rb"

describe User do
  def basic_user
    user          = User.new
    user.uid      = 'testuser@gmail.com'
    user.role     = 'author'
    user.provider = 'github'
    user.name     = 'Json Bourne'
    user
  end

  def save_user(user)
    user.save
    user
  end

  before :each do
    User.all.destroy
  end

  it 'Should be able to find a user by id #find_by_id' do
    save_user(user = basic_user)
    user.errors.should be_empty

    found_user = User.find_by_id(user.id)
    found_user.id.should == user.id
  end

  it 'Should be able to find a user by provider and uid' do
    save_user(user = basic_user)
    user.errors.should be_empty

    found_user = User.find_by_provider_and_uid(user.provider, user.uid)
    found_user.uid.should == user.uid
  end

  it 'Should require a unique uid' do
    user = basic_user
    user2 = basic_user

    user2.uid = 'testuser2@gmail.com'

    user.save
    user2.save

    user.errors.should be_empty
    user2.errors.should be_empty
  end

  describe '#create_with_omniauth' do
    def auth_fields
      {
        "provider" => 'github',
        "name"     => 'Jason Bourne',
        "uid"      => 'testuser@gmail.com'
      }
    end

    it 'Should be able to create with auth' do
      auth = auth_fields
      user = User.create_with_omniauth(auth)
      user.id.should_not be_nil
      user.errors.should be_empty
    end

    it 'Should not save with missing auth fields' do

      (auth = auth_fields).each do |field, value|
        auth_attributes = auth.dup
        auth_attributes.delete(field)
        user = User.create_with_omniauth(auth_attributes)
        user.should be_nil
      end
    end #it
  end #describe
end #describe main
