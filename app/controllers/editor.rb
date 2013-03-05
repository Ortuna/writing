class Writing < Padrino::Application
  register Padrino::Admin::AccessControl
  enable :sessions

  get :profile, :map => '/profile' do
    # session["session_id"]
    "In editor.rb"
  end
end