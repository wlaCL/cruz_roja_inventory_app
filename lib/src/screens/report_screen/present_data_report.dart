import 'package:app_sistema_invetnario/src/UI/ui.dart';

import 'package:app_sistema_invetnario/src/provider/provider.dart';
import 'package:app_sistema_invetnario/src/screens/report_screen/screens_report.dart';
import 'package:app_sistema_invetnario/src/services/report_services.dart';
import 'package:app_sistema_invetnario/src/services/services.dart';
import 'package:app_sistema_invetnario/src/shares_preferences/preferences_user.dart';
import 'package:app_sistema_invetnario/src/theme/theme_changer.dart';
import 'package:app_sistema_invetnario/src/widgets/buttons_colums.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'package:provider/provider.dart';

class PresentDataReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final reportService = Provider.of<ReportService>(context);
    return (reportService.code == 404)
        ? CreateReport()
        : PrincipalReportScreen();
  }
}

class PrincipalReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context).darkTheme;
    final reporte = Provider.of<ReportService>(context);
    final inventarioService = Provider.of<Inventario>(context, listen: false);
    DateTime now = DateTime.now();
    String fecha = DateFormat('yyyy-MM-dd').format(now);
    final prefs = PreferencesUser();
    inventarioService.productos.clear();
    final textStyle = TextStyle(
        fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Reporte"),
      ),
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  "Fecha",
                  style: textStyle,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 10.0),
                  decoration: _buildDecorationInput(),
                  child: TextFormField(
                    enabled: false,
                    initialValue: fecha,
                    autofocus: false,
                    style: TextStyle(color: Colors.black),
                    keyboardType: TextInputType.text,
                    decoration: InputDecorationForm.formInputDecoration(
                      labelText: "",
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  "Cédula",
                  style: textStyle,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 10.0),
                  decoration: _buildDecorationInput(),
                  child: TextFormField(
                    enabled: false,
                    initialValue: prefs.cedula,
                    autofocus: false,
                    style: TextStyle(color: Colors.black),
                    keyboardType: TextInputType.text,
                    decoration: InputDecorationForm.formInputDecoration(
                      labelText: "",
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50.0,
          ),
          MaterialButton(
            disabledColor: Colors.grey,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: Colors.red.withOpacity(0.8),
            onPressed: reporte.isFinish
                ? null
                : () {
                    pushNewScreen(
                      context,
                      screen: FinishReport(),
                      withNavBar: true, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 80.0,
                vertical: 20.0,
              ),
              child: Container(
                child: Text("Finalizar",
                    style: TextStyle(fontSize: 16.0, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: OptionsFloatingActionsBtn(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }

  BoxDecoration _buildDecorationInput() {
    return BoxDecoration(
      color: Colors.black.withOpacity(0.10),
      borderRadius: BorderRadius.circular(10.0),
    );
  }
}

class CreateReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final searchForm = Provider.of<SearchFormReport>(context);
    final prefs = PreferencesUser();
    DateTime now = DateTime.now();
    String fecha = DateFormat('yyyy-MM-dd').format(now);

    final textStyle = TextStyle(
        fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold);
    final registerProductServices =
        Provider.of<RegisterProductServices>(context);
    final registerReport = Provider.of<Register_Report>(context);
    registerReport.fecha = fecha;
    registerReport.placa = searchForm.placa;
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        title: Text("Creación de Reporte"),
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
              key: registerReport.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 10.0),
                      decoration: _buildDecorationInput(),
                      child: TextFormField(
                        initialValue: "${searchForm.placa}",
                        enabled: false,
                        autofocus: false,
                        style: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.text,
                        decoration: InputDecorationForm.formInputDecoration(
                          labelText: "",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      "Nombre del Paramédico",
                      style: textStyle,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 10.0),
                      decoration: _buildDecorationInput(),
                      child: TextFormField(
                        initialValue: "${prefs.name + "  " + prefs.lastName}",
                        enabled: false,
                        autofocus: false,
                        style: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.text,
                        decoration: InputDecorationForm.formInputDecoration(
                          labelText: "",
                        ),
                        //onChanged: (value) => registerForm.nombre = value,
                        validator: (dynamic value) {
                          if (value!.isEmpty) {
                            return 'El nombre es obligatorio';
                          }
                          final pattern = r'(^[a-zA-Z ]*$)';
                          RegExp regExp = new RegExp(pattern);

                          return regExp.hasMatch(value ?? '')
                              ? null
                              : 'El valor ingresado no luce como un nombre';
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      "Cédula",
                      style: textStyle,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 10.0),
                      decoration: _buildDecorationInput(),
                      child: TextFormField(
                        enabled: false,
                        initialValue: prefs.cedula,
                        autofocus: false,
                        style: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.text,
                        decoration: InputDecorationForm.formInputDecoration(
                          labelText: "",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      "Fecha",
                      style: textStyle,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 10.0),
                      decoration: _buildDecorationInput(),
                      child: TextFormField(
                        enabled: false,
                        initialValue: fecha,
                        autofocus: false,
                        style: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.text,
                        decoration: InputDecorationForm.formInputDecoration(
                          labelText: "",
                        ),
                      ),
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
                if (!registerReport.isValid()) {
                  return;
                }
                String message = await reporte.createReport(
                    registerReport.placa, registerReport.fecha);

                NotificationService.showSnackBar(message);
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
                  child: Text("Guardar",
                      style: TextStyle(fontSize: 16.0, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildDecorationInput() {
    return BoxDecoration(
      color: Colors.black.withOpacity(0.10),
      borderRadius: BorderRadius.circular(10.0),
    );
  }
}
