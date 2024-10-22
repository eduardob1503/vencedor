// lib/screens/materias_screen.dart
import 'package:flutter/material.dart';
import 'tela_login.dart';

// lib/screens/materias_screen.dart
// lib/screens/materias_screen.dart

class MateriasScreen extends StatelessWidget {
  final List<String> materias = [
    'Matemática',
    'História',
    'Geografia',
    'Ciências',
    'Português',
    'Inglês',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent, // Cor azul na barra superior
        title: Text('Matérias'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: materias.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.grey[200], // Fundo do card
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(
                  materias[index],
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  // Função ao clicar em cada matéria
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
