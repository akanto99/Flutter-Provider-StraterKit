import 'package:flutter/material.dart';
import 'package:flutter_provider_straterkit/configs/res/color.dart';
import 'package:flutter_provider_straterkit/configs/res/text_styles.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground(context),
      appBar: AppBar(
        backgroundColor: AppColors.containerBackground(context),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary(context)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Register',
          style: AppTextStyles.textSize20(context, weight: FontWeight.w600),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person_add, size: 80, color: AppColors.primary),
              SizedBox(height: 20),
              Text(
                'Register Screen',
                style: AppTextStyles.textSize24(
                  context,
                  weight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Implement your registration logic here',
                style: AppTextStyles.textSize14(
                  context,
                  color: AppColors.subtitle(context),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
