import 'package:app_sistema_invetnario/src/search/search_delegate.dart';
import 'package:app_sistema_invetnario/src/services/report_services.dart';
import 'package:app_sistema_invetnario/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OptionsFloatingActionsBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final reporte = Provider.of<ReportService>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ScanButton(),
        SizedBox(
          height: 20.0,
        ),
        ElevatedButton(
          onPressed: reporte.isFinish
              ? null
              : () => showSearch(
                  context: context, delegate: ProductosSearchDelegate()),
          child: Icon(Icons.note_alt_rounded, color: Colors.white),
          style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(15),
              primary: Colors.red.withOpacity(0.7), // <-- Button color
              onPrimary: Colors.red.withOpacity(0.7) // <-- Splash color
              ),
        ),
        SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}
