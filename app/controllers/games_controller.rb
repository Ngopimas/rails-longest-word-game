require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word]
    @letters = params[:grid]
    a_grid = @letters
    @grid = a_grid.gsub(' ', ', ')

    word_serialized = open("https://wagon-dictionary.herokuapp.com/#{@word}").read
    word = JSON.parse(word_serialized)

    if word['found'] == false
      @result = "Sorry but <b>#{@word.upcase}</b> does not seem to be a valid English word..."
    elsif @word.upcase.chars.all? { |letter| @word.upcase.chars.count(letter) > @letters.count(letter) }
      @result = "Sorry but <b>#{@word.upcase}</b> can't be build out of #{@grid}"
    else
      @result = "<b>Congratulations!</b> #{@word.upcase} is a valid English word!"
    end
  end
end
