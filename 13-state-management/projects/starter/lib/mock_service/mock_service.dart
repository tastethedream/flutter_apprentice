import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

// 1
import 'package:chopper/chopper.dart';
// 2
import 'package:flutter/services.dart' show rootBundle;
import '../network/model_response.dart';
import '../network/recipe_model.dart';

class MockService {
  // 1
  late APIRecipeQuery _currentRecipes1;
  late APIRecipeQuery _currentRecipes2;
  // 2
  Random nextRecipe = Random();

// TODO: Add create and load methods
// 3
  void create() {
    loadRecipes();
  }

  void loadRecipes() async {
    // 4
    var jsonString = await rootBundle.loadString('assets/recipes1.json');
    // 5
    _currentRecipes1 = APIRecipeQuery.fromJson(jsonDecode(jsonString));
    jsonString = await rootBundle.loadString('assets/recipes2.json');
    _currentRecipes2 = APIRecipeQuery.fromJson(jsonDecode(jsonString));
  }


// TODO: Add query method
  Future<Response<Result<APIRecipeQuery>>> queryRecipes(
      String query, int from, int to) {
    // 6
    switch(nextRecipe.nextInt(2)) {
      case 0:
      // 7
        return Future.value(Response(http.Response('Dummy', 200, request: null),
            Success<APIRecipeQuery>(_currentRecipes1)));
      case 1:
        return Future.value(Response(http.Response('Dummy', 200, request: null),
            Success<APIRecipeQuery>(_currentRecipes2)));
      default:
        return Future.value(Response(http.Response('Dummy', 200, request: null),
            Success<APIRecipeQuery>(_currentRecipes1)));
    }
  }


}
