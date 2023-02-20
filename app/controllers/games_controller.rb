require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array('a'..'z').sample(10)
  end

  def score
    @score = params[:score]
    @letters = params[:letters].split

    url = "https://wagon-dictionary.herokuapp.com/#{@score}"
    user_serialized = URI.open(url).read
    user = JSON.parse(user_serialized)
    if params[:letters].include?(user["word"])
      @result = "Congratulations! #{user["word"].upcase} is a valid English word!"
    elsif user["found"] == false
      @result = "Sorry but #{user["word"].upcase} does not seem to be a valid English word..."
    else @letters != user["found"]
      @result = "Sorry but #{user["word"].upcase} can't be built out of #{@letters}"
    end
  end
end
