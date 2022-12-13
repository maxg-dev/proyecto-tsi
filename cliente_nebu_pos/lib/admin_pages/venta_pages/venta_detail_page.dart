import 'package:cliente_nebu_pos/services/p_categorias_provider.dart';
import 'package:cliente_nebu_pos/services/ventas_provider.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../services/s_categorias_provider.dart';

class VentaDetailPage extends StatefulWidget {
  final int id;
  const VentaDetailPage(this.id, {super.key});

  @override
  State<VentaDetailPage> createState() => _VentaDetailPageState();
}

class _VentaDetailPageState extends State<VentaDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajuste de inventario'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: FutureBuilder(
          future: VentasProvider().get(widget.id),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            var venta = snapshot.data;
            var productoIndex = venta['productos'].length;
            List<dynamic> detalle_venta_list =
                List<dynamic>.empty(growable: true);
            for (var producto in venta['productos']) {
              detalle_venta_list.add(producto);
            }
            for (var servicio in venta['servicios']) {
              detalle_venta_list.add(servicio);
            }

            return ListView.separated(
              itemCount: detalle_venta_list.length,
              separatorBuilder: (context, index) => Divider(height: 0),
              itemBuilder: (context, index) {
                var detalle_venta = detalle_venta_list[index];
                return index < productoIndex
                    ? listTileProducto(detalle_venta)
                    : listTileServicio(detalle_venta);
              },
            );
          },
        ),
      ),
    );
  }

  FutureBuilder listTileProducto(producto) {
    return FutureBuilder(
      future: PCategoriasProvider().get(producto['producto_categoria_id']),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return ListTile(
            title: CircularProgressIndicator(),
          );
        }

        var categoria = snapshot.data['nombre'];
        var cantidad = producto['pivot']['cantidad'];
        var precio = producto['pivot']['precio_venta'];
        var descuento = producto['pivot']['descuento'];
        var total = (cantidad * precio) + descuento;

        return ListTile(
          leading: Icon(MdiIcons.lipstick),
          title: Text('${categoria} - ${producto['nombre']}'),
          subtitle: Text(
              'Cantidad: ${cantidad.toString()} Precio unidad: ${precio.toString()} Descuento unidad: ${descuento.toString()}    Total: ${total.toString()}'),
        );
      },
    );
  }

  FutureBuilder listTileServicio(servicio) {
    return FutureBuilder(
      future: SCategoriasProvider().get(servicio['servicio_categoria_id']),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return ListTile(
            title: CircularProgressIndicator(),
          );
        }

        var categoria = snapshot.data['nombre'];
        var cantidad = servicio['pivot']['cantidad'];
        var precio = servicio['pivot']['precio_venta'];
        var descuento = servicio['pivot']['descuento'];
        var total = (cantidad * precio) + descuento;

        return ListTile(
          leading: Icon(MdiIcons.hairDryer),
          title: Text('${categoria} - ${servicio['nombre']}'),
          subtitle: Text(
              'Cantidad: ${cantidad.toString()} Precio unidad: ${precio.toString()} Descuento unidad: ${descuento.toString()}    Total: ${total.toString()}'),
        );
      },
    );
  }
}
