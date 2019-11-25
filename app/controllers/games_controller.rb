require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def english?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    Json.parse(File.read(url)[:found])
  end

  def new
    alfabet = ('a'..'z').to_a
    @letters_array = []
    10.times { @letters_array << alfabet.sample }
  end

  def score
    word = params[:word]
    word_counter = Hash.new(0)
    word.each_char { |letter| word_counter[letter] += 1 }
    letters = params[:letters]
    answer_counter = Hash.new(0)
    letters.split.each { |letter| answer_counter[letter] += 1 }
    if (word_counter[letter] <= answer_counter[letter]) == false
      @result = "Sorry but '#{word}' can not be built from #{letters}"
    elsif english?(word) == false
      @result = "Sorry but #{word} is not a valid english word"
    else
      @result = "Congratulations, '#{word}' is a valid English word! "
    end
  end
end
