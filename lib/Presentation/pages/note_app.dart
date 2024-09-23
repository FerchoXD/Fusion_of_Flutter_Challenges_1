import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black87, // Fondo oscuro
        primaryColor: Colors.yellow, // Color principal amarillo
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
  backgroundColor: Colors.yellow, // Cambiado a amarillo
  foregroundColor: Colors.black, // Texto negro para contraste
  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.0),
  ),
  elevation: 5,
),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[800], // Campo de texto oscuro
          border: OutlineInputBorder(),
        ),
        cardColor: Colors.grey[900], // Color de las tarjetas de notas
      ),
      home: NoteScreen(),
    );
  }
}

class NoteScreen extends StatefulWidget {
  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final TextEditingController _noteController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Clave para el formulario
  List<String> _notes = [];
  String? _errorText;

  // Función para agregar nota
  void _addNote() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _notes.add(_noteController.text);
        _noteController.clear();
        _errorText = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc de Notas'),
        centerTitle: true,
        backgroundColor: Colors.black87, // Fondo oscuro para el AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _noteController,
                    maxLines: 5,
                    style: TextStyle(color: Colors.white), // Texto blanco
                    decoration: InputDecoration(
                      hintText: 'Escribe tu nota aquí...',
                      hintStyle: TextStyle(color: const Color.fromARGB(181, 252, 251, 251)), // Pista en gris claro
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: const Color.fromARGB(137, 53, 53, 53), // Fondo oscuro para el campo de texto
                      errorText: _errorText,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'No puedes agregar una nota vacía';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _addNote,
                    child: Text('Agregar Nota'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _notes.isEmpty
                  ? Center(
                      child: Text(
                        'No hay notas guardadas',
                        style: TextStyle(fontSize: 18, color: Colors.white70),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _notes.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          margin: EdgeInsets.symmetric(vertical: 5),
                          color: Theme.of(context).cardColor, // Tarjetas oscuras
                          child: ListTile(
                            leading: Icon(Icons.note, color: Colors.yellow), // Ícono amarillo
                            title: Text(
                              _notes[index],
                              style: TextStyle(fontSize: 16, color: Colors.white), // Texto blanco
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: const Color.fromARGB(255, 255, 17, 0)),
                              onPressed: () {
                                setState(() {
                                  _notes.removeAt(index);
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}