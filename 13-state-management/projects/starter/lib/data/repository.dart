import 'models/models.dart';

abstract class Repository {
  // TODO: Add find methods
  // 1
  Future<List<Recipe>> findAllRecipes();
  // 1
  Stream<List<Recipe>> watchAllRecipes();
// 2
  Stream<List<Ingredient>> watchAllIngredients();



// 2
  Future<Recipe> findRecipeById(int id);

// 3
  Future<List<Ingredient>> findAllIngredients();

// 4

  Future<List<Ingredient>> findRecipeIngredients(int recipeId);


// TODO: Add insert methods
// 5
  Future<int> insertRecipe(Recipe recipe);
// 6
  Future<List<int>> insertIngredients(List<Ingredient> ingredients);



  // TODO: Add delete methods
// 7
  Future<void> deleteRecipe(Recipe recipe);

// 8
  Future<void> deleteIngredient(Ingredient ingredient);

// 9
  Future<void> deleteIngredients(List<Ingredient> ingredients);

// 10
  Future<void> deleteRecipeIngredients(int recipeId);


  // TODO: Add initializing and closing methods
// 11
  Future init();
// 12
  void close();

}
