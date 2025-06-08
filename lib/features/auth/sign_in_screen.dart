import 'package:flutter/material.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';
import 'controller/sign_in_controller.dart';
import 'sign_up_screen.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => SignInController(),
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
          child: Consumer<SignInController>(
              builder: (context, provider, _) => SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      Center(child: Image.asset('assets/images/logo.png', height: 60)),
                      const SizedBox(height: 32),
                      const Text(
                        'Welcome to Newst',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF363636),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextFormField(
                              title: 'Email',
                              controller: _emailController,
                              hint: 'usama@usamaelgendy.com',
                            ),
                            const SizedBox(height: 24),
                            CustomTextFormField(
                              title: 'Password',
                              controller: _passwordController,
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
                            const SizedBox(height: 8),
                            if (provider.errorMessage != null) ...[
                              const SizedBox(height: 12),
                              Text(provider.errorMessage!, style: const TextStyle(color: Colors.red)),
                            ],
                            const SizedBox(height: 12),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    provider.errorMessage =
                                    'Password reset is not implemented in demo.';
                                  });
                                },
                                child: const Text(
                                  'Forget Password?',
                                  style: TextStyle(
                                    color: Color(0xFFD32F2F),
                                    fontSize: 16,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: provider.isLoading ? null : () async {
                                  if (!_formKey.currentState!.validate()) return;
                                  bool isSuccess = await provider.signIn();
                                  if (isSuccess) {
                                    if (!mounted) return;
                                    Navigator.of(context).pushReplacementNamed('/main');
                                  }
                                },
                                child:
                                provider.isLoading
                                    ? const CircularProgressIndicator(color: Colors.white)
                                    : const Text('Sign In', style: TextStyle(fontSize: 22)),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an account ? ",
                                  style: TextStyle(fontSize: 16),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (_) => const SignUpScreen()),
                                    );
                                  },
                                  child: const Text(
                                    'Sign Up',
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
