import 'package:appbutawarna/core/theme/app_theme.dart';
import 'package:appbutawarna/pages/auth/register_page.dart';
import 'package:appbutawarna/pages/home/main_page.dart';
import 'package:appbutawarna/services/auth_service.dart';
import 'package:appbutawarna/core/utils/snackbar_helper.dart';
import 'package:appbutawarna/widgets/primary_button.dart';
import 'package:appbutawarna/widgets/text_form_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final AuthService _authService = AuthService();

  bool _isLoading = false;

  Future<void> login() async {
    if (emailController.text.trim().isEmpty) {
      SnackBarHelper.showError(context, "Email tidak boleh kosong");
      return;
    }

    if (passwordController.text.trim().isEmpty) {
      SnackBarHelper.showError(context, "Password tidak boleh kosong");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final result = await _authService.signIn(
      email: emailController.text.trim(),
      password: passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (!mounted) return;

    if (result.success) {
      SnackBarHelper.showSuccess(context, result.message);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
          (Route<dynamic> route) => false
      );
    } else {
      SnackBarHelper.showError(context, result.message);
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
              const SizedBox(height: 80,),
        
              Text(
                "Halo,",
                style: TextStyle(color: AppTheme.primaryColor,fontSize: 48, fontWeight: FontWeight.bold)
              ),
        
              Text(
                  "Selamat Datang!",
                  style: TextStyle(color: Colors.black,fontSize: 32, fontWeight: FontWeight.bold)
              ),
        
              const SizedBox(height: 48,),

              // Email label
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textSecondary,
                ),
              ),
        
              const SizedBox(height: 8,),

              // Email TextField
              CustomTextField(
                controller: emailController,
                hintText: 'Ketikkan email anda...',
                keyboardType: TextInputType.emailAddress,
                enabled: !_isLoading,
              ),
        
              const SizedBox(height: 24),

              // Password label
              Text(
                'Password',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textSecondary,
                ),
              ),

              const SizedBox(height: 8,),
        
              // Password TextField
              CustomTextField(
                controller: passwordController,
                hintText: 'Ketikkan password anda...',
                obscureText: true,
                enabled: !_isLoading,
              ),
        
              const SizedBox(height: 42,),
        
              PrimaryButton(
                text: _isLoading ? 'Memproses...' : 'Masuk',
                onPressed: _isLoading ? () {} : login,
                isLoading: _isLoading,
              ),

              const SizedBox(height: 16,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Belum punya akun? ",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppTheme.textSecondary,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    },
                    child: Text(
                      "Daftar",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
