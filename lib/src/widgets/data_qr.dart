import 'package:app_sistema_invetnario/src/provider/provider.dart';
import 'package:app_sistema_invetnario/src/screens/scanner_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_sistema_invetnario/src/services/services.dart';
import 'package:app_sistema_invetnario/src/widgets/widgets.dart';

class DataQR extends StatelessWidget {
  final String? id_producto;

  const DataQR({
    Key? key,
    this.id_producto,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final searchTurn = Provider.of<SearchFormReport>(context);
    final dataProduct = Provider.of<Inventario>(context);
    return Scaffold(
      body: FutureBuilder(
        future: dataProduct.searchScan(id_producto!, searchTurn.placa),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return LoadingScreeen();
          }

          if (snapshot.data != '') {
            Future.microtask(
              () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) =>
                        ScanScanner(), //TODO PANTALLA DE LOS DATOS
                    transitionDuration: Duration(seconds: 0),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
