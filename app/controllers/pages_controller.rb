class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def favorite_recipes
    @recipes = current_user.favorites
  end
end
