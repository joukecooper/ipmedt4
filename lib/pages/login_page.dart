import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ipmedt4/pages/home_page.dart';
import 'package:ipmedt4/pages/register_page.dart';
import 'package:ipmedt4/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  final _auth = AuthService();

  late StreamSubscription _loginSubscription;

  @override
  void initState() {
    super.initState();
    _loginSubscription = _auth.listenToUser().listen((user) {
      if (user != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    });
  }

  @override
  void dispose() {
    _loginSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Login pagina"),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
            TextField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await _auth.loginUser(
                        _emailController.text, _passwordController.text);
                  },
                  child: Text("Login"),
                ),
              ],
            ),
            SizedBox(height: 20), // Voeg ruimte toe tussen de knoppen en de tekst
            Text("Nog geen account?"),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage(title: 'Register Page')),
                );
              },
              child: Text('Registreer hier'),
            ),
          ],
        ),
      ),
    );
  }
}
