import 'package:flutter/material.dart';

class RecipeDetail extends StatelessWidget {
  final String recipeName;
  final String recipeDescription;
  final String recipeImage;
  final String recipeAuthor;
  final String recipeTime;

  const RecipeDetail({
    super.key,
    required this.recipeName,
    required this.recipeDescription,
    required this.recipeImage,
    required this.recipeAuthor,
    required this.recipeTime,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipeName),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.network(recipeImage, fit: BoxFit.cover),
            const SizedBox(height: 10),
            Text(
              recipeName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Description: $recipeDescription',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Icon(Icons.person),
                    const SizedBox(width: 5),
                    Text(recipeAuthor),
                  ],
                ),
                const SizedBox(width: 20),
                Row(
                  children: <Widget>[
                    const Icon(Icons.access_time),
                    const SizedBox(width: 5),
                    Text(recipeTime),
                  ],
                ),
              ],
            ),
          ]
        ),
      ),
    );
  }
}