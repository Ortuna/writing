class User
  include DataMapper::Resource

  property :id,       Serial
  property :uid,      String
  property :role,     String
  property :provider, String
  property :name,     String

  validates_presence_of   :uid, :provider, :name
  validates_uniqueness_of :uid

  def self.find_by_id(id)
    first(:id => id)
  end

  def self.find_by_provider_and_uid(provider, uid)
    first(:provider => provider, 
          :uid => uid)
  end

  def self.create_with_omniauth(auth)
    user       = User.new
    user.attributes = [:provider, :uid, :name].inject({:role => 'author'}) do |memo, attr|
      key = attr.to_s
      memo[attr] = auth[key] ? auth[key] : nil
      memo
    end
    user.save
    user
  end

end