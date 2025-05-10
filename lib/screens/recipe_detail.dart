import 'dart:ui'; // Import for ImageFilter

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
      extendBodyBehindAppBar: true, // Extend the body behind the app bar
      appBar: AppBar(
        title: Text(recipeName),
        backgroundColor: Colors.transparent, // Make app bar transparent
        elevation: 0, // Remove app bar shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // Change icon color for visibility
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack( // Use a Stack to layer widgets
        fit: StackFit.expand, // Make the stack fill the screen
        children: <Widget>[
          // Background Image
          Image.network(
            recipeImage,
            fit: BoxFit.cover,
          ),
          // Blur Effect
          BackdropFilter( // Apply a filter to the background
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Adjust sigmaX and sigmaY for desired blur
            child: Container(
              color: Colors.black.withOpacity(0.5), // Add a semi-transparent overlay
            ),
          ),
          // Content (Centered Image and Details)
          Center( // Wrap the SingleChildScrollView with Center for vertical centering
            child: SingleChildScrollView( // Make the content scrollable
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Center the column content vertically
                children: <Widget>[
                  SizedBox(height: kToolbarHeight + MediaQuery.of(context).padding.top), // Add space for the app bar
                  // Centered Image
                  Center( // This Center is still needed to center the image horizontally within the column
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0), // Optional: Add rounded corners
                      child: Image.network(
                        recipeImage,
                        width: 300, // Adjust size as needed
                        height: 300, // Adjust size as needed
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Details Container (with a background for readability)
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8), // Semi-transparent white background
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          recipeName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black, // Ensure text is visible on the background
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '$recipeDescription',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87, // Ensure text is visible
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                const Icon(Icons.person, color: Colors.black87),
                                const SizedBox(width: 5),
                                Text(
                                  recipeAuthor,
                                  style: const TextStyle(color: Colors.black87),
                                ),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Row(
                              children: <Widget>[
                                const Icon(Icons.access_time, color: Colors.black87),
                                const SizedBox(width: 5),
                                Text(
                                  recipeTime,
                                  style: const TextStyle(color: Colors.black87),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}