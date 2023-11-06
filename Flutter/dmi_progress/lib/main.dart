import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';

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

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido'),
        backgroundColor: Color(0xFFAD1919),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '¡Bienvenido!',
              style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            // Agrega aquí cualquier contenido que desees mostrar en la pantalla de bienvenida.
          ],
        ),
      ),
    );
  }
}

class NextScreen extends StatefulWidget {
  @override
  _NextScreenState createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final String usuarioPreestablecido = 'admin';
  final String contrasenaPreestablecida = '1234';

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    clientId:
        "176548420180-n1m2919btl1th40bopnnl7pfhdccnu7i.apps.googleusercontent.com",
  );

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username == usuarioPreestablecido &&
        password == contrasenaPreestablecida) {
      // Los datos de inicio de sesión son correctos
      // Navega a la pantalla de bienvenida
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error de inicio de sesión'),
            content: Text(
                'Las credenciales son incorrectas. Por favor, inténtalo de nuevo.'),
            actions: <Widget>[
              TextButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        // El usuario ha iniciado sesión con éxito con Google.
        print('Usuario autenticado con éxito: ${googleUser.displayName}');
      } else {
        print('No se ha seleccionado ninguna cuenta de Google.');
      }
    } catch (error) {
        print('Error al iniciar sesión con Google: $error');
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pantalla de inicio de sesión'),
        backgroundColor: Color(0xFFAD1919),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('assets/firebros3.png', height: 200.0),
                ],
              ),
              Text(
                'Bienvenido a FIREBROS!',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Correo electrónico'),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true, // Para ocultar la contraseña
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  primary: Color(
                      0xFFAD1919), // Establece el color de fondo del botón
                ),
                child: Text(
                  'Iniciar sesión',
                  style: TextStyle(
                      color: Colors
                          .white), // Establece el color del texto del botón
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("¿Usuario nuevo?"),
                  TextButton(
                    onPressed: () {
                      // Aquí puedes agregar la navegación a la pantalla de registro
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => RegistroScreen()));
                    },
                    child: Text("Crear cuenta"),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    onPressed: _handleGoogleSignIn,
                    icon: Image.asset('assets/image1.png',
                        width: 40.0, height: 40.0),
                    label: Text(
                        'Google'), // Puedes personalizar el texto del botón
                  ),
                  TextButton.icon(
                    onPressed: () {
                      // Agrega aquí la lógica para iniciar sesión con Facebook
                    },
                    icon: Image.asset('assets/image2.png',
                        width: 50.0, height: 50.0),
                    label: Text('Facebook'),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      // Agrega aquí la lógica para iniciar sesión con Twitter
                    },
                    icon: Image.asset('assets/image3.png',
                        width: 50.0, height: 50.0),
                    label: Text('Twitter'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
