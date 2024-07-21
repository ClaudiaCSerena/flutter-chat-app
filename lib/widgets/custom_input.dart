import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key, 
    required this.icon, 
    required this.placeholder, 
    required this.textController, 
    this.keyboardType = TextInputType.text, 
    this.isPassword = false
    });

  final IconData icon; //ícono
  final String placeholder; //Texto que aparece como hintText
  final TextEditingController textController; //Controlador para saber lo que ingresa el usuario
  final TextInputType keyboardType; //Tipo de teclado que necesitamos
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 20),
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 5),
              blurRadius: 5,
            )
          ],
        ),
        child: TextField(
          controller: textController,
          autocorrect: false, //no quiero que se autocomplete
          keyboardType: keyboardType,
          obscureText: isPassword,
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            focusedBorder: InputBorder.none, //para eliminar la línea de abajo
            border: InputBorder.none, //para eliminar la línea de abajo
            hintText: placeholder,
          ),
        ));
  }
}
