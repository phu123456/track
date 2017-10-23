class StaticPagesController < ApplicationController
  def home
    @positions = Position.all
    @vehicles = Vehicle.all
  end

  def about
  end
end
