import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/models/user.dart';
import 'package:todo/screens/authenticate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart' as prov;
import 'package:todo/screens/tabsceeen.dart';
import 'package:todo/services/authservice.dart';


double scaledWidth(BuildContext context, double value) {
  return value * MediaQuery.of(context).size.width / 411;
}

double scaledHeight(BuildContext context, double value) {
  return value * MediaQuery.of(context).size.height / 683;
}

 Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown]).then(
    (value) {
      runApp(
        ProviderScope(child: MyApp()),
      );
    },
  );
}

ColorScheme kcolorScheme = ColorScheme.fromSeed(seedColor: Colors.deepPurple);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return prov.StreamProvider<TodoUser?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: kcolorScheme,
          textTheme: TextTheme(
            headlineLarge: TextStyle(
              fontWeight: FontWeight.w500,
              color: kcolorScheme.onSecondaryContainer,
            ),
          ),
          cardTheme: CardTheme(
            color: kcolorScheme.primaryContainer,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const Wrapper()
      ),
    );
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = prov.Provider.of<TodoUser?>(context);

    if (user == null){
      return const AuthenticateScreen();
    } else{
    return TabScreen();
    }
  }
}