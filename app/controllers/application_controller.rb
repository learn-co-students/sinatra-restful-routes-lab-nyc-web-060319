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
    redirect '/recipes/'
  end

  post '/recipes/' do
    @name = params[:name]
    @ingredients = params[:ingredients]
    @cook_time = params[:cook_time]
    Recipe.create(name: @name, ingredients: @ingredients, cook_time: @cook_time)
    redirect "/recipes/#{Recipe.last.id}"
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    # binding.pry
    @recipe.save
    erb :single_recipe
  end

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
    # binding.pry
    if Recipe.count == 0
      redirect '/recipes'
    else
      # @recipe_to_delete = Recipe.find_by_id(params[:id])
      Recipe.destroy(params[:id])
      # binding.pry
      redirect '/recipes'
    end
  end


end
