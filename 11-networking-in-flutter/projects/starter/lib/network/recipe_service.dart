import 'package:http/http.dart';


const String apiKey = 'ade4ebcb3ca5fc29a98b40280bc569c0';
const String apiId = '7e5c256b';
const String apiUrl = 'https://api.edamam.com/search';

class RecipeService {
  // 1
  Future getData(String url) async {
    // 2
    print('Calling url: $url');
    // 3
    final response = await get(Uri.parse(url));
    // 4
    if (response.statusCode == 200) {
      // 5
      return response.body;
    } else {
      // 6
      print(response.statusCode);
    }
  }
// TODO: Add getRecipes
// 1
  Future<dynamic> getRecipes(String query, int from, int to) async {
    // 2
    final recipeData = await getData(
        '$apiUrl?app_id=$apiId&app_key=$apiKey&q=$query&from=$from&to=$to');
    // 3
    return recipeData;
  }

}
