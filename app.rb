require 'active_support/core_ext/integer/inflections.rb'
require 'sinatra'
require "sinatra/reloader" if development?

get '/' do
  erb :form
end

post '/response' do
  b = params[:birthday].split("-").map(&:to_i)
  dob = Date.new(b[0], b[1], b[2])
  today = Date.today
  bdy_year = today.yday < dob.yday ? today.year : today.year + 1
  age = today.yday < dob.yday ? today.year - dob.year - 1 : today.year - dob.year
  days_left = days_from(today, Date.new(bdy_year, dob.month, dob.day))
  
  @cake = url("/images/cake#{rand(1..3)}.jpg")
  @fontstyle = 'not-birthday'
  @is_birthday = false
  @name = params[:name]

  @message = "There are <b>#{
    days_left
    }</b> days until your #{
      (age + 1).ordinalize
      } birthday!"

  if today.yday == dob.yday
    @is_birthday = true
    @fontstyle = 'happy-birthday'
    @message = "Happy #{age.ordinalize} Birthday"
  end

  erb :response
end

private

def days_from(from, to)
  (to - from).numerator
end


