import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SplashScreen(), debugShowCheckedModeBanner: false);
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Simula una espera de 5 segundos
    Future.delayed(Duration(seconds: 5), () {
      // Navegar a la siguiente pantalla
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NextScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return InitialScreen();
  }
}

class InitialScreen extends StatefulWidget {
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  double _progressValue = 0.0;
  double _progressIncrement = 0.02; // Ajusta la velocidad del progreso

  @override
  void initState() {
    super.initState();

    // Actualiza el progreso cada 100 milisegundos
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        if (_progressValue < 1.0) {
          _progressValue += _progressIncrement; // Incrementa el progreso
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Elimina la AppBar
      // appBar: AppBar(
      //   title: Text('Pantalla inicial'),
      // ),
      body: Container(
        color: Color.fromRGBO(248, 25, 46, 1.0), // Color de fondo
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/firebros3.png', height: 200.0), // La imagen
            SizedBox(height: 20.0),
            // LinearProgressIndicator con color transparente
            LinearProgressIndicator(
              backgroundColor: Colors.transparent, // Color de fondo de la barra
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(255, 255, 255, 255)), // Color de la barra
              value: _progressValue,
              minHeight:
                  30.0, // Altura mínima de la barra de progreso (controla el grosor)
            ),
            SizedBox(height: 20.0),
            Text(
              'Cargando...',
              style: TextStyle(color: Colors.white), // Color del texto
            ),
          ],
        ),
      ),
    );
  }
}

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pantalla siguiente'),
        backgroundColor: Color(0xFFAD1919), // Color del AppBar en hexadecimal
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 16.0), // Ajusta el espaciado superior
          child: Column(
            children: <Widget>[
              Text(
                'Bienvenido a FIREBROS!',
                style: TextStyle(
                  fontSize: 26.0, // Tamaño de fuente
                  fontWeight: FontWeight.bold, // Texto en negrita
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
