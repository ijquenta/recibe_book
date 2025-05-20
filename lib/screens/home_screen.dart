import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book/models/recipe_model.dart';
import 'package:recipe_book/providers/recipes_provider.dart';
import 'package:recipe_book/screens/recipe_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final recipesProvider = Provider.of<RecipesProvider>(
        context,
        listen: false,
      );
      recipesProvider.fetchRecipes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RecipesProvider>(
        builder: (context, provider, child) {
          // Validación
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.recipes.isEmpty) {
            return const Center(child: Text('No recipes found'));
          } else {
            return ListView.builder(
              itemCount: provider.recipes.length,
              itemBuilder: (context, index) {
                final recipe = provider.recipes[index];
                return _RecipesCard(context, recipe);
              },
            );
          }
        },
      ),
      // Boton de agregar receta flotante
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          _showBottom(context);
        },
        child: Icon(Icons.add_circle, color: Colors.white),
      ),
    );
  }

  Future<void> _showBottom(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder:
          (context) => Container(
            // Ajustar el tamaño del contenedor
            width: MediaQuery.of(context).size.width,
            height: 500,
            color: Colors.black,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: RecipeForm(),
              ),
            ),
          ),
    );
  }

  Widget _RecipesCard(BuildContext context, Recipe recipe) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => RecipeDetail(
                  recipeName: recipe.name,
                  recipeDescription: recipe.description,
                  recipeImage: recipe.image, // Usar siempre image
                  recipeAuthor: recipe.author,
                  recipeTime: recipe.time,
                ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: Card(
            child: Row(
              children: <Widget>[
                Container(
                  height: 125,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      recipe.image,
                      fit: BoxFit.cover,
                    ), // Usar siempre image
                  ),
                ),
                SizedBox(width: 26),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      recipe.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: <Widget>[
                        Icon(Icons.person, size: 16, color: Colors.blue[200]),
                        SizedBox(width: 4),
                        Text(
                          recipe.author,
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Quicksand',
                            color: Colors.blue[200],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: Colors.blue[200],
                        ),
                        SizedBox(width: 4),
                        Text(
                          recipe.time,
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Quicksand',
                            color: Colors.blue[200],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RecipeForm extends StatelessWidget {
  const RecipeForm({super.key});

  @override
  Widget build(BuildContext context) {
    // GlobalKey para el formulario
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _descriptionController =
        TextEditingController();
    final TextEditingController _authorController = TextEditingController();
    final TextEditingController _timeController = TextEditingController();
    final TextEditingController _imageUrlController = TextEditingController();

    return Padding(
      padding: EdgeInsets.all(8),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 5),
            Text(
              'Add new recipe',
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            _buildTextField(
              controller: _nameController,
              label: 'Name',
              type: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            _buildTextField(
              maxLines: 2,
              controller: _descriptionController,
              label: 'Description',
              type: TextInputType.multiline,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            _buildTextField(
              controller: _authorController,
              label: 'Author',
              type: TextInputType.multiline,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an author';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            _buildTextField(
              controller: _timeController,
              label: 'Time',
              type: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a time';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            _buildTextField(
              controller: _imageUrlController,
              label: 'Image URL',
              type: TextInputType.url,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an image URL';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Cerrar el modal
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Quicksand',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextInputType type,
    required TextEditingController controller,
    required String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 16,
          fontFamily: 'Quicksand',
          color: Colors.blue,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
      ),
      validator: validator,
      maxLines: maxLines,
    );
  }
}
