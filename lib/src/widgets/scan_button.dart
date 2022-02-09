import 'package:app_sistema_invetnario/src/services/notification_service.dart';
import 'package:app_sistema_invetnario/src/services/report_services.dart';
import 'package:app_sistema_invetnario/src/widgets/data_qr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final reporte = Provider.of<ReportService>(context);
    return ElevatedButton(
      onPressed: reporte.isFinish
          ? null
          : () async {
              String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                  '#58C2E8', 'Cancelar', true, ScanMode.QR);

              if (barcodeScanRes == '-1') {
                return;
              }
              print(barcodeScanRes);
              bool isValid = isUUID(barcodeScanRes, 4);

              if (isValid) {
                pushNewScreen(context,
                    screen: DataQR(
                      id_producto: barcodeScanRes,
                    ));
              } else {
                NotificationService.showSnackBar("Identificador no válido");
                return;
              }
            },
      child: Icon(Icons.qr_code_2, color: Colors.white),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(15),
        primary: Colors.red.withOpacity(0.7), // <-- Button color
        onPrimary: Colors.red.withOpacity(0.4), // <-- Splash color
      ),
    );
  }
}
