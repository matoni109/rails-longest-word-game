require 'open-uri'
require 'json'

class GamesController < ApplicationController


  def new
    # TODO: generate random grid of letters
    gen_grid = ('A'..'Z').to_a + ('A'..'N').to_a
    @letters = gen_grid.sample(10)
    session[:passed_variable] = @letters
  end

  def score
    @letters = session[:passed_variable]
    # binding.pry

    # @session_score = session[:passed_variable2]
    # @this_score = 0
    # @total_score = @session_score || 0


    @attempt = params[:word] || ""
    @response = ""
    url = "https://wagon-dictionary.herokuapp.com/#{@attempt}"
    word_back = open(url).read
    word_hash = JSON.parse(word_back)
    # raise
    grid_check = @letters
    check = @attempt.upcase
    #code from stack
    letter_count = grid_check.each_with_object(Hash.new(0)){ |item, hash| hash[item] += 1 }
    attempt_count = @attempt.upcase.split("").each_with_object(Hash.new(0)){ |item, hash| hash[item] += 1 }
    # end code from stack
    #binding.pry

    if check.chars.uniq.all?{|char| grid_check.include?(char)} != true || @attempt.empty? == true
      @attempt.empty? ? @attempt = "BLANK" : @attempt = @attempt

      @response = "Sorry but <b>#{@attempt.upcase}</b> can't be built out of #{grid_check.join(' ')}"
    elsif check.chars.uniq.all?{|char| grid_check.include?(char)} == true && word_hash["found"] == false

      @response = "sorry but <b>#{@attempt.upcase}</b> is not an English word :| "
    else

      @this_score = attempt_count.values.count * attempt_count.values.count

      # @session_score += @this_score

      # session[:passed_variable2] = @session_score

      # binding.pry

      @response = "<b>YAY #{@attempt.upcase}</b> is an English word :) "
    end

    return @response && @total_score
  end




end
