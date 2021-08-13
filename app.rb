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
  today = Date.today

  if Date.today.yday < dob.yday
    birthday = Date.new(today.year, dob.month, dob.day)
    next_age = birthday.year - dob.year + 1

  else
    birthday = Date.new(today.year + 1, dob.month, dob.day)
    next_age = birthday.year - dob.year
  end

  days_left = (birthday - today).numerator
  formatted_date = birthday.strftime("#{birthday.day.ordinalize} of %B, #{birthday.year}")
  
  @is_birthday = today.month == birthday.month && today.day == birthday.day

  if @is_birthday
    @birthday_message = "Happy Birthday"
  else
    @birthday_message = "Your #{next_age.ordinalize} birthday is in #{days_left} days on the #{formatted_date}"
  end

  @cake = url("/images/cake#{cake_number}.jpg")
  @fontstyle = @is_birthday ? "birthday" : "normal"
  @name = params[:name]

  erb :response
end