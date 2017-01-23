class Recipe
  attr_reader :name, :description, :time, :difficulty, :done, :img_url

  def initialize(atributes)
    @name = atributes[:name]
    @time = atributes[:time]
    @difficulty = atributes[:difficulty]
    @img_url = atributes[:img_url]
  end
end
