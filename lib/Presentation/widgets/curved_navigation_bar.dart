import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class CustomCurvedNavigationBar extends StatelessWidget {
  final Function(int) onItemSelected;
  final int selectedIndex;
  final Color buttonColor; // Color dinámico

  const CustomCurvedNavigationBar({
    super.key,
    required this.onItemSelected,
    required this.selectedIndex,
    required this.buttonColor, // Aceptamos un color dinámico
  });

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      color: const Color(0xFF1E1E1E),
      buttonBackgroundColor: buttonColor, // Usamos el color dinámico aquí
      height: 60,
      index: selectedIndex,
      items: const <Widget>[
        Icon(Icons.home, size: 30, color: Colors.white),
        Icon(Icons.favorite, size: 30, color: Colors.white),
        Icon(Icons.settings, size: 30, color: Colors.white),
        Icon(Icons.person, size: 30, color: Colors.white),
      ],
      onTap: (int index) {
        onItemSelected(index);
      },
    );
  }
}
