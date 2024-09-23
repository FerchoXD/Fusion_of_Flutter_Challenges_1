import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:skeletons/skeletons.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HttpPage extends StatefulWidget {
  const HttpPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HttpPageState createState() => _HttpPageState();
}

class _HttpPageState extends State<HttpPage> {
  final dio = Dio();
  List<dynamic> characters = [];

  @override
  void initState() {
    super.initState();
    fetchCharacters();
  }

  Future<void> fetchCharacters() async {
    try {
      final response = await dio.get('https://rickandmortyapi.com/api/character');

      if (response.statusCode == 200) {
        final data = response.data;
        setState(() {
          characters = data['results'];
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personajes de Rick & Morty'),
      ),
      body: characters.isEmpty
          ? skeletonCharacterListView() // Muestra skeleton cuando no hay datos
          : ListView.builder(
              itemCount: characters.length,
              itemBuilder: (context, index) {
                final character = characters[index];
                return ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: character['image'], // URL de la imagen del personaje
                    placeholder: (context, url) => const SkeletonAvatar(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                  title: Text(character['name']),
                  subtitle: Text(character['species']),
                );
              },
            ),
    );
  }

  Widget skeletonCharacterListView() {
    return ListView.builder(
      itemCount: 8, // Cantidad de skeletons que se van a mostrar
      itemBuilder: (context, index) {
        return const SkeletonItem(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              children: [
                // Skeleton para la imagen del personaje
                SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                    shape: BoxShape.rectangle,
                    width: 50,
                    height: 50,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                SizedBox(width: 16),
                // Skeleton para el texto (nombre y especie)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 16,
                          width: 150,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      SizedBox(height: 8),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 14,
                          width: 100,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
