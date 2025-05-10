import 'package:flutter/material.dart';

class Recipe {
  String name;
  String description;
  String image;
  String author;
  String time;
  List<String> recipeSteps;
  List<String> ingredients;

  Recipe({
    required this.name,
    required this.description,
    required this.image,
    required this.author,
    required this.time,
    required this.recipeSteps,
    required this.ingredients,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'],
      description: json['description'],
      image: json['image'],
      author: json['author'],
      time: json['time'],
      recipeSteps: List<String>.from(json['recipeSteps']),
      ingredients: List<String>.from(json['ingredients']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'image': image,
      'author': author,
      'time': time,
      'recipeSteps': recipeSteps,
      'ingredients': ingredients,
    };
  }

  @override
  String toString() {
    return 'Recipe(name: $name, description: $description, image: $image, author: $author, time: $time, recipeSteps: $recipeSteps, ingredients: $ingredients)';
  }
}