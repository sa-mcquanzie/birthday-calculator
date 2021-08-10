require 'sinatra'
require "sinatra/reloader" if development?

get '/' do
  erb :form
end

post '/response' do
  @name = params[:name]
  birthday = params[:birthday].split("-")
  @year, @month, @day = birthday[0], birthday[1], birthday[2]

  erb :response
end