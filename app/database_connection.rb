require 'active_record'

class DatabaseConnection
  def initialize(app)
    @app = app
    @conn = connect
  end

  def call(env)
    env["rack.db_connection"] = @conn
    @app.call(env)
  end

  private
  def connect
    ActiveRecord::Base.establish_connection(
      :adapter => 'sqlite3',
      :database =>  'sinatra_application.sqlite3.db'
    )
  end
end
