import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../services/servicios_provider.dart';

class AdminServicios extends StatefulWidget {
  const AdminServicios({super.key});

  @override
  State<AdminServicios> createState() => _AdminServiciosState();
}

class _AdminServiciosState extends State<AdminServicios> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ServiciosProvider().getAll(),
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
                var servicio = snapshot.data[index];
                return ListTile(
                  leading: Icon(MdiIcons.cookie),
                  title: Text('Servicio: ${servicio['nombre']}'),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
