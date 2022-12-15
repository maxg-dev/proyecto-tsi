import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../services/productos_provider.dart';
import '../services/servicios_provider.dart';
import '../services/ventas_provider.dart';

class UserVentaAdd extends StatefulWidget {
  final int idCliente;
  final int idVenta;
  const UserVentaAdd(this.idCliente, this.idVenta, {super.key});
  @override
  State<UserVentaAdd> createState() => _UserVentaAddState();
}

class _UserVentaAddState extends State<UserVentaAdd> {
  var selectedProducto = 0;
  var selectedServicio = 0;
  final fFecha = DateFormat('dd-MM-yyyy');
  TextEditingController cantidadProducto = TextEditingController();
  TextEditingController cantidadServicio = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Venta #${widget.idVenta.toString().padLeft(4, '0')}'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: FutureBuilder(
          future: VentasProvider().get(widget.idVenta),
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

            return SizedBox(
              width: 600,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListTile(
                    leading: Icon(MdiIcons.currencyUsd),
                    title: Text(
                        'Caja: Cliente: Fecha: ${fFecha.format(DateTime.parse(venta['created_at']))}'),
                    subtitle: Text(
                        'Subtotal: Descuento:  Total: ${venta['total_venta']}'),
                  ),
                  Container(
                    height: 60,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          campoProducto(),
                          campoCantidadProducto(),
                          IconButton(
                              onPressed: () async {
                                var detalleProducto = await ProductosProvider()
                                    .get(selectedProducto);
                                await VentasProvider().addDetalleProducto(
                                    selectedProducto,
                                    widget.idVenta,
                                    int.parse(cantidadProducto.text.trim()),
                                    detalleProducto['precio'],
                                    0);

                                cantidadProducto.text = '1';
                                setState(() {});
                              },
                              icon: Icon(MdiIcons.lotionPlus),
                              color: Colors.green,
                              iconSize: 30),
                        ]),
                  ),
                  Container(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        campoServicio(),
                        campoCantidadServicio(),
                        IconButton(
                            onPressed: () async {
                              var detalleServicio = await ServiciosProvider()
                                  .get(selectedServicio);
                              await VentasProvider().addDetalleServicio(
                                  selectedServicio,
                                  widget.idVenta,
                                  int.parse(cantidadServicio.text.trim()),
                                  detalleServicio['precio'],
                                  0);

                              cantidadServicio.text = '1';
                              setState(() {});
                            },
                            icon: Icon(MdiIcons.hairDryer),
                            color: Colors.green,
                            iconSize: 30),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 600,
                      child: ListView.separated(
                        itemCount: detalle_venta_list.length,
                        separatorBuilder: (context, index) =>
                            Divider(height: 0),
                        itemBuilder: (context, index) {
                          var detalle_venta = detalle_venta_list[index];
                          if (index < productoIndex) {
                            return listTileProducto(detalle_venta);
                          } else {
                            return listTileServicio(detalle_venta);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  campoCantidadProducto() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SizedBox(
          width: 50,
          child: TextFormField(
            controller: cantidadProducto,
            maxLength: 3,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              labelText: '+/-',
            ),
          )),
    );
  }

  campoCantidadServicio() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SizedBox(
          width: 50,
          child: TextFormField(
            controller: cantidadServicio,
            maxLength: 3,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              labelText: '+/-',
            ),
          )),
    );
  }

  ListTile listTileProducto(producto) {
    var cantidad = producto['pivot']['cantidad'];
    var precio = producto['pivot']['precio_venta'];
    var descuento = producto['pivot']['descuento'];
    var total = cantidad * (precio - descuento);

    return ListTile(
      leading: Icon(MdiIcons.lipstick),
      title: Text('${producto['nombre']}'),
      subtitle: Text(
          'Cantidad: ${cantidad.toString()} Precio unidad: ${precio.toString()} Descuento unidad: ${descuento.toString()}    Total: ${total.toString()}'),
    );
  }

  ListTile listTileServicio(servicio) {
    var cantidad = servicio['pivot']['cantidad'];
    var precio = servicio['pivot']['precio_venta'];
    var descuento = servicio['pivot']['descuento'];
    var total = cantidad * (precio - descuento);

    return ListTile(
      leading: Icon(MdiIcons.hairDryer),
      title: Text('${servicio['nombre']}'),
      subtitle: Text(
          'Cantidad: ${cantidad.toString()} Precio unidad: ${precio.toString()} Descuento unidad: ${descuento.toString()}    Total: ${total.toString()}'),
    );
  }

  FutureBuilder campoProducto() {
    return FutureBuilder(
      future: ProductosProvider().getAll(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return SizedBox(
            width: 300,
            child: DropdownButtonFormField<String>(
              borderRadius: BorderRadius.circular(30),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  contentPadding: EdgeInsets.only(left: 10, right: 10)),
              hint: Text('Cargando productos...'),
              items: [],
              onChanged: (value) {},
            ),
          );
        }

        var productos = snapshot.data;

        return SizedBox(
          width: 300,
          child: DropdownButtonFormField<int>(
            borderRadius: BorderRadius.circular(30),
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                contentPadding: EdgeInsets.only(left: 10, right: 10)),
            hint: Text('Seleccione producto'),
            items: productos.map<DropdownMenuItem<int>>((producto) {
              return DropdownMenuItem<int>(
                child: Text(
                    '${producto['producto_categoria']['nombre']} - ${producto['nombre']}'),
                value: producto['id'],
              );
            }).toList(),
            onChanged: (producto) {
              selectedProducto = producto!;
            },
          ),
        );
      },
    );
  }

  FutureBuilder campoServicio() {
    return FutureBuilder(
      future: ServiciosProvider().getAll(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return SizedBox(
            width: 300,
            child: DropdownButtonFormField<String>(
              borderRadius: BorderRadius.circular(30),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  contentPadding: EdgeInsets.only(left: 10, right: 10)),
              hint: Text('Cargando servicios...'),
              items: [],
              onChanged: (value) {},
            ),
          );
        }

        var servicios = snapshot.data;

        return SizedBox(
          width: 300,
          child: DropdownButtonFormField<int>(
            borderRadius: BorderRadius.circular(30),
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                contentPadding: EdgeInsets.only(left: 10, right: 10)),
            hint: Text('Seleccione servicio'),
            items: servicios.map<DropdownMenuItem<int>>((servicio) {
              return DropdownMenuItem<int>(
                child: Text(
                    '${servicio['servicio_categoria']['nombre']} - ${servicio['nombre']}'),
                value: servicio['id'],
              );
            }).toList(),
            onChanged: (servicio) {
              selectedServicio = servicio!;
            },
          ),
        );
      },
    );
  }
}
