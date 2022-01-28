import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
        ),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: ((context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextField(
                      controller: _email,
                      decoration: const InputDecoration(
                        label: Text(
                          'Email',
                        ),
                        hintText: 'Please Enter Email',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextField(
                      controller: _password,
                      decoration: const InputDecoration(
                        label: Text(
                          'Password',
                        ),
                        hintText: 'Please Enter Password',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      obscuringCharacter: '*',
                      enableSuggestions: false,
                      autocorrect: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () async {
                        final email = _email.text;
                        final password = _password.text;
                        try {
                          final userCredential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          print(userCredential);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('User Not Found');
                          } else if (e.code == 'wrong-password') {
                            print('Wrong Pswd');
                          }
                        }
                      },
                      child: const Text(
                        'Login',
                      ),
                    ),
                  ),
                ],
              );
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        }),
      ),
    );
  }
}