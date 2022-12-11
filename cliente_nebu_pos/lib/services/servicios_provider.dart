import 'dart:convert';

import 'package:http/http.dart' as http;

class ServiciosProvider {
  final apiURL = 'http://127.0.0.1:8000/api';
  Future<List<dynamic>> getAll() async {
    var respond = await http.get(Uri.parse(apiURL + '/servicios'));
    return respond.statusCode == 200 ? json.decode(respond.body) : [];
  }

  Future<Map<String, dynamic>> add(
      String nombre, int precio, String descripcion, int categoria_id) async {
    var respond = await http.post(Uri.parse(apiURL + '/servicios'),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'nombre': nombre,
          'precio': precio,
          'estado': 1,
          'descripcion': descripcion,
          'servicio_categoria_id': categoria_id
        }));

    return json.decode(respond.body);
  }

  Future<Map<String, dynamic>> update(int id, String nombre, int precio,
      String descripcion, int categoria_id) async {
    var respond = await http.put(
        Uri.parse(apiURL + '/servicios/' + id.toString()),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'nombre': nombre,
          'precio': precio,
          'estado': 1,
          'descripcion': descripcion,
          'servicio_categoria_id': categoria_id
        }));

    return json.decode(respond.body);
  }

  Future<Map<String, dynamic>> updateState(int id, String nombre, int precio,
      int estado, String descripcion, int categoria_id) async {
    var respond = await http.put(
        Uri.parse(apiURL + '/servicios/' + id.toString()),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'nombre': nombre,
          'precio': precio,
          'estado': estado,
          'descripcion': descripcion,
          'servicio_categoria_id': categoria_id
        }));

    return json.decode(respond.body);
  }

  Future<Map<String, dynamic>> get(int id) async {
    var respond =
        await http.get(Uri.parse(apiURL + '/servicios/' + id.toString()));
    return json.decode(respond.body);
  }

  Future<bool> delete(int id) async {
    var respond =
        await http.delete(Uri.parse(apiURL + '/servicios/' + id.toString()));
    return respond.statusCode == 200;
  }
}
