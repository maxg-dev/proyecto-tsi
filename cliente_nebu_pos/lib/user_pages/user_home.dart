import 'package:cliente_nebu_pos/user_pages/user_clientes.dart';
import 'package:cliente_nebu_pos/user_pages/user_ventas.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../services/auth_service.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  var _selectedIndex = 0;
  List<Widget> pages = [
    UserVentas(),
    UserClientes(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 150,
        title: Text('Usuario'),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(MdiIcons.seedOutline),
            Text('Nebu\'s pos', style: TextStyle(fontSize: 10)),
          ],
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                height: 10,
                value: 'logout',
                child: Text('Cerrar Sesión'),
              ),
            ],
            onSelected: (opcionSeleccionada) {
              if (opcionSeleccionada == 'logout') {
                AuthService().signOutGoogle();
              }
            },
          ),
        ],
      ),
      body: Row(
        children: [
          NavigationRail(
            elevation: 5,
            selectedIndex: _selectedIndex,
            onDestinationSelected: changeDestination,
            labelType: NavigationRailLabelType.all,
            destinations: [
              navDestination('Venta', Icon(MdiIcons.cashRegister),
                  Icon(MdiIcons.cashRegister)),
              navDestination('Nuevo cliente', Icon(MdiIcons.accountPlus),
                  Icon(MdiIcons.accountPlusOutline)),
            ],
          ),
          VerticalDivider(thickness: 1, width: 1),
          pages[_selectedIndex],
        ],
      ),
    );
  }

  NavigationRailDestination navDestination(
      String text, Icon icon, Icon outlinedIcon) {
    return NavigationRailDestination(
        icon: icon, selectedIcon: outlinedIcon, label: Text(text));
  }

  changeDestination(int index) {
    setState(() => _selectedIndex = index);
  }
}
