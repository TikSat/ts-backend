class WelcomeController < ApplicationController
  def index
    render plain: 'Welcome to Tiksat!'
  end
end
