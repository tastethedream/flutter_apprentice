import 'package:equatable/equatable.dart';
import 'ingredient.dart';

class Recipe extends Equatable {
  // 1
  int? id;
  final String? label;
  final String? image;
  final String? url;
  // 2
  List<Ingredient>? ingredients;
  final double? calories;
  final double? totalWeight;
  final double? totalTime;

  // 3
  Recipe(
      {this.id,
        this.label,
        this.image,
        this.url,
        this.calories,
        this.totalWeight,
        this.totalTime});

  // 4
  @override
  List<Object?> get props =>
      [label, image, url, calories, totalWeight, totalTime];
}
