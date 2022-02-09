import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_sistema_invetnario/src/models/inventario_response.dart';
import 'package:app_sistema_invetnario/src/services/services.dart';

class ScanScanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final inventarioService = Provider.of<Inventario>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Productos"),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new)),
          leadingWidth: 40.0, //Icon(Icons.arrow_back_ios_new),
        ),
        body: (inventarioService.ok == true)
            ? BodyProduct(productos: inventarioService.productos[0].productos)
            : BodyMessage());
  }
}

class BodyProduct extends StatelessWidget {
  final List<Producto>? productos;
  const BodyProduct({
    Key? key,
    this.productos,
  });
  @override
  Widget build(BuildContext context) {
    final inventarioService = Provider.of<Inventario>(context);
    return ListView.builder(
      itemCount: productos!.length,
      itemBuilder: (_, int index) => CardProduct(
        producto: productos![index],
      ),
    );
  }
}

class BodyMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "No existen registros",
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}

class CardProduct extends StatelessWidget {
  final Producto producto;
  const CardProduct({
    Key? key,
    required this.producto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.indigo[300],
            boxShadow: [
              BoxShadow(
                  offset: const Offset(1, 5),
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 0.5)
            ]),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context, rootNavigator: true)
                .pushNamed("inventory_qr", arguments: producto);
          },
          child: ListTile(
            title: Text('Fecha de caducidad: ${producto.fechaCaducidad}'),
            subtitle: Text(
              'Stock: ${producto.productoAmbulancia[0].stock}',
              style: TextStyle(color: Colors.black),
            ),
            trailing: Icon(Icons.arrow_forward_ios_sharp),
          ),
        ),
      ),
    );
  }
}
