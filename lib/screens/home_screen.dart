import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: <Widget> [
            _RecipesCard(context),
          ]
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
      builder: (context) => Container(
        // Ajustar el tamaño del contenedor
        width: MediaQuery.of(context).size.width,
        height: 500,
        color: Colors.black,
        child: RecipeForm(),
      ),
    );
  }

  Widget _RecipesCard(BuildContext context) {
    return Padding(
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
                    'https://upload.wikimedia.org/wikipedia/commons/7/7e/Silpancho_cochalo.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 26),
              Column(
                // Ordenar de manera vertical
                mainAxisAlignment: MainAxisAlignment.center,
                // Alinear a la izquierda
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Silpancho Cochabanbino',
                    style: TextStyle(fontSize: 16, fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold),
                  ),
                  //Container(height: 2, width: 330, color: Colors.blue[200]),
                  SizedBox(height: 8),
                  Text(
                    'By Alison Menez',
                    style: TextStyle(fontSize: 13, fontFamily: 'Quicksand',
                        color: Colors.blue[200]),
                  ),
                ],
              ),
            ],
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
    return Padding(
      padding: EdgeInsets.all(8),
      child: Form(
        //key: _formKey,
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
              label: 'Name',
              type: TextInputType.text,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, required TextInputType type}) {
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
          borderSide: BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
      ),
    );
  }
}