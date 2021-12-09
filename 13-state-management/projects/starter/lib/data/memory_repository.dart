import 'dart:core';
// 1
import 'repository.dart';
// 2
import 'models/models.dart';
import 'dart:async';



// 3
class MemoryRepository extends Repository {
  // 4
  final List<Recipe> _currentRecipes = <Recipe>[];
  // 5
  final List<Ingredient> _currentIngredients = <Ingredient>[];
  //1
  Stream<List<Recipe>>? _recipeStream;
  Stream<List<Ingredient>>? _ingredientStream;
// 2
  final StreamController _recipeStreamController =
  StreamController<List<Recipe>>();
  final StreamController _ingredientStreamController =
  StreamController<List<Ingredient>>();

// 3
  @override
  Stream<List<Recipe>> watchAllRecipes() {
    if (_recipeStream == null) {
      _recipeStream = _recipeStreamController.stream as Stream<List<Recipe>>;
    }
    return _recipeStream!;
  }

// 4
  @override
  Stream<List<Ingredient>> watchAllIngredients() {
    if (_ingredientStream == null) {
      _ingredientStream =
      _ingredientStreamController.stream as Stream<List<Ingredient>>;
    }
    return _ingredientStream!;
  }

  // TODO: Add find methods
  @override
// 1
  Future<List<Recipe>> findAllRecipes() {
    // 2
    return Future.value(_currentRecipes);
  }


  @override
 Future<Recipe> findRecipeById(int id) {
    // 8
    return Future.value(
        _currentRecipes.firstWhere((recipe) => recipe.id == id));
  }

  @override
  Future<List<Ingredient>> findAllIngredients() {
    // 9
    return Future.value(_currentIngredients);
  }

  @override
  Future<List<Ingredient>> findRecipeIngredients(int recipeId) {
    // 10
    final recipe =
    _currentRecipes.firstWhere((recipe) => recipe.id == recipeId);
    // 11
    final recipeIngredients = _currentIngredients
        .where((ingredient) => ingredient.recipeId == recipe.id)
        .toList();
    return Future.value(recipeIngredients);
  }


  // TODO: Add insert methods
  @override
// 1
  Future<int> insertRecipe(Recipe recipe) {
    _currentRecipes.add(recipe);
    // 2
    _recipeStreamController.sink.add(_currentRecipes);
    if (recipe.ingredients != null) {
      insertIngredients(recipe.ingredients!);
    }
    // 3
    // 4
    return Future.value(0);
  }


  @override
  Future<List<int>> insertIngredients(List<Ingredient> ingredients) {
    // 16
    if (ingredients.length != 0) {
      // 17
      _currentIngredients.addAll(ingredients);
      // 18

    }
    // 19
    return Future.value(<int>[]);
  }


  // TODO: Add delete methods
  @override
  Future<void> deleteRecipe(Recipe recipe) {
    // 20
    _currentRecipes.remove(recipe);
    _recipeStreamController.sink.add(_currentRecipes);
    // 21
    if (recipe.id != null) {
      deleteRecipeIngredients(recipe.id!);
    }
    return Future.value();
    // 22

  }

  @override
   Future<void> deleteIngredient(Ingredient ingredient) {
    // 23
    _currentIngredients.remove(ingredient);
    _ingredientStreamController.sink.add(_currentIngredients);
    return Future.value();
  }

  @override
  Future<void> deleteIngredients(List<Ingredient> ingredients) {
    // 24
    _currentIngredients
        .removeWhere((ingredient) => ingredients.contains(ingredient));
    _ingredientStreamController.sink.add(_currentIngredients);
    return Future.value();

  }

  @override
  Future<void> deleteRecipeIngredients(int recipeId) {
    // 25
    _currentIngredients
        .removeWhere((ingredient) => ingredient.recipeId == recipeId);
    _ingredientStreamController.sink.add(_currentIngredients);
    return Future.value();
  }


  // 6
  @override
  Future init() {
    return Future.value();
  }

  @override
  void close() {
    _recipeStreamController.close();
    _ingredientStreamController.close();
  }

}
