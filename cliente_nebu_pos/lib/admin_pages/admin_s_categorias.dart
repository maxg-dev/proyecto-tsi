import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../services/s_categorias_provider.dart';

class AdminSCategorias extends StatefulWidget {
  const AdminSCategorias({super.key});

  @override
  State<AdminSCategorias> createState() => _AdminSCategoriasState();
}

class _AdminSCategoriasState extends State<AdminSCategorias> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SCategoriasProvider().getAll(),
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
                var categoria = snapshot.data[index];
                return ListTile(
                  leading: Icon(MdiIcons.cookie),
                  title: Text('Producto: ${categoria['nombre']}'),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
