import 'package:edifica/atividade_screen.dart';
import 'package:edifica/capitulo_screen.dart';
import 'package:edifica/inicial_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black, // navigation bar color
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent, // status bar color
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edifica',
      home: const MyStatefulWidget(),
      routes: <String, WidgetBuilder>{
        '/capitulo': (BuildContext context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map;
          return CapituloScreen(capituloScreenStatus: args['capituloScreenStatus']);
        },
        '/atividade': (BuildContext context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map;
          return AtividadeScreen(atividadeScreenStatus: args['atividadeScreenStatus']);
        }
      },
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return const InicialPage();
  }
}
