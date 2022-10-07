class RecipesController < ApplicationController

    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    
    def index
        recipe = Recipe.all
        render json: recipe
    end

    def create
        recipe = @user.recipes.create!(recipe_params)
        render json: recipe, include: :user, status: :created
    end

    private

    def deny_access(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unauthorized
    end

    def render_unprocessable_entity_response(invalid)
        puts invalid.record.errors.full_messages
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end
end
