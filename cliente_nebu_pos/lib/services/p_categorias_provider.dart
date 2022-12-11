import 'dart:convert';

import 'package:http/http.dart' as http;

class PCategoriasProvider {
  final apiURL = 'http://127.0.0.1:8000/api';
  //
  Future<List<dynamic>> getAll() async {
    var respond = await http.get(Uri.parse(apiURL + '/productoCategorias'));
    return respond.statusCode == 200 ? json.decode(respond.body) : [];
  }

  Future<Map<String, dynamic>> get(int id) async {
    var respond = await http
        .get(Uri.parse(apiURL + '/productoCategorias/' + id.toString()));
    return json.decode(respond.body);
  }

  Future<Map<String, dynamic>> add(String nombre) async {
    var respond = await http.post(Uri.parse(apiURL + '/productoCategorias'),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'nombre': nombre,
        }));

    return json.decode(respond.body);
  }

  Future<Map<String, dynamic>> update(int id, String nombre) async {
    var respond = await http.put(
        Uri.parse(apiURL + '/productoCategorias/' + id.toString()),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'nombre': nombre,
        }));

    return json.decode(respond.body);
  }

  Future<bool> delete(int id) async {
    var respond = await http
        .delete(Uri.parse(apiURL + '/productoCategorias/' + id.toString()));
    return respond.statusCode == 200;
  }
}
