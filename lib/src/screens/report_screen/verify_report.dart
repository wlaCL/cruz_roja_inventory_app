import 'package:app_sistema_invetnario/src/provider/search_report_form.dart';
import 'package:app_sistema_invetnario/src/services/services.dart';
import 'package:app_sistema_invetnario/src/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerifyReport extends StatelessWidget {
  final Widget child;
  const VerifyReport({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ReportService>(context);
    final searchForm = Provider.of<SearchFormReport>(context);
    return Scaffold(
      body: FutureBuilder(
        future: data.isReporte(searchForm.fecha, searchForm.placa),
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
      ),
    );
  }
}
