import 'models/models.dart';

abstract class Repository {
  // TODO: Add find methods
  // 1
  List<Recipe> findAllRecipes();

// 2
  Recipe findRecipeById(int id);

// 3
  List<Ingredient> findAllIngredients();

// 4
  List<Ingredient> findRecipeIngredients(int recipeId);


// TODO: Add insert methods
// 5
  int insertRecipe(Recipe recipe);

// 6
  List<int> insertIngredients(List<Ingredient> ingredients);


  // TODO: Add delete methods
// 7
  void deleteRecipe(Recipe recipe);

// 8
  void deleteIngredient(Ingredient ingredient);

// 9
  void deleteIngredients(List<Ingredient> ingredients);

// 10
  void deleteRecipeIngredients(int recipeId);


  // TODO: Add initializing and closing methods
// 11
  Future init();
// 12
  void close();

}
