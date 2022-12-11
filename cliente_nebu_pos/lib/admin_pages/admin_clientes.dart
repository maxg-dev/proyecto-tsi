import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../services/clientes_provider.dart';

class AdminClientes extends StatefulWidget {
  const AdminClientes({super.key});

  @override
  State<AdminClientes> createState() => _AdminClientesState();
}

class _AdminClientesState extends State<AdminClientes> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ClientesProvider().getAll(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                var cliente = snapshot.data[index];
                return ListTile(
                  leading: Icon(MdiIcons.cookie),
                  title: Text('Cliente: ${cliente['nombre']}'),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
