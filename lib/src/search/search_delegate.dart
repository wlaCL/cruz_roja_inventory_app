import 'package:app_sistema_invetnario/src/provider/provider.dart';
import 'package:app_sistema_invetnario/src/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_sistema_invetnario/src/models/inventario_response.dart';
import 'package:app_sistema_invetnario/src/services/services.dart';

class ProductosSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar producto';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
          final inventarioService =
              Provider.of<Inventario>(context, listen: false);
          //inventarioService.productos.clear();
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "No hay resultados",
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }

    final inventory = Provider.of<Inventario>(context, listen: false);
    final searchForm = Provider.of<SearchFormReport>(context);
    inventory.placa = searchForm.placa;

    inventory.getSuggestionsByQuery(query, searchForm.placa);

    return StreamBuilder(builder: (_, AsyncSnapshot<List<Products>> snapshot) {
      if (inventory.code != 200) return _emptyContainer();

      final products = inventory.productos;

      return ListView.builder(
        itemCount: products.length,
        itemBuilder: (_, int index) => ItemProduct(producto: products[index]),
      );
    });
  }
}

Widget _emptyContainer() {
  return Container(
    child: Center(
      child: Icon(
        Icons.medication,
        color: Colors.black45,
        size: 130,
      ),
    ),
  );
}

class ItemProduct extends StatelessWidget {
  final Products producto;
  const ItemProduct({
    required this.producto,
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(producto.nombre),
      trailing: Text(producto.tipo),
      onTap: () {
        // Navigator.pushNamed(context, 'register_inventory', arguments: producto);
        Navigator.of(context, rootNavigator: true)
            .pushNamed("register_inventory", arguments: producto);
      },
    );
  }
}
