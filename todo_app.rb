DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/todo_list.db")

# models will go here

DataMapper.finalize.auto_upgrade!

class TodoApp < Sinatra::Base
  set :erb, escape_html: true

  configure :development do
    register Sinatra::Reloader
  end

  # routes will go here
end