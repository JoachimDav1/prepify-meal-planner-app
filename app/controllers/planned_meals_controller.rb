class PlannedMealsController < ApplicationController
  def index
    @planned_meals = current_user.planned_meals
  end

  def create
    recipe = Recipe.find(params[:recipe_id])

    @planned_meal = PlannedMeal.new(planned_meal_params)
    @planned_meal.user = current_user
    @planned_meal.recipe = recipe

    if @planned_meal.save!
      redirect_to planned_meals_path
    else
      flash.now[:alert] = 'Your recipe could not be added to the calendar...'
      render 'recipes/show', status: :unprocessable_entity
    end
  end

  private

  def planned_meal_params
    params.require(:planned_meal).permit(:date)
  end
end