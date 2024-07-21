import 'package:chat/widgets/boton_azul.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView( //para que pueda hacer scroll y no me reclame que no hay espacio
        physics: const BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height*0.9, //Para que sea del alto del 90% del total de la pantalla, y no me lo achique
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, //Para que mis objetos de la columna se distribuyan de acuerdo al espacio vertical
              children: [
                Logo(titulo: 'Messenger',),
                _Form(),
                Labels(ruta: 'register', subtitulo: 'Crea una ahora!', titulo: '¿No tienes cuenta?', ),
                Text('Términos y condiciones de uso', style: TextStyle(fontWeight: FontWeight.w200),),
              ],
            ),
          ),
        ),
      )
    );
  }
}



//Widget para el formulario de datos
class _Form extends StatefulWidget {
  const _Form();

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),

      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline, 
            placeholder: 'Correo', 
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
            ),  

          CustomInput(
            icon: Icons.lock_outline, 
            placeholder: 'Contraseña', 
            textController: passCtrl,
            isPassword: true,
            ), 
          const BotonAzul(text: 'Ingrese', onPressed: null,),       //CustomInput(),   
        ],
      ),
    );
  }
}

