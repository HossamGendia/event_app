import 'package:event_app/core/utils/firebase_authentication_utils.dart';
import 'package:event_app/core/utils/firebase_firestore_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../core/constants/assets.dart';
import '../../../core/routes/page_routes_name.dart';
import '../../../core/theme_manager/color_pallete.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_form_field.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(Assets.eventLogo, height: 185),
              SizedBox(height: 24),
              CustomTextFormField(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ImageIcon(
                    AssetImage(Assets.personIcon),
                    color: AppColors.textFieldBorderColor,
                  ),
                ),
                controller: _nameController,
                hintText: 'Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your name";
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              CustomTextFormField(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ImageIcon(
                    AssetImage(Assets.mailIcon),
                    color: AppColors.textFieldBorderColor,
                  ),
                ),
                controller: _emailController,
                hintText: 'Email',
                validator: (value) {
                  final RegExp emailRegExp = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  }
                  if (!emailRegExp.hasMatch(value)) {
                    return "Please enter a valid email address";
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              CustomTextFormField(
                isPassword: true,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ImageIcon(
                    AssetImage(Assets.passwordIcon),
                    color: AppColors.textFieldBorderColor,
                  ),
                ),
                controller: _passwordController,
                hintText: 'Password',
                validator: (value) {
                  final RegExp passwordRegExp = RegExp(
                    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$',
                  );
                  if (value == null || value.isEmpty) {
                    return "Please enter your password";
                  }
                  if (!passwordRegExp.hasMatch(value)) {
                    return "Please enter a valid password";
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              CustomTextFormField(
                isPassword: true,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ImageIcon(
                    AssetImage(Assets.passwordIcon),
                    color: AppColors.textFieldBorderColor,
                  ),
                ),
                hintText: 'Re Password',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your password";
                  }
                  if (value != _passwordController.text) {
                    return "Password does not match";
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              CustomButton(
                child: Text(
                  'Create Account',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    EasyLoading.show();
                    FirebaseAuthenticationUtils.createUserWithEmailAndPassword(
                      emailAddress: _emailController.text,
                      password: _passwordController.text,
                    ).then((value){
                      EasyLoading.dismiss();
                      if(value){
                        Navigator.pop(context);
                      }
                    });
                  }
                },
              ),
              SizedBox(height: 24),
              Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already Have Account ?",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      " Login",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.primaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primaryColor,
                        decorationThickness: 2,
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
