require 'sinatra'
require 'sinatra/reloader'

 @@secret_number = rand(100)
 @@guess_counter = 6

get '/' do
  guess = params["guess"].to_i
  message = check_guess(guess)
  color = set_color(message)
  erb :index, :locals => {:message => message, :color => color}
end

def check_guess(guess)
  secret_number = @@secret_number
  @@guess_counter -= 1
  case
  when @@guess_counter > 0
    if params["cheat"] == "true"
    "THE SECRET NUMBER IS #{secret_number}"
    elsif guess > (secret_number + 5)
      "WAY TOO HIGH"
    elsif guess > secret_number
      "TOO HIGH"
    elsif guess == secret_number
      @@guess_counter = 5
      @@secret_number = rand(100)
      "YOU WIN! THE SECRET NUMBER IS #{secret_number}"
    elsif guess < (secret_number - 5)
      "WAY TOO LOW"
    else guess < secret_number
      "TOO LOW"
    end
  else
    restart_game
  end
end

def restart_game
  @@secret_number = rand(100)
  @@guess_counter = 5
  "YOUR GUESSES ARE UP. A NEW NUMBER WILL BE GENERATED"
end

def set_color(message)
  if message.include?("WAY")
    "red"
  elsif message.include?("SECRET")
    "green"
  elsif message.include?("NEW")
    "blue"
  else
    "pink"
  end
end
