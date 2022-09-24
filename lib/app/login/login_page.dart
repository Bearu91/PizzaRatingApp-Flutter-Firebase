import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    Key? key,
  }) : super(key: key);

  final emailContorller = TextEditingController();

  final passwordContorller = TextEditingController();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

var errorMessage = '';
var isCreatingAccount = false;

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(isCreatingAccount == true ? 'Zarejestruj sie' : 'Zaloguj sie'),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: widget.emailContorller,
              decoration: const InputDecoration(hintText: 'E-mail'),
            ),
            TextField(
              controller: widget.passwordContorller,
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Haslo'),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(errorMessage),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                if (isCreatingAccount == true) {
                  try {
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: widget.emailContorller.text,
                      password: widget.passwordContorller.text,
                    );
                  } catch (error) {
                    setState(() {
                      errorMessage = error.toString();
                    });
                  }
                } else {
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: widget.emailContorller.text,
                      password: widget.passwordContorller.text,
                    );
                  } catch (error) {
                    setState(() {
                      errorMessage = error.toString();
                    });
                  }
                }
              },
              child: Text(isCreatingAccount == true
                  ? 'Zarejestruj sie'
                  : 'Zaloguj sie'),
            ),
            const SizedBox(
              height: 25,
            ),
            if (isCreatingAccount == false) ...[
              TextButton(
                onPressed: () {
                  setState(() {
                    isCreatingAccount = true;
                  });
                },
                child: const Text('Utwórz konto'),
              ),
            ],
            if (isCreatingAccount == true) ...[
              TextButton(
                onPressed: () {
                  setState(() {
                    isCreatingAccount = false;
                  });
                },
                child: const Text('Masz już konto?'),
              ),
            ]
          ],
        ),
      )),
    );
  }
}
