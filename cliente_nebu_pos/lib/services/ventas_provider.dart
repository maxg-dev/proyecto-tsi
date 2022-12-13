import 'dart:convert';

import 'package:http/http.dart' as http;

class VentasProvider {
  final apiURL = 'http://127.0.0.1:8000/api';

  Future<List<dynamic>> getAll() async {
    var respond = await http.get(Uri.parse(apiURL + '/ventas'));
    return respond.statusCode == 200 ? json.decode(respond.body) : [];
  }

  Future<Map<String, dynamic>> get(int id) async {
    var respond =
        await http.get(Uri.parse(apiURL + '/ventas/' + id.toString()));
    return json.decode(respond.body);
  }

  Future<Map<String, dynamic>> add(String nombre, int cliente_id) async {
    var respond = await http.post(Uri.parse(apiURL + '/ventas'),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'nombre': nombre,
          'cliente_id': cliente_id,
        }));

    return json.decode(respond.body);
  }

  Future<bool> delete(int id) async {
    var respond =
        await http.delete(Uri.parse(apiURL + '/ventas/' + id.toString()));
    return respond.statusCode == 200;
  }
}
