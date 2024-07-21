import 'package:flutter/material.dart';

//Widget para la parte inferior
class Labels extends StatelessWidget {
  const Labels({super.key, required this.ruta, required this.titulo, required this.subtitulo});

  final String ruta;
  final String titulo;
  final String subtitulo;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            titulo,
            style: const TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w300),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            child: Text(
              subtitulo,
              style: TextStyle(
                  color: Colors.blue.shade600,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () => Navigator.pushReplacementNamed(context, ruta),
          )
        ],
      ),
    );
  }
}
