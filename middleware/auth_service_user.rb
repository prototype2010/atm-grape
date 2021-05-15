class AuthServiceUser
  def initialize(app)
    @app = app
  end

  def call(env)
    call_next(env)
  end

  def call_next(env)
    @app.call(env)
  end
end