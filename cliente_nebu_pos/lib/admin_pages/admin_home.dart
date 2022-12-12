import 'package:cliente_nebu_pos/admin_pages/admin_ajustes.dart';
import 'package:cliente_nebu_pos/admin_pages/admin_p_categorias.dart';
import 'package:cliente_nebu_pos/admin_pages/admin_productos.dart';
import 'package:cliente_nebu_pos/admin_pages/admin_s_categorias.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'admin_clientes.dart';
import 'admin_servicios.dart';
import 'admin_ventas.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  var _selectedIndex = 0;
  List<Widget> pages = [
    AdminProductos(),
    AdminServicios(),
    AdminClientes(),
    AdminAjustes(),
    AdminPCategorias(),
    AdminSCategorias(),
    AdminVentas(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Administrador'),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(MdiIcons.seedOutline),
            Text('Nebu\'s pos', style: TextStyle(fontSize: 10)),
          ],
        ),
      ),
      body: Row(
        children: [
          NavigationRail(
            elevation: 2,
            leading: Text('Mantenedores'),
            selectedIndex: _selectedIndex,
            onDestinationSelected: changeDestination,
            labelType: NavigationRailLabelType.all,
            destinations: [
              navDestination('Productos'),
              navDestination('Servicios'),
              navDestination('Clientes'),
              navDestination('Ajuste Inventario'),
              navDestination('Categoria Productos'),
              navDestination('Categoria Servicios'),
              navDestination('Ventas')
            ],
          ),
          VerticalDivider(thickness: 1, width: 1),
          pages[_selectedIndex],
        ],
      ),
    );
  }

  NavigationRailDestination navDestination(String text) {
    return NavigationRailDestination(
        icon: Icon(MdiIcons.file),
        selectedIcon: Icon(MdiIcons.fileOutline),
        label: Text(text));
  }

  changeDestination(int index) {
    setState(() => _selectedIndex = index);
  }
}
