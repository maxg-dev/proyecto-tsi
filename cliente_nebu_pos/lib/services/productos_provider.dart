import 'dart:convert';

import 'package:http/http.dart' as http;

class ProductosProvider {
  final apiURL = 'http://127.0.0.1:8000/api';
  Future<List<dynamic>> getAll() async {
    var respond = await http.get(Uri.parse(apiURL + '/productos'));
    return respond.statusCode == 200 ? json.decode(respond.body) : [];
  }

  Future<Map<String, dynamic>> get(int id) async {
    var respond =
        await http.get(Uri.parse(apiURL + '/productos/' + id.toString()));
    return json.decode(respond.body);
  }

  Future<Map<String, dynamic>> add(
      int tipo,
      String nombre,
      int precio,
      int costo,
      int stock,
      int stock_min,
      String descripcion,
      int producto_categoria_id) async {
    var respond = await http.post(Uri.parse(apiURL + '/productos'),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'tipo': tipo,
          'nombre': nombre,
          'precio': precio,
          'costo': costo,
          'stock': stock,
          'stock_min': stock_min,
          'estado': 1,
          'descripcion': descripcion,
          'producto_categoria_id': producto_categoria_id
        }));

    return json.decode(respond.body);
  }

  Future<Map<String, dynamic>> update(
      int id,
      int tipo,
      String nombre,
      int precio,
      int costo,
      int stock,
      int stock_min,
      int estado,
      String descripcion,
      int categoria_id) async {
    var respond = await http.put(
        Uri.parse(apiURL + '/productos/' + id.toString()),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'tipo': tipo,
          'nombre': nombre,
          'precio': precio,
          'costo': costo,
          'stock': stock,
          'stock_min': stock_min,
          'estado': estado,
          'descripcion': descripcion,
          'producto_categoria_id': categoria_id
        }));

    return json.decode(respond.body);
  }

  Future<Map<String, dynamic>> updateState(
      int id,
      int tipo,
      String nombre,
      int precio,
      int costo,
      int stock,
      int stock_min,
      int estado,
      String descripcion,
      int categoria_id) async {
    var respond = await http.put(
        Uri.parse(apiURL + '/productos/' + id.toString()),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'tipo': tipo,
          'nombre': nombre,
          'precio': precio,
          'costo': costo,
          'stock': stock,
          'stock_min': stock_min,
          'estado': estado,
          'descripcion': descripcion,
          'producto_categoria_id': categoria_id
        }));

    return json.decode(respond.body);
  }

  Future<bool> delete(int id) async {
    var respond =
        await http.delete(Uri.parse(apiURL + '/productos/' + id.toString()));
    return respond.statusCode == 200;
  }
}
