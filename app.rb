require 'active_support/core_ext/integer/inflections.rb'
require 'sinatra'
require "sinatra/reloader" if development?

get '/' do
  erb :form
end

post '/response' do
  name = params[:name]
  b = params[:birthday].split("-").map(&:to_i)  
  today = Date.today
  dob = Date.new(b[0], b[1], b[2])

  if Date.today.yday < dob.yday
    birthday = Date.new(today.year, dob.month, dob.day)
  else
    birthday = Date.new(today.year + 1, dob.month, dob.day)
  end

  days_left = (birthday - today).numerator
  formatted_date = birthday.strftime("#{birthday.day.ordinalize} of %B, #{birthday.year}")
  is_birthday = today.month == birthday.month && today.day == birthday.day

  if is_birthday
    @birthday_message = "Happy birthday #{name}!!!"
  else
    @birthday_message = "Hello #{name} :)\nYour birthday is in #{days_left} days on the #{formatted_date}"
  end

  cake_number = rand(1..3)

  @cake = url("/images/cake#{cake_number}.jpg")

  erb :response
end