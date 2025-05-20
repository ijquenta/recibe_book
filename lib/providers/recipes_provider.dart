import 'package:flutter/material.dart';
import 'package:recipe_book/models/recipe_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipesProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Recipe> recipes = [];
  String url = 'http://0.0.0.0:5001/recipes';
  String urlEmulator = 'http://10.0.2.2:5001/recipes';

  Future<void> fetchRecipes() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse(this.url);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // El backend devuelve 'url', pero el modelo espera 'image'.
        // Convertimos cada receta para que tenga la clave 'image'.
        final List recetasConvertidas =
            (data['recipes'] as List).map((receta) {
              final recetaMap = Map<String, dynamic>.from(receta);
              recetaMap['image'] = recetaMap['url'];
              return recetaMap;
            }).toList();
        recipes = List<Recipe>.from(
          recetasConvertidas.map((recipe) => Recipe.fromJson(recipe)),
        );
      } else {
        recipes = [];
      }
    } catch (e) {
      recipes = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
