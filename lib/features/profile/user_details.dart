import 'package:flutter/material.dart';
import 'package:news_app/features/profile/user_controller.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/custom_text_form_field.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({
    super.key,
    required this.userName,
    required this.email,
    required this.pass,
  });

  final String userName;
  final String? email;
  final String? pass;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late final TextEditingController userNameController;
  late final TextEditingController emailController;
  late final TextEditingController passController;

  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController(text: widget.userName);
    emailController = TextEditingController(text: widget.email);
    passController = TextEditingController(text: widget.pass);
  }

  @override
  Widget build(BuildContext context) {
    final userController = context.read<UserController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _key,
            child: Column(
              children: [
                CustomTextFormField(
                  controller: userNameController,
                  hint: 'Usama Elgendy',
                  title: "User Name",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Enter User Name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: emailController,
                  hint: 'mMx5m@example.com',
                  title: "Email",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Enter Email";
                    }
                    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
                    if (!emailRegex.hasMatch(value)) {
                      return "Enter a valid email";
                    }
                    return null;
                  },

                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: passController,
                  hint: '**********',
                  title: "Password",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Enter Password";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    await Future.delayed(const Duration(milliseconds: 200));
                    if (_key.currentState!.validate()) {
                      try {
                        await userController.updateUserData(
                          username: userNameController.text.trim(),
                          email: emailController.text.trim(),
                          pass: passController.text.trim(),
                        );
                        Navigator.pop(context, true);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width, 40),
                  ),
                  child: const Text('Save Changes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
