DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/todo_list.db")

class Task
  include DataMapper::Resource
  property :id, Serial
  property :description, Text
  property :completed, Boolean, default: false
  property :created_at, DateTime
end

DataMapper.finalize.auto_upgrade!

class TodoApp < Sinatra::Base
  set :erb, escape_html: true

  configure :development do
    register Sinatra::Reloader
  end

  # go straight to the list of tasks if opening e.g. localhost:9292/
  get '/' do
    redirect '/todos'
  end
  
  # route for displaying the list of todos
  get '/todos' do
    @tasks = Task.all(order: :created_at.desc)
    erb :todos
  end

  # route for adding a new task to the list
  post '/todos' do
    unless params[:description].empty? # prevent adding blank entries
      Task.create(description: params[:description], created_at: Time.now)
    end
    redirect '/todos'
  end

  # route for ticking a task as completed
  post '/todos/:id/complete' do
    task = Task.get(params[:id])
    task.update(completed: true)
  end

  # route for unticking a task
  post '/todos/:id/uncomplete' do
    task = Task.get(params[:id])
    task.update(completed: false)
  end

  # route for deleting a task
  delete '/todos/:id' do
    task = Task.get(params[:id])
    task.destroy
  end
end