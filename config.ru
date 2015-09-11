require 'bundler'
require 'tilt/erubis'
require 'sinatra/reloader'

Bundler.require

require './todo_app'
run TodoApp