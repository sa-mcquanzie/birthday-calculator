require 'active_support/core_ext/integer/inflections.rb'
require 'sinatra'
require "sinatra/reloader" if development?

get '/' do
  erb :form
end

post '/response' do
  b = params[:birthday].split("-").map(&:to_i)
  cake_number = rand(1..3)
  dob = Date.new(b[0], b[1], b[2])

  if Date.today.yday < dob.yday
    birthday = Date.new(Date.today.year, dob.month, dob.day)
  else
    birthday = Date.new(Date.today.year + 1, dob.month, dob.day)
  end

  age = birthday.year - dob.year - 1
  days_left = (birthday - Date.today).numerator

  @cake = url("/images/cake#{cake_number}.jpg")
  @is_birthday = Date.today.month == birthday.month && Date.today.day == birthday.day
  @fontstyle = @is_birthday ? "happy-birthday" : "not-birthday"
  @name = params[:name]

  if @is_birthday
    @birthday_message = "Happy #{age.ordinalize} Birthday"
  else
    @birthday_message = "There are <b>#{days_left}</b> days until your #{(age - 1).ordinalize} birthday!"
  end

  erb :response
end