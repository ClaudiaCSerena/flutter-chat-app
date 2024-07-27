import 'package:chat/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {

  RefreshController _refreshController = RefreshController(initialRefresh: false); //del pull to refresh

  final usuarios = [
    Usuario(online: true, email: 'test1@test.com', nombre: 'María', uid: '1'),
    Usuario(online: false, email: 'test2@test.com', nombre: 'Melissa', uid: '2'),
    Usuario(online: true, email: 'test3@test.com', nombre: 'Fernando', uid: '3'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi nombre', style: TextStyle(color: Colors.black54),),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: () {},
          ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            //child: Icon(Icons.check_circle, color: Colors.blue.shade400,),
            child: const Icon(Icons.offline_bolt, color: Colors.red,) ,
          )
        ],

      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue.shade400,),
          waterDropColor: Colors.blue.shade400,
        ),
        child: _listViewUsuarios()
        ),
    );
  }

  //Método con mi lista de usuarios
  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => _usuarioListTile(usuarios[index]), 
      separatorBuilder: (context, index) => const Divider(), 
      itemCount: usuarios.length,
      );
  }

  //Método con el ListTile
  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
        title: Text(usuario.nombre),
        subtitle: Text(usuario.email),
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Text(usuario.nombre.substring(0,2)),
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: usuario.online? Colors.green.shade300 : Colors.red,
            borderRadius: BorderRadius.circular(100)
          ),
        ),
      );
  }

  //Método para cargar usuarios. Trae la información de un end point (no lo tenemos aún)
  _cargarUsuarios() async {
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

}