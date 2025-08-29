import 'package:event_app/core/routes/page_routes_name.dart';
import 'package:event_app/core/theme_manager/color_pallete.dart';
import 'package:event_app/core/utils/firebase_authentication_utils.dart';
import 'package:event_app/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../core/constants/assets.dart';
import '../../../core/widgets/custom_button.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(Assets.eventLogo, height: 185),
              SizedBox(height: 24),
              CustomTextFormField(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ImageIcon(
                    AssetImage(Assets.mailIcon),
                    color: AppColors.textFieldBorderColor,
                  ),
                ),
                hintText: 'Email',
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              CustomTextFormField(
                isPassword: true,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ImageIcon(
                    AssetImage(Assets.passwordIcon),
                    color: AppColors.textFieldBorderColor,
                  ),
                ),
                hintText: 'Password',
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your password";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, PageRoutesName.forgetPassword);
                  },
                  child: Text(
                    'Forget Password?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primaryColor,
                      decorationThickness: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              CustomButton(
                child: Text(
                  'Login',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    EasyLoading.show;
                    FirebaseAuthenticationUtils.signInWithEmailAndPassword(
                      emailAddress: _emailController.text,
                      password: _passwordController.text,
                    ).then((value) {
                      EasyLoading.dismiss();
                      if (value) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          PageRoutesName.layout,
                          (route) => false,
                        );
                      }
                    });
                  }
                  Navigator.pushNamed(context, PageRoutesName.layout);
                },
              ),
              SizedBox(height: 24),
              Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t Have Account ?",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, PageRoutesName.register),
                    child: Text(
                      " Create Account",
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
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(child: Divider(color: AppColors.primaryColor)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'Or',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: AppColors.primaryColor)),
                ],
              ),
              SizedBox(height: 24),
              CustomButton(
                backgroundColor: Colors.transparent,
                onTap: () {},
                child: Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Assets.googleIcon, height: 26),
                    Text(
                      "Login With Google",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
