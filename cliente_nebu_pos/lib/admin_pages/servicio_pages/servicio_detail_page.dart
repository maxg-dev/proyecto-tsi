import 'package:cliente_nebu_pos/services/servicios_provider.dart';
import 'package:flutter/material.dart';

class ServicioDetailPage extends StatelessWidget {
  final int id;
  const ServicioDetailPage(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle servicio'),
      ),
      body: FutureBuilder(
        future: ServiciosProvider().get(this.id),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          var servicio = snapshot.data;
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Id: #${servicio['id'].toString().padLeft(3, '0')}'),
                Text('Nombre: ${servicio['nombre']}'),
                Text('Precio: ${servicio['precio'].toString()}'),
                Text(
                    'Estado: ${servicio['estado'] == 0 ? 'Descontinuado' : 'Habilitado'}'),
                Text('Descripción: ${servicio['descripcion']}'),
                Text('Categoria: ${servicio['servicio_categoria']['nombre']}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
