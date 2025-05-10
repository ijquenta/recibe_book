import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
          const Text('Search Section', style: TextStyle(fontSize: 24))
        ])
    );
  }
}