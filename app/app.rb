class Writing < Padrino::Application
  register Padrino::Rendering
  register Padrino::Mailer
  register Padrino::Helpers
  enable :sessions

  layout :writing
  get :index do
    render :index
  end
end
