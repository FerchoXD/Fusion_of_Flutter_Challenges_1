import 'package:flutter/material.dart';
import '../../domain/models/contact.dart';

class ContactAvatar extends StatelessWidget {
  final Contact contact;
  final Color avatarColor;

  const ContactAvatar({super.key, required this.contact, required this.avatarColor});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: 'contact_${contact.name}_${contact.matricula}_${contact.email}',
          child: CircleAvatar(
            backgroundColor: avatarColor,
            radius: 70,
            child: contact.name == 'Alan Gomez'
                ? const CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('assets/images/pokemon.jpg'),
                  )
                : Text(contact.name[0], style: const TextStyle(fontSize: 24, color: Colors.white)),
          ),
        ),
        const SizedBox(height: 8),
        Text(contact.name, style: const TextStyle(fontSize: 16, color: Colors.white)),
      ],
    );
  }
}
