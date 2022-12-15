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

  Future<Map<String, dynamic>> addDetalleProducto(int producto_id, int venta_id,
      int cantidad, int precio_venta, int descuento) async {
    var respond = await http.post(
      Uri.parse(apiURL + '/productoVentas'),
      headers: <String, String>{
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode(
        <String, dynamic>{
          'producto_id': producto_id,
          'venta_id': venta_id,
          'cantidad': cantidad,
          'precio_venta': precio_venta,
          'descuento': descuento,
        },
      ),
    );

    return json.decode(respond.body);
  }

  Future<Map<String, dynamic>> addDetalleServicio(int servicio_id, int venta_id,
      int cantidad, int precio_venta, int descuento) async {
    var respond = await http.post(
      Uri.parse(apiURL + '/servicioVentas'),
      headers: <String, String>{
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode(
        <String, dynamic>{
          'servicio_id': servicio_id,
          'venta_id': venta_id,
          'cantidad': cantidad,
          'precio_venta': precio_venta,
          'descuento': descuento,
        },
      ),
    );

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
