require("bundler/setup")
Bundler.require(:default)
also_reload('lib/**/*.rb')

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }



def clear_all
  CategoryAssignment.delete_all()
  Category.delete_all()
  IngredientAssignment.delete_all()
  Ingredient.delete_all()
  Instruction.delete_all()
  Recipe.delete_all()
  UserRecipe.delete_all()
  User.delete_all()
end
