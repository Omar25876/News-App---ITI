import 'package:flutter/material.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';
import 'package:news_app/features/auth/controller/sign_up_controller.dart';
import 'package:provider/provider.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => SignUpController(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/auth_background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Consumer<SignUpController>(
            builder: (context, provider, _) =>
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 60),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                        Image.asset('assets/images/logo.png', height: 60),
                        const SizedBox(height: 32),
                        const Text(
                          'Welcome to Newst',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextFormField(
                                title: 'Email',
                                controller: provider.emailController,
                                hint: 'usama@usamaelgendy.com',
                              ),
                              const SizedBox(height: 24),
                              CustomTextFormField(
                                title: 'Password',
                                controller: provider.passwordController,
                                obscureText: provider.obscurePassword,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    provider.obscurePassword ? Icons.visibility_off : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    provider.togglePasswordVisibility();
                                  },
                                ),
                                hint: '*************',
                              ),
                              const SizedBox(height: 24),
                              CustomTextFormField(
                                title: 'Confirm Password',
                                controller:  provider.confirmPasswordController,
                                obscureText: provider.obscureConfirmPassword,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    provider.obscureConfirmPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    provider.toggleConfirmPasswordVisibility();
                                  },
                                ),
                                hint: '*************',
                              ),

                              if (provider.errorMessage != null) ...[
                                const SizedBox(height: 12),
                                Text(provider.errorMessage!, style: const TextStyle(color: Colors.red)),
                              ],
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFD32F2F),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  onPressed: provider.isLoading ? null : () async {
                                    if (!_formKey.currentState!.validate()) return;
                                    bool isSuccess = await provider.signUp();
                                    if (isSuccess) {
                                      if (!mounted) return;
                                      Navigator.of(context).pushReplacementNamed('/main');
                                    }
                                  },
                                  child:
                                  provider.isLoading
                                      ? const CircularProgressIndicator(color: Colors.white)
                                      : const Text('Sign Up', style: TextStyle(fontSize: 22)),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Have an account ? ',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'Sign In',
                                      style: TextStyle(
                                        color: Color(0xFFD32F2F),
                                        fontSize: 16,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
