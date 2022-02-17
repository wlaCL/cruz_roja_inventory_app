import 'package:app_sistema_invetnario/src/provider/provider.dart';
import 'package:app_sistema_invetnario/src/screens/report_screen/present_data_report.dart';
import 'package:app_sistema_invetnario/src/screens/report_screen/screens_report.dart';
import 'package:app_sistema_invetnario/src/screens/report_screen/search_turn.dart';
import 'package:app_sistema_invetnario/src/screens/screens.dart';
import 'package:app_sistema_invetnario/src/services/push_notifications_services.dart';
import 'package:app_sistema_invetnario/src/services/security_service.dart';
import 'package:app_sistema_invetnario/src/services/services.dart';
import 'package:app_sistema_invetnario/src/shares_preferences/preferences_user.dart';
import 'package:app_sistema_invetnario/src/theme/theme_changer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/provider/ui_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = PreferencesUser();
  await prefs.initPref();
  await PushNotificationService.initalizeApp();
  runApp(AppState());
}

class AppState extends StatefulWidget {
  @override
  State<AppState> createState() => _AppStateState();
}

class _AppStateState extends State<AppState> {
  @override
  void initState() {
    super.initState();

    PushNotificationService.messageStream.listen((message) {
      NotificationService.showSnackBar(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    final prefs = PreferencesUser();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => RegisterProductServices()),
        ChangeNotifierProvider(create: (_) => ThemeChanger(prefs.color)),
        ChangeNotifierProvider(create: (_) => RegisterProductForm()),
        ChangeNotifierProvider(create: (_) => SecurityService()),
        ChangeNotifierProvider(create: (_) => ReportService()),
        ChangeNotifierProvider(create: (_) => SearchFormReport()),
        ChangeNotifierProvider(create: (_) => Register_Report()),
        ChangeNotifierProvider(create: (_) => Inventario()),
        ChangeNotifierProvider(create: (_) => InventoryForm()),
        ChangeNotifierProvider(create: (_) => FinishReportProvider()),
        ChangeNotifierProvider(create: (_) => InventoryEsencialsForm()),
        ChangeNotifierProvider(create: (_) => FormSearchPdf()),
        ChangeNotifierProvider(create: (_) => DonwloadReport()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeChanger>(context).currentTheme;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cruz Roja Ambulance Inventory',
        initialRoute: 'autentificated',
        scaffoldMessengerKey: NotificationService.messengerKey,
        home: HomeScreen(),
        theme: currentTheme,
        routes: {
          'login': (_) => LoginScreen(),
          'register_header_inventory': (_) => ReportScreen(),
          'home': (_) => HomeScreen(),
          'change_password': (_) => ChangePassword(),
          'autentificated': (_) => AuthScren(),
          'profile': (_) => ProfileScreen(),
          'search_turn': (_) => SearchTurn(),
          'report': (context) => PrincipalReportScreen(),
          'register_inventory': (context) => RegisterInventoryProduct(),
          'inventory_qr': (context) => RegisterProductEsencial(),
          'message': (context) => MessageScreen()
        },
      ),
    );
  }
}
