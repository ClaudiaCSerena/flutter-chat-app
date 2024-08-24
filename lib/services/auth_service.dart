import 'dart:convert';

import 'package:chat/global/environment.dart';
import 'package:chat/models/login_response.dart';
import 'package:chat/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

//Es un provider (ya que lo mezclo con el ChangeNotifier)
class AuthService with ChangeNotifier {
  var usuario = Usuario(nombre: '', email: '', online: false, uid: '');

  final _storage = const FlutterSecureStorage();

  //Getters del token de forma estática
  static Future getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  bool _autenticando = false; //creo una variable privada
  //Creo el getter y el setter
  bool get autenticando => _autenticando;
  set autenticando(bool valor) {
    _autenticando = valor;
    notifyListeners(); //La idea de haber hecho la variable privada es poder utilizar el getter y setter y poder notificar a todos cuando hay cambios
  }

  //Método para hacer el login
  Future<bool> login(String email, String password) async {
    autenticando = true;
    final data = {
      //información (payload) que enviaré al backend
      'email': email,
      'password': password
    };

    final resp = await http.post(
        Uri.parse('${Environment.apiUrl}/login'), //Respuesta = petición http
        body: jsonEncode(data),
        headers: {'Content-type': 'application/json'});
    print(resp.body);
    autenticando = false;

    if (resp.statusCode == 200) {
      //Significa que todo lo hizo bien
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;
      await _guardarToken(loginResponse.token);

      return true;
    } else {
      return false;
    }
  }

  //Método para hacer el registro
  Future register(String nombre, String email, String password) async {
    autenticando = true;
    final data = {
      //información (payload) que enviaré al backend
      'nombre': nombre,
      'email': email,
      'password': password
    };

    final resp = await http.post(
        Uri.parse(
            '${Environment.apiUrl}/login/new'), //Respuesta = petición http
        body: jsonEncode(data),
        headers: {'Content-type': 'application/json'});
    autenticando = false;

    if (resp.statusCode == 200) {
      //Significa que todo lo hizo bien
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;
      await _guardarToken(loginResponse.token);

      return true; //bool
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg']; //String
    }
  }

  //Método para verificar que el token que está almacenado en el storage sigue siendo válido con el backend
  Future isLoggedIn() async {
    final token = await _storage.read(key: 'token')??'';

    final resp = await http.get(
        Uri.parse(
            '${Environment.apiUrl}/login/renew'), //Respuesta = petición http
        headers: {'Content-type': 'application/json', 'x-token': token});

    if (resp.statusCode == 200) {
      //Significa que todo lo hizo bien
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;
      await _guardarToken(loginResponse.token);

      return true; //bool
    } else {
      logout();
      return false; //String
    }
  }

  //Método para guardar el token
  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  //Método para eliminar el token
  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
