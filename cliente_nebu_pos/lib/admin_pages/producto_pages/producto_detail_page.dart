import 'package:cliente_nebu_pos/services/productos_provider.dart';
import 'package:flutter/material.dart';

class ProductoDetailPage extends StatelessWidget {
  final int id;
  const ProductoDetailPage(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle producto'),
      ),
      body: FutureBuilder(
        future: ProductosProvider().get(this.id),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          var producto = snapshot.data;
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Id: #${producto['id'].toString().padLeft(3, '0')}'),
                Text('Tipo: ${producto['tipo'] == 0 ? 'Insumo' : 'Producto'}'),
                Text('Nombre: ${producto['nombre']}'),
                Text('Precio: ${producto['precio'].toString()}'),
                Text('Costo: ${producto['costo'].toString()}'),
                Text('Stock: ${producto['stock']}'),
                Text('Stock mínimo: ${producto['stock_min']}'),
                Text(
                    'Estado: ${producto['estado'] == 0 ? 'Descontinuado' : 'Habilitado'}'),
                Text('Descripción: ${producto['descripcion']}'),
                Text('Categoria: ${producto['producto_categoria']['nombre']}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
