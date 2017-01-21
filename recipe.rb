class Recipe
  attr_reader :name, :description, :time, :difficulty, :done, :img_url

  def initialize(atributes)
    @name = atributes[:name]
    @description = atributes[:description]
    @time = atributes[:time]
    @difficulty = atributes[:difficulty]
    @done = false
    @img_url = atributes[:img_url]
  end
end
