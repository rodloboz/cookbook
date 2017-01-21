require 'csv'

class Cookbook
  attr_reader :recipes

  def initialize(csv_file)
    @csv_file = csv_file
    @recipes = []
    load_csv
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_to_csv
  end

  def remove_recipe(recipe_id)
    @recipes.delete_at(recipe_id)
    save_to_csv
  end

  def all
    @recipes
  end

  private

  def load_csv
    CSV.foreach(@csv_file) do |row|
      atributes = {
          name: row[0],
          description: row[1],
          time: row[2],
          difficulty: row[3],
          img_url: row[4]
        }
      @recipes << Recipe.new(atributes)
    end
  end

  def save_to_csv
    CSV.open(@csv_file, 'wb') do |csv|
      @recipes.each do |recipe|
        atributes = [recipe.name, recipe.description, recipe.time, recipe.difficulty, recipe.done, recipe.img_url]
        csv << atributes
      end
    end
  end
end
