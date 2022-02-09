import 'package:app_sistema_invetnario/src/models/models.dart';
import 'package:app_sistema_invetnario/src/provider/provider.dart';
import 'package:app_sistema_invetnario/src/screens/report_screen/screens_report.dart';
import 'package:app_sistema_invetnario/src/screens/report_screen/verify_report.dart';
import 'package:app_sistema_invetnario/src/services/services.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class SearchTurn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String fecha = DateFormat('yyyy-MM-dd').format(now);

    final textStyle = TextStyle(
        fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold);
    final registerProductServices =
        Provider.of<RegisterProductServices>(context);
    final searchForm = Provider.of<SearchFormReport>(context);
    searchForm.fecha = fecha;
    return Scaffold(
      appBar: AppBar(
        title: Text("Reporte"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50.0,
            ),
            Form(
              key: searchForm.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      "Ambulancia",
                      style: textStyle,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: DropdownButtonFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      isExpanded: true,
                      isDense: true,
                      items: registerProductServices.ambulancias
                          .map((Ambulancia ambulancia) {
                        return DropdownMenuItem(
                            value: '${ambulancia.placa}',
                            child: Text(
                              '${ambulancia.placa}',
                              style: TextStyle(color: Colors.black),
                            ));
                      }).toList(),
                      onChanged: (dynamic value) {
                        searchForm.placa = value;
                      },
                      hint: Text("Selecciona la placa"),
                      validator: (value) {
                        if (value == null) {
                          return 'Es necesario una ambulancia';
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              color: Colors.red.withOpacity(0.8),
              onPressed: () async {
                FocusScope.of(context).unfocus();
                final reporte =
                    Provider.of<ReportService>(context, listen: false);
                final inventario =
                    Provider.of<Inventario>(context, listen: false);

                if (!searchForm.isValid()) {
                  return;
                }
                //Navigator.pushReplacementNamed(context, 'home');

                final result =
                    await reporte.isReporte(searchForm.fecha, searchForm.placa);

                if (reporte.code == 200 || reporte.code == 422) {
                  NotificationService.showSnackBar(result);

                  return;
                }
                inventario.productos.clear();
                reporte.isFinish = false;
                pushNewScreen(
                  context,
                  screen: VerifyReport(child: PresentDataReport()),
                  withNavBar: true, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 80.0,
                  vertical: 20.0,
                ),
                child: Container(
                  child: Text("Buscar",
                      style: TextStyle(fontSize: 16.0, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
