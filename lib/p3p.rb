class P3p

  def self.install_policy(policy)
    @@policy = policy
    #    Rails.application.config.middleware.insert_before ActionDispatch::Session::CookieStore, P3p
  end

  def initialize(app)
    @app = app
  end

  def call(env)
    response = @app.call(env)
    insert_p3p(response)
  end

  private

  def insert_p3p(response)
    if response[0] == 304
      response[1].delete('Set-Cookie')
    else
      response[1].update('P3P' => "CP=\"#{@@policy}\"")
    end
    response
  end
end