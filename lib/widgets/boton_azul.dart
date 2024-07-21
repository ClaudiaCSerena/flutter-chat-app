import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  const BotonAzul({super.key, required this.text, required this.onPressed});

  final String text;
  final Function()? onPressed; //si no pongo los paréntesis no funciona. Tengo que ponerle ? para que pueda ser null

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: TextButton.styleFrom(
          elevation: 2,
          backgroundColor: Colors.blue,
          shape: const StadiumBorder(),
        ),
        onPressed: onPressed,
        child: Container(
            width: double.infinity, //que tome todo el ancho que pueda
            height: 55,
            child: Center(
                child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 17),
            ))));
  }
}
