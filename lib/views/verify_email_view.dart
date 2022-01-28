import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Verify Email',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Please verify your email address!!!',
            style: TextStyle(
              color: Colors.blue,
            ),
            textScaleFactor: 1.5,
          ),
          const SizedBox(
            height: 50,
          ),
          TextButton(
            onPressed: (() async {
              final user = FirebaseAuth.instance.currentUser;
              await user?.sendEmailVerification();
            }),
            child: const Text(
              'Verify',
            ),
          )
        ],
      ),
    );
  }
}
