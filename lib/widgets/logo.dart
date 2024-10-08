import 'package:flutter/material.dart';

//Widget para el logo
class Logo extends StatelessWidget {
  const Logo({super.key, required this.titulo});

  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: 170,
      margin: const EdgeInsets.only(top: 50),
      child: Column(
        children: [
          //Image(image: AssetImage('assets/tag-logo.png'))
          Image.asset('assets/tag-logo.png'),
          const SizedBox(height: 20),
          Text(titulo, style: TextStyle(fontSize: 30))
        ],
      ),
    ));
  }
}
