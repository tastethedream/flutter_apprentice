import 'dart:core';
import 'package:flutter/foundation.dart';
// 1
import 'repository.dart';
// 2
import 'models/models.dart';


// 3
class MemoryRepository extends Repository with ChangeNotifier {
  // 4
  final List<Recipe> _currentRecipes = <Recipe>[];
  // 5
  final List<Ingredient> _currentIngredients = <Ingredient>[];

  // TODO: Add find methods
  @override
  List<Recipe> findAllRecipes() {
    // 7
    return _currentRecipes;
  }

  @override
  Recipe findRecipeById(int id) {
    // 8
    return _currentRecipes.firstWhere((recipe) => recipe.id == id);
  }

  @override
  List<Ingredient> findAllIngredients() {
    // 9
    return _currentIngredients;
  }

  @override
  List<Ingredient> findRecipeIngredients(int recipeId) {
    // 10
    final recipe =
    _currentRecipes.firstWhere((recipe) => recipe.id == recipeId);
    // 11
    final recipeIngredients = _currentIngredients
        .where((ingredient) => ingredient.recipeId == recipe.id)
        .toList();
    return recipeIngredients;
  }


  // TODO: Add insert methods
  @override
  int insertRecipe(Recipe recipe) {
    // 12
    _currentRecipes.add(recipe);
    // 13
    if (recipe.ingredients != null) {
      insertIngredients(recipe.ingredients!);
    }
    // 14
    notifyListeners();
    // 15
    return 0;
  }

  @override
  List<int> insertIngredients(List<Ingredient> ingredients) {
    // 16
    if (ingredients.length != 0) {
      // 17
      _currentIngredients.addAll(ingredients);
      // 18
      notifyListeners();
    }
    // 19
    return <int>[];
  }


  // TODO: Add delete methods
  @override
  void deleteRecipe(Recipe recipe) {
    // 20
    _currentRecipes.remove(recipe);
    // 21
    if (recipe.id != null) {
      deleteRecipeIngredients(recipe.id!);
    }
    // 22
    notifyListeners();
  }

  @override
  void deleteIngredient(Ingredient ingredient) {
    // 23
    _currentIngredients.remove(ingredient);
  }

  @override
  void deleteIngredients(List<Ingredient> ingredients) {
    // 24
    _currentIngredients
        .removeWhere((ingredient) => ingredients.contains(ingredient));
    notifyListeners();
  }

  @override
  void deleteRecipeIngredients(int recipeId) {
    // 25
    _currentIngredients
        .removeWhere((ingredient) => ingredient.recipeId == recipeId);
    notifyListeners();
  }


  // 6
  @override
  Future init() {
    return Future.value(null);
  }

  @override
  void close() {}
}
