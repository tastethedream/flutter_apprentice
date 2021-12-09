import 'package:equatable/equatable.dart';
// 1
class Ingredient extends Equatable {
  // 2
  int? id;
  int? recipeId;
  final String? name;
  final double? weight;

  // 3
  Ingredient({this.id, this.recipeId, this.name, this.weight});

  // 4
  @override
  List<Object?> get props => [recipeId, name, weight];
}
