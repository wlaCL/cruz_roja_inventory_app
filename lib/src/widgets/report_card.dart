import 'package:app_sistema_invetnario/src/provider/provider.dart';
import 'package:app_sistema_invetnario/src/services/services.dart';
import 'package:flutter/material.dart';

import 'package:app_sistema_invetnario/src/models/models.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReportCard extends StatelessWidget {
  Reporte? itemReport;
  ReportCard({
    this.itemReport,
  });
  @override
  Widget build(BuildContext context) {
    DateTime fechaActual = itemReport!.fecha;
    String? id;
    String fechaFinal = DateFormat('yyyy-MM-dd').format(fechaActual);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.indigo.withOpacity(0.4),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: ListTile(
          title: Text(
            '${itemReport!.trabaja.persona.nombre} ${itemReport!.trabaja.persona.apellido}',
            style: TextStyle(fontSize: 16.0, color: Colors.black),
          ),
          subtitle: Text('${fechaFinal}'),
          trailing: IconButton(
            icon: Icon(
              Icons.download_for_offline,
              color: Colors.indigo,
            ),
            iconSize: 50.0,
            onPressed: () async {
              id = itemReport!.idReporte;
              final reportpdf =
                  Provider.of<DonwloadReport>(context, listen: false);
              await reportpdf.openFile(url: id!);
            },
          ),
        ),
      ),
    );
  }
}
