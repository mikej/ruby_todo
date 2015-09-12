DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/todo_list.db")

# models will go here

DataMapper.finalize.auto_upgrade!

class TodoApp < Sinatra::Base
  set :erb, escape_html: true

  configure :development do
    register Sinatra::Reloader
  end

  # example route, access this with http://localhost:9292/example
  get '/example' do
    "The example worked!"
  end

  # add more routes here
end