import 'package:app_sistema_invetnario/src/UI/ui.dart';
import 'package:app_sistema_invetnario/src/provider/provider.dart';
import 'package:app_sistema_invetnario/src/services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinishReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
        fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold);

    final formReportFish = Provider.of<FinishReportProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de Inventario"),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: formReportFish.formKeyReport,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      "Asistente",
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
                        autofocus: false,
                        style: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.text,
                        decoration: InputDecorationForm.formInputDecoration(
                          labelText: "",
                        ),
                        onChanged: (value) {
                          formReportFish.asistente = value;
                        },
                        validator: (dynamic value) {
                          if (value!.isEmpty) {
                            return 'El nombre es obligatorio';
                          }
                          if (value.length < 3) {
                            return 'El nombre debe contener más de tres carácteres';
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
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      "Conductor",
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
                        autofocus: false,
                        style: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.text,
                        decoration: InputDecorationForm.formInputDecoration(
                          labelText: "",
                        ),
                        onChanged: (value) {
                          formReportFish.conductor = value;
                        },
                        validator: (dynamic value) {
                          if (value!.isEmpty) {
                            return 'El nombre es obligatorio';
                          }
                          if (value.length < 3) {
                            return 'El nombre debe contener más de tres carácteres';
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
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      "Base",
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
                        autofocus: false,
                        style: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.text,
                        decoration: InputDecorationForm.formInputDecoration(
                          labelText: "",
                        ),
                        onChanged: (value) {
                          formReportFish.base = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'La base es obligatoria';
                          }

                          if (value.length < 3) {
                            return 'La base debe contener más de tres letras';
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      "Novedades",
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
                        maxLines: 4,
                        autofocus: false,
                        style: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecorationForm.formInputDecoration(
                          labelText: "",
                        ),
                        onChanged: (value) {
                          formReportFish.novedades = value;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              color: Colors.red.withOpacity(0.70),
              onPressed: () async {
                final reporte =
                    Provider.of<ReportService>(context, listen: false);
                FocusScope.of(context).unfocus();
                if (!formReportFish.isValidForm()) {
                  return;
                }

                final respuesta = await reporte.uptateReport(
                    formReportFish.asistente,
                    formReportFish.conductor,
                    formReportFish.base,
                    formReportFish.novedades);

                NotificationService.showSnackBar(respuesta);

                if (reporte.code == 200) {
                  reporte.isFinish = true;
                }

                Navigator.pop(context);
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
            SizedBox(
              height: 100,
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
