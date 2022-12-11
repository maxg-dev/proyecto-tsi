import 'dart:convert';

import 'package:http/http.dart' as http;

class ClientesProvider {
  final apiURL = 'http://127.0.0.1:8000/api';
  Future<List<dynamic>> getAll() async {
    var respond = await http.get(Uri.parse(apiURL + '/clientes'));
    return respond.statusCode == 200 ? json.decode(respond.body) : [];
  }

  Future<Map<String, dynamic>> get(int id) async {
    var respond =
        await http.get(Uri.parse(apiURL + '/clientes/' + id.toString()));
    return json.decode(respond.body);
  }

  Future<Map<String, dynamic>> add(
      String rut,
      String nombre,
      String fecha_nacimiento,
      String direccion,
      String telefono,
      String correo) async {
    var respond = await http.post(Uri.parse(apiURL + '/clientes'),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'rut': rut,
          'nombre': nombre,
          'fecha_nacimiento': fecha_nacimiento,
          'direccion': direccion,
          'telefono': telefono,
          'estado': 1,
          'correo': correo
        }));

    return json.decode(respond.body);
  }

  Future<Map<String, dynamic>> update(
      int id,
      String rut,
      String nombre,
      String fecha_nacimiento,
      String direccion,
      String telefono,
      int estado,
      String correo) async {
    var respond = await http.put(
        Uri.parse(apiURL + '/clientes/' + id.toString()),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'rut': rut,
          'nombre': nombre,
          'fecha_nacimiento': fecha_nacimiento,
          'direccion': direccion,
          'telefono': telefono,
          'estado': estado,
          'correo': correo
        }));

    return json.decode(respond.body);
  }

  Future<bool> delete(int id) async {
    var respond =
        await http.delete(Uri.parse(apiURL + '/clientes/' + id.toString()));
    return respond.statusCode == 200;
  }
}
