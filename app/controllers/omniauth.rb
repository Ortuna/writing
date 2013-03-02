class Writing < Padrino::Application
  register Padrino::Admin::AccessControl
  enable :sessions
  
  #access
  set :login_page,      '/login'
  set :admin_model,     'User'
  set :protected_paths, ['/']
  set :allowed_paths,   ['/login', '/logout', '/auth/github', '/auth/github/callback', '/profile']

  access_control.roles_for :any do |role|
    protected_paths.each do |path|
      role.protect path
    end

    allowed_paths.each do |path|
      role.allow path
    end
  end
  
  #providers
  use OmniAuth::Builder do
    provider :github, '2e0806ae149248209186', '5cb5a931148f01de4698920cbabe67e6a0034488', scope: "user,repo"
  end

  get :auth, :map => '/auth/:provider/callback' do
    auth    = request.env["omniauth.auth"]
    account = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) ||
              User.create_with_omniauth(auth)
    account ? redirect_and_set_current_account(auth) : redirect_auth_failed
  end

  get :login, :map => '/login' do
    redirect_local '/auth/github'
  end
  
  get :logout, :map => '/logout' do
    set_current_account(nil)
    redirect url(:index)
  end

  get :profile, :map => '/profile' do
    session["session_id"]
  end

  private
  def redirect_auth_failed
    redirect_local '/failed'
  end

  def redirect_and_set_current_account(account)
    set_current_account(account)
    redirect_local '/profile'
  end

  def redirect_local(to)
    redirect "http://" + request.env["HTTP_HOST"] + to
  end

end