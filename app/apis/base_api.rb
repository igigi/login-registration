require "sinatra/json"

class BaseApi < Sinatra::Base
  helpers Sinatra::JSON
  
  enable :logging

  configure :development do
    ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: 'db/sqlite3.db'
    )
  end

  configure :test do
    ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: 'db/sqlite3.db'
    )
  end

  configure :production do
    ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: 'db/sqlite3.db'
    )
  end
end