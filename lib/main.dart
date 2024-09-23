import 'package:flutter/material.dart';
import 'package:merging_of_applications/Presentation/pages/note_app.dart';
import 'package:merging_of_applications/Presentation/pages/http_page.dart';
import 'package:merging_of_applications/Presentation/pages/password_validator.dart';
import 'package:merging_of_applications/Presentation/pages/contact_list_screen.dart';
import 'package:merging_of_applications/Presentation/widgets/curved_navigation_bar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mega App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212), // Este es el color de fondo de la pantalla
        primaryColor: Colors.blueGrey[900],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black, // Fondo del BottomNavigationBar
          selectedItemColor: Colors.tealAccent,
          unselectedItemColor: Colors.grey,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/http': (context) => const HttpPage(),
        'noteapp': (context) => NoteScreen(),
        '/contact': (context) =>  ContactListScreen(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Colores para cada página
  final List<Color> _buttonColors = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.blue,
  ];

  final List<Widget> _pages = [
    const PasswordValidatorPage(),
    const HttpPage(),
    NoteScreen(),
    ContactListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomCurvedNavigationBar(
        selectedIndex: _selectedIndex,
        buttonColor: _buttonColors[_selectedIndex],
        onItemSelected: (int index) {
          if (index >= 0 && index < _pages.length) {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
      ),
    );
  }
}
