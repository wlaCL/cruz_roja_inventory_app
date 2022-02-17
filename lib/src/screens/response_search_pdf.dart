import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_sistema_invetnario/src/models/models.dart';
import 'package:app_sistema_invetnario/src/provider/provider.dart';
import 'package:app_sistema_invetnario/src/services/services.dart';
import 'package:app_sistema_invetnario/src/widgets/widgets.dart';

class DataLoadReports extends StatelessWidget {
  const DataLoadReports({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serviceReports = Provider.of<ReportService>(context);
    final formpdf = Provider.of<FormSearchPdf>(context);
    return Scaffold(
      body: FutureBuilder(
        future: serviceReports.getDataReports(formpdf.placa, formpdf.fecha),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (!snapshot.hasData) {
            return LoadingScreeen();
          }

          if (snapshot.data == 200) {
            Future.microtask(
              () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) =>
                        ExistDataReport(reportesAll: serviceReports.reportes),
                    transitionDuration: Duration(seconds: 0),
                  ),
                );
              },
            );
          } else {
            Future.microtask(
              () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => NotExistDataReport(),
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

class ExistDataReport extends StatelessWidget {
  List<Reporte>? reportesAll;
  ExistDataReport({
    required this.reportesAll,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Búsqueda de Reportes"),
        ),
        body: ListView.builder(
          itemCount: reportesAll!.length,
          itemBuilder: (_, int index) => ReportCard(
            itemReport: reportesAll![index],
          ),
        ));
  }
}

class NotExistDataReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Búsqueda de Reportes"),
        ),
        body: Center(
          child: Text(
            "No hay reportes disponibles",
            style: TextStyle(fontSize: 25.0),
          ),
        ));
  }
}
