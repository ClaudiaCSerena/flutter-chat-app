import 'dart:io';

class Environment {

  static String apiUrl = Platform.isAndroid //servicio rest
      ? 'http://10.0.2.2:3000/api'
      : 'http://localhost:3000/api';
    
  static String socketUrl = Platform.isAndroid //es el servidor de socket
      ? 'http://10.0.2.2:3000'
      : 'http://localhost:3000';
}
