import 'package:appbutawarna/core/theme/app_theme.dart';
import 'package:appbutawarna/services/auth_service.dart';
import 'package:appbutawarna/core/utils/snackbar_helper.dart';
import 'package:appbutawarna/widgets/primary_button.dart';
import 'package:appbutawarna/widgets/text_form_field.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final AuthService _authService = AuthService();

  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  Future<void> register() async {
    // Validasi input
    if (fullNameController.text.trim().isEmpty) {
      SnackBarHelper.showError(context, "Nama lengkap tidak boleh kosong");
      return;
    }

    if (emailController.text.trim().isEmpty) {
      SnackBarHelper.showError(context, "Email tidak boleh kosong");
      return;
    }

    if (!isValidEmail(emailController.text.trim())) {
      SnackBarHelper.showError(context, "Format email tidak valid");
      return;
    }

    if (passwordController.text.trim().isEmpty) {
      SnackBarHelper.showError(context, "Password tidak boleh kosong");
      return;
    }
    if (confirmPasswordController.text.trim().isEmpty) {
      SnackBarHelper.showError(context, "Konfirmasi password tidak boleh kosong");
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      SnackBarHelper.showError(context, "Password tidak cocok");
      return;
    }
    if (passwordController.text.length < 6) {
      SnackBarHelper.showError(context, "Password minimal 6 karakter");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final result = await _authService.createAccount(
      fullName: fullNameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (!mounted) return;

    if (result.success) {
      SnackBarHelper.showSuccess(context, result.message);

      // Kembali ke halaman login setelah berhasil register
      Navigator.pop(context);
    } else {
      SnackBarHelper.showError(context, result.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              Text(
                "Halo,",
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                "Selamat Datang!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 48),

              // Nama lengkap Label
              Text(
                'Nama Lengkap',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textSecondary,
                ),
              ),

              const SizedBox(height: 8),

              // Nama lengkap TextField
              CustomTextField(
                controller: fullNameController,
                hintText: 'Ketikkan nama lengkap anda...',
                keyboardType: TextInputType.emailAddress,
                enabled: !_isLoading,
              ),

              const SizedBox(height: 8),

              // Email Label
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textSecondary,
                ),
              ),

              const SizedBox(height: 8),

              // Email TextField
              CustomTextField(
                controller: emailController,
                hintText: 'Ketikkan email anda...',
                keyboardType: TextInputType.emailAddress,
                enabled: !_isLoading,
              ),

              const SizedBox(height: 24),

              // Password Label
              Text(
                'Password',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textSecondary,
                ),
              ),

              const SizedBox(height: 8),

              // Password TextField
              CustomTextField(
                controller: passwordController,
                hintText: 'Ketikkan password anda...',
                obscureText: true,
                enabled: !_isLoading,
              ),

              const SizedBox(height: 24),

              // Konfirmasi Password Label
              Text(
                'Konfirmasi Password',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textSecondary,
                ),
              ),

              const SizedBox(height: 8),

              // Konfirmasi Password TextField
              CustomTextField(
                controller: confirmPasswordController,
                hintText: 'Ketikkan ulang password anda...',
                obscureText: true,
                enabled: !_isLoading,
              ),

              const SizedBox(height: 42),

              // Register Button
              PrimaryButton(
                text: _isLoading ? 'Memproses...' : 'Daftar',
                onPressed: _isLoading ? () {} : register,
                isLoading: _isLoading,
              ),

              const SizedBox(height: 16),

              // Link ke halaman login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sudah punya akun? ",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  GestureDetector(
                    onTap: _isLoading
                        ? null
                        : () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Masuk",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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