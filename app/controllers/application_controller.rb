class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!

  get '/recipes' do
    @recipe = Recipe.all.each
    erb :recipes
  end

  post '/recipes' do
    @name = params[:recipe_name]
    @ingredients = params[:ingredients]
    @cook_time = params[:cook_time]
    Recipe.create(name: @name, ingredients: @ingredients, cook_time: @cook_time)
    erb :recipes
  end



  # patch '/recipes' do

  # end

  get '/recipes/new' do
    erb :new
  end

  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :single_recipe
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe_name_input = @recipe.name
    @ingredients_input = @recipe.ingredients
    @cook_time_input = @recipe.cook_time
    erb :edit
  end


  delete '/recipes/:id' do
    if Recipe.count == 0
      erb :recipes
    else
      @recipe_to_delete = Recipe.find_by_id(params[:id])
      @recipe_to_delete.destroy
      erb :recipes  
    end
  end


end
