# Better than playing whack-a-mole with 'end' keyword
class HomeController < ApplicationController
  def index
    @artists = Artist.all
    render json: @artists
  end
end
