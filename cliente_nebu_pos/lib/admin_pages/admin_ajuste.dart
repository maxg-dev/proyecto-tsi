import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../services/productos_provider.dart';

class AdminAjuste extends StatefulWidget {
  const AdminAjuste({super.key});

  @override
  State<AdminAjuste> createState() => _AdminAjusteState();
}

class _AdminAjusteState extends State<AdminAjuste> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ProductosProvider().getAll(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                var producto = snapshot.data[index];
                return ListTile(
                  leading: Icon(MdiIcons.cookie),
                  title: Text('Producto: ${producto['nombre']}'),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
