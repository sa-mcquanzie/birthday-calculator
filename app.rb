require 'activesupport'
require 'sinatra'
require "sinatra/reloader" if development?

get '/' do
  erb :form
end

post '/response' do
  @name = params[:name]
  b = params[:birthday].split("-").map(&:to_i)  
  today = Date.today
  dob = Date.new(b[0], b[1], b[2])

  if Date.today.yday < dob.yday
    next_birthday = Date.new(today.year, dob.month, dob.day)
  else
    next_birthday = Date.new(today.year + 1, dob.month, dob.day)
  end

  @days_left = (next_birthday - today).numerator

  erb :response
end