import 'dart:convert';

import 'package:http/http.dart' as http;

class AjustesProvider {
  final apiURL = 'http://127.0.0.1:8000/api';
  //
  Future<List<dynamic>> getAll() async {
    var respond = await http.get(Uri.parse(apiURL + '/ajustes'));
    return respond.statusCode == 200 ? json.decode(respond.body) : [];
  }

  Future<Map<String, dynamic>> get(int id) async {
    var respond =
        await http.get(Uri.parse(apiURL + '/ajustes/' + id.toString()));
    return json.decode(respond.body);
  }

  Future<Map<String, dynamic>> add(
      int tipo, int cantidad, String descripcion, int producto_id) async {
    var respond = await http.post(Uri.parse(apiURL + '/ajustes'),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'tipo': tipo,
          'cantidad': cantidad,
          'descripcion': descripcion,
          'producto_id': producto_id
        }));

    return json.decode(respond.body);
  }

  Future<Map<String, dynamic>> update(int id, int tipo, int cantidad,
      String descripcion, int producto_id) async {
    var respond = await http.put(
        Uri.parse(apiURL + '/ajustes/' + id.toString()),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'tipo': tipo,
          'cantidad': cantidad,
          'descripcion': descripcion,
          'producto_id': producto_id
        }));

    return json.decode(respond.body);
  }

  Future<bool> delete(int id) async {
    var respond =
        await http.delete(Uri.parse(apiURL + '/ajustes/' + id.toString()));
    return respond.statusCode == 200;
  }
}
