import 'package:flutter/material.dart';

import '../../../core/constants/assets.dart';
import '../../../core/routes/page_routes_name.dart';
import '../../../core/theme_manager/color_pallete.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_form_field.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {

    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal:  16.0),
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
              hintText: 'Name',
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
              hintText: 'Email',
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
              hintText: 'Password',
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
            ),
            SizedBox(height: 24),
            CustomButton(
              child: Text('Create Account', style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white)),
              onTap: () {},
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
                  onTap: () => Navigator.pop(context,),
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
      )
    );
  }
}
