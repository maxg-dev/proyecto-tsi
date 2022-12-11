import 'package:cliente_nebu_pos/services/clientes_provider.dart';
import 'package:flutter/material.dart';

class ClienteDetailPage extends StatelessWidget {
  final int id;
  const ClienteDetailPage(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle cliente'),
      ),
      body: FutureBuilder(
        future: ClientesProvider().get(this.id),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          var cliente = snapshot.data;
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Id: #${cliente['id'].toString().padLeft(3, '0')}'),
                Text('Rut: ${cliente['rut'].toString()}'),
                Text('Nombre: ${cliente['nombre']}'),
                Text('Fecha de nacimiento: ${cliente['fecha_nacimiento']}'),
                Text('Dirección: ${cliente['dirección']}'),
                Text('Teléfono: ${cliente['telefono']}'),
                Text('Correo: ${cliente['correo']}'),
                Text(
                    'Estado: ${cliente['estado'] == 1 ? 'Habilidato' : 'Suspendido'}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
