import 'package:flutter/material.dart';

import '../../../core/constants/assets.dart';
import '../../../core/theme_manager/color_pallete.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_form_field.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget Password'),
      ),
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(Assets.resetPasswordImg, height: MediaQuery.of(context).size.width* 0.8),
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
          CustomButton(
            child: Text('Reset Password', style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white)),
            onTap: () {},
          ),
        ],
      ),
      )
    );
  }
}
