import 'package:flutter/material.dart';
import 'package:flutter_provider_straterkit/configs/res/color.dart';
import 'package:flutter_provider_straterkit/configs/res/text_styles.dart';
import 'package:flutter_provider_straterkit/configs/utils/routes/routes_name.dart';

class WelcomeLoginScreen extends StatelessWidget {
  const WelcomeLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: AppColors.appBackground(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // App Logo/Icon
              Icon(Icons.flutter_dash, size: 120, color: AppColors.primary),

              SizedBox(height: screenHeight * 0.03),

              Text('Welcome to', style: AppTextStyles.textSize20(context, weight: FontWeight.w500)),

              SizedBox(height: screenHeight * 0.01),

              Text(
                'Flutter Provider Starter Kit',
                style: AppTextStyles.textSize28(context, weight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: screenHeight * 0.02),

              Text(
                'A clean, reusable Provider + MVVM + Repository pattern starter kit',
                style: AppTextStyles.textSize14(context, color: AppColors.subtitle(context)),
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              // Login Button
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, RoutesName.login),
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(color: AppColors.button(context), borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Text(
                      'Sign In',
                      style: AppTextStyles.textSize16(context, weight: FontWeight.w600, color: AppColors.whiteColor),
                    ),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.02),

              // Register Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? ", style: AppTextStyles.textSize14(context)),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, RoutesName.register),
                    child: Text(
                      "Sign Up",
                      style: AppTextStyles.textSize14(context, weight: FontWeight.w600, color: AppColors.button(context)),
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
