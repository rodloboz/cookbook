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

  def remove_recipe(img_url)
    @recipes = @recipes.delete_if { |recipe| recipe.img_url == img_url }
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
          time: row[1],
          difficulty: row[2],
          img_url: row[3]
        }
      @recipes << Recipe.new(atributes)
    end
  end

  def save_to_csv
    CSV.open(@csv_file, 'wb') do |csv|
      @recipes.each do |recipe|
        atributes = [recipe.name, recipe.time, recipe.difficulty, recipe.img_url]
        csv << atributes
      end
    end
  end
end
