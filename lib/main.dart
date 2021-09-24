import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mascotas_app/pages/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Cree el futuro de inicialización fuera de `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Inicializar FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Compruebe si hay errores
        if (snapshot.hasError) {
          return const CircularProgressIndicator();
        }
        // Una vez completado, muestre su solicitud
        if (snapshot.connectionState == ConnectionState.done) {
          return const MaterialApp(
            title: 'Material App',
            home: SplashScreen(),
          );
        }
        // De lo contrario, muestre algo mientras espera a que se complete la inicialización
        return const CircularProgressIndicator();
      },
    );
  }
}
