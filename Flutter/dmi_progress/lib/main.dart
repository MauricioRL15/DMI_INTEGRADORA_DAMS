import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    Future.delayed(Duration(seconds: 1), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isSessionActive = prefs.getBool('isSessionActive') ?? false;
      bool keepSession = prefs.getBool('keepSession') ?? false;

      if (isSessionActive && keepSession) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NextScreen()),
        );
      }
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
      body: Container(
        color: Color.fromRGBO(248, 25, 46, 1.0), // Color de fondo
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/firebros3.png', height: 200.0), // La imagen
            SizedBox(height: 20.0),
            LinearProgressIndicator(
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(255, 255, 255, 255)),
              value: _progressValue,
              minHeight: 30.0,
            ),
            SizedBox(height: 20.0),
            Text(
              'Cargando...',
              style: TextStyle(color: Colors.white),
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
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isSessionActive', false);
              await prefs.setBool('keepSession', false);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => NextScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
  
            SizedBox(height: 20.0),
            // Agrega aquí cualquier contenido que desees mostrar en la pantalla de bienvenida.

      //INICIA BIENVENIDO

      Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Alinea los elementos en el centro horizontal
        children: [
          // Imagen en la parte superior
          Image.asset('assets/firebros2.png', height: 100.0),

          // Espaciado entre la imagen y los textos
          SizedBox(height: 10.0),

          // Texto 1
          Text(
            'Sanders',
            style: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Espaciado entre los textos
          SizedBox(height: 10.0),

          // Texto 2
          Text(
            'sanders13@gmail.com',
            style: TextStyle(
              fontSize: 17.0,
            ),
          ),
        ],
      ),


            // Biografía
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                'Mi nombre es Sandra, me gusta jugar videojuegos derribando enemigos para desestresarme un poco.',
                style: TextStyle(
                  fontSize: 16,
                ),
                maxLines: 3, // Puedes ajustar este valor según tus necesidades
                overflow: TextOverflow.ellipsis, // Ajusta cómo se maneja el desbordamiento
              ),
            ),


        // Editar perfil
Column(
  children: [
    SizedBox(
      height: 50.0,
      width: 200.0, 
      child: ElevatedButton(
        child: Text('Editar perfil'),
        onPressed: () {
          // Abrir una pantalla de edición de perfil
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditProfilePage()),
          );
        },
        style: ElevatedButton.styleFrom(
          primary: Color(0xFFAD1919),
          minimumSize: Size(double.infinity, 50), // Ancho máximo
        ),
      ),
    ),
    SizedBox(height: 15.0), // Espacio entre botones

    SizedBox(
      height: 50.0, // Ajusta la altura según el tamaño deseado
      width: 200.0, 

      child: ElevatedButton(
        child: Text('Mis puntajes'),
        onPressed: () {
          // Abrir una pantalla de puntajes
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RankingTablePage()),
          );
        },
        style: ElevatedButton.styleFrom(
          primary: Color(0xFFAD1919),
          minimumSize: Size(double.infinity, 50), // Ancho máximo
        ),
      ),
    ),
    SizedBox(height: 15.0), // Espacio entre botones

    SizedBox(
      height: 50.0,
      width: 200.0, 
 // Ajusta la altura según el tamaño deseado
      child: ElevatedButton(
        child: Text('Tabla de clasificación'),
        onPressed: () {
          // Abrir una pantalla de clasificación
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RankingTableMinePage()),
          );
        },
        style: ElevatedButton.styleFrom(
          primary: Color(0xFFAD1919),
          minimumSize: Size(double.infinity, 50), // Ancho máximo
        ),
      ),
    ),
  ],
),



            // Tabla de clasificación
          Image.asset('assets/firebros2.png', height: 200.0),




//TERMINA BIEMVENIDO
       

          ],
        ),
      ),
    );
  }
}

//EDITAR PERFIL
class EditProfilePage extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFAD1919),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isSessionActive', false);
              await prefs.setBool('keepSession', false);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => NextScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Contenido de la página de editar perfil'),
      ),
    );
 }
}

//TABLA PUNTAJES
class RankingTableMinePage extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFAD1919),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isSessionActive', false);
              await prefs.setBool('keepSession', false);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => NextScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Contenido de la página de tabla de mis puntos'),
      ),
    );
 }
}

//clasificación 
class RankingTablePage extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFAD1919),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isSessionActive', false);
              await prefs.setBool('keepSession', false);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => NextScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Contenido de la página de tabla de clasificación'),
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
  bool _keepSession = false;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    clientId:
        "176548420180-n1m2919btl1th40bopnnl7pfhdccnu7i.apps.googleusercontent.com",
  );

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
                obscureText: true,
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Checkbox(
                    value: _keepSession,
                    onChanged: (value) {
                      setState(() {
                        _keepSession = value ?? false;
                      });
                    },
                  ),
                  Text('Mantener sesión iniciada'),
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setBool('isSessionActive', true);
                  await prefs.setBool('keepSession', _keepSession);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFAD1919),
                ),
                child: Text(
                  'Iniciar sesión',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () async {
                      await _handleGoogleSignIn();
                    },
                    icon: Image.asset(
                      'assets/image1.png',
                      width: 40.0,
                      height: 40.0,
                    ),
                    label: Text('Google'),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      // Agrega aquí la lógica para iniciar sesión con Facebook
                    },
                    icon: Image.asset(
                      'assets/image2.png',
                      width: 50.0,
                      height: 50.0,
                    ),
                    label: Text('Facebook'),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      // Agrega aquí la lógica para iniciar sesión con Twitter
                    },
                    icon: Image.asset(
                      'assets/image3.png',
                      width: 50.0,
                      height: 50.0,
                    ),
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
}
