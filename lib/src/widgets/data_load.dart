import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_sistema_invetnario/src/services/services.dart';
import 'package:app_sistema_invetnario/src/widgets/widgets.dart';

class DataLoad extends StatelessWidget {
  final Widget child;
  const DataLoad({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataProduct = Provider.of<RegisterProductServices>(context);
    return FutureBuilder(
      future: dataProduct.dataLoad(),
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
                  pageBuilder: (_, __, ___) => child,
                  transitionDuration: Duration(seconds: 0),
                ),
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
