import 'package:app_sistema_invetnario/src/models/models.dart';
import 'package:app_sistema_invetnario/src/provider/provider.dart';
import 'package:app_sistema_invetnario/src/screens/screens.dart';
import 'package:app_sistema_invetnario/src/services/services.dart';
import 'package:app_sistema_invetnario/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class LoadDataPDF extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: DataLoad(child: SearchDateReport()));
  }
}

class SearchDateReport extends StatelessWidget {
  final TextEditingController controllerDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final registerProductServices =
        Provider.of<RegisterProductServices>(context);

    final searchPdfReport = Provider.of<FormSearchPdf>(context);
    final textStyle = TextStyle(
        fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(title: Text("Búsqueda de reporte")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: searchPdfReport.formkey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text("Ambulancia", style: textStyle),
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
                        searchPdfReport.placa = value;
                      },
                      hint: Text("Selecciona la placa"),
                      validator: (value) {
                        if (value == null) {
                          return 'Es necesario una ambulancia';
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text("Fecha ", style: textStyle),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      controller: controllerDate,
                      enableInteractiveSelection: false,
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.calendar_today,
                              color: Colors.indigo.withOpacity(0.7)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0))),
                      onTap: () {
                        FocusScope.of(context).requestFocus(
                            FocusNode()); //requestFocus(new FocusNode());
                        _selectDate(context);
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            MaterialButton(
              color: Colors.red.withOpacity(0.7),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              onPressed: () async {
                searchPdfReport.fecha = controllerDate.text;
                if (searchPdfReport.fecha.length < 10) {
                  NotificationService.showSnackBar(
                      "Selecciona una fecha válida");
                }
                if (!searchPdfReport.isValidForm()) {
                  return;
                }
                pushNewScreen(
                  context,
                  screen: DataLoadReports(),
                  withNavBar: true, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 20.0),
                child: Container(
                  child: Text("Buscar",
                      style: TextStyle(fontSize: 16.0, color: Colors.white)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    dynamic picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2025));
    controllerDate.text = (picked.toString().length >= 10)
        ? picked.toString().substring(0, 10)
        : 'Sin fecha';
  }
}
