import 'package:appbutawarna/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String errorMessage = '';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void register() async {
    try {
      await authService.value.createAccount(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? 'An error occurred';
      });
      return;
    }
     await authService.value.createAccount(
      email: emailController.text,
      password: passwordController.text,
    );
    popPage();
  }

  void popPage() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Email TextField
            TextFormField(
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: const TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: HexColor('#1ABC9C'), width: 2.5),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Password TextField
            TextFormField(
              obscureText: true,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: const TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: HexColor('#1ABC9C'), width: 2.5),
                ),
              ),
            ),
            SizedBox(height: 10,),

            Text(
              errorMessage,
              style: const TextStyle(color: Colors.red),
            ),

            const SizedBox(height: 20),

            SizedBox(height: 32,),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: HexColor('#1ABC9C'), width: 2),
                  ),
                ).copyWith(
                  overlayColor: WidgetStateProperty.all(HexColor('#1ABC9C').withOpacity(0.2)),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    register();
                  }
                },
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    color: HexColor('#1ABC9C'),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
