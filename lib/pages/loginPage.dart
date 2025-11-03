import 'package:appbutawarna/pages/homepage.dart';
import 'package:appbutawarna/services/auth_service.dart';
import 'package:appbutawarna/widgets/primary_button.dart';
import 'package:appbutawarna/widgets/text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String errorMessage = '';

  void login() async {
    try {
      await authService.value.signIn(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Homepage()),
            (Route<dynamic> route) => false,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? 'An error occurred';
      });
    }
  }

  void popPage() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 132,),
        
              Text(
                "Colorn't",
                style: TextStyle(color: HexColor('#1ABC9C'),fontSize: 24, fontWeight: FontWeight.bold)
              ),
        
              Text(
                  "Selamat Datang!",
                  style: TextStyle(color: Colors.black,fontSize: 32, fontWeight: FontWeight.bold)
              ),
        
              const SizedBox(height: 64,),

              const Text(
                'Email',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
        
              const SizedBox(height: 8,),

              // Email
              CustomTextField(
                controller: emailController,
                hintText: 'Ketikkan email anda...',
                keyboardType: TextInputType.emailAddress,
              ),
        
              const SizedBox(height: 32),

              const Text(
                'Password',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
        
              // Password
              CustomTextField(
                  controller: passwordController,
                  hintText: 'Ketikkan password anda...',
                  obscureText: true
              ),
        
              const SizedBox(height: 42,),
        
              PrimaryButton(text: 'Masuk', onPressed: login),
            ],
          ),
        ),
      ),
    );
  }
}
