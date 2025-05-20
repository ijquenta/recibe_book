import 'package:flutter/material.dart';
import 'package:recipe_book/providers/recipes_provider.dart';
import 'package:recipe_book/screens/favorites_screen.dart';
import 'package:recipe_book/screens/home_screen.dart';
import 'package:recipe_book/screens/search_screen.dart';
import 'package:recipe_book/screens/settings_screen.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book/theme_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => RecipesProvider()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Bolivian Recipe Book',
              theme: ThemeData(primarySwatch: Colors.blue),
              darkTheme: ThemeData.dark(),
              themeMode: themeProvider.themeMode,
              home: const RecipeBook(),
            ),
          );
        },
      ),
    );
  }
}

class RecipeBook extends StatelessWidget {
  const RecipeBook({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            'Bolivian Recipe Book 🇧🇴',
            style: TextStyle(color: Colors.white),
          ),
          // TabBar en la parte superior
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'Home'),
              Tab(icon: Icon(Icons.favorite), text: 'Favorites'),
              Tab(icon: Icon(Icons.search), text: 'Search'),
              Tab(icon: Icon(Icons.settings), text: 'Settings'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HomeScreen(),
            FavoritesScreen(),
            SearchScreen(),
            SettingScreen(),
          ],
        ),
      ),
    );
  }
}
