import 'dart:convert';

import 'package:http/http.dart' as http;

class ServiciosProvider {
  final apiURL = 'http://127.0.0.1:8000/api';
  Future<List<dynamic>> getAll() async {
    var respond = await http.get(Uri.parse(apiURL + '/servicios'));
    return respond.statusCode == 200 ? json.decode(respond.body) : [];
  }
}
