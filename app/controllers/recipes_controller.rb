class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
   if params[:query].present?
     @recipes = Recipe.search_by_name_and_category(params[:query])
   else
     @recipes = Recipe.all
   end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    @ingredients = []
    if !params[:recipe][:ingredients_attributes].nil?
      params[:recipe][:ingredients_attributes].values.each do |i|
        @ingredients << Ingredient.new(description: i[:description], recipe: @recipe)
      end
    end
    @recipe.ingredients = @ingredients
    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      render "new"
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: 'Your recipe was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :image, :image_cache, :category, ingredients_attributes: [:id, :description, :_destroy])
  end
end
