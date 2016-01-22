require 'sinatra'
require 'sinatra/reloader'

x = rand(0..100)

get '/' do
  "THE SECRET NUMBER IS #{x}"
end
