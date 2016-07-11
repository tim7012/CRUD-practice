class WelcomeController < ApplicationController

  def index

  end

  # GET /welcome/say_hello
  def say

  end

  def station

     @stations = Station.all

  end

end
