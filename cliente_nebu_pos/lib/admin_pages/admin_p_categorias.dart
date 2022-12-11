import 'package:cliente_nebu_pos/services/p_categorias_provider.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AdminPCategorias extends StatefulWidget {
  const AdminPCategorias({super.key});

  @override
  State<AdminPCategorias> createState() => _AdminPCategoriasState();
}

class _AdminPCategoriasState extends State<AdminPCategorias> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PCategoriasProvider().getAll(),
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
                  title: Text('Categoria: ${categoria['nombre']}'),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
