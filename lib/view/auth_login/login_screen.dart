import 'package:flutter/material.dart';
import 'package:flutter_provider_straterkit/configs/res/color.dart';
import 'package:flutter_provider_straterkit/configs/res/text_styles.dart';
import 'package:flutter_provider_straterkit/configs/utils/routes/routes_name.dart';
import 'package:flutter_provider_straterkit/configs/utils/utils.dart';
import 'package:flutter_provider_straterkit/view_model/authview_model/login_logout_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _obscurePassword.dispose();
    super.dispose();
  }

  bool _isValidPhoneNumber(String phone) {
    final cleanPhone = phone.replaceAll(RegExp(r'[^0-9]'), '');
    return cleanPhone.length == 11 && cleanPhone.startsWith('01');
  }

  void _onSignIn(BuildContext context) {
    
    if (_phoneController.text.isEmpty) {
      Utils.flushBarErrorMessage('Please enter phone number', context);
    } else if (!_isValidPhoneNumber(_phoneController.text)) {
      Utils.flushBarErrorMessage(
        'Please enter a valid phone number (01XXXXXXXXX)',
        context,
      );
      return;
    } else if (_passwordController.text.isEmpty) {
      Utils.flushBarErrorMessage('Please enter your password', context);
    } else if (_passwordController.text.length < 6) {
      Utils.flushBarErrorMessage(
        'Password must be at least 6 characters',
        context,
      );
    } else {
      // Skip API call — navigate directly to navigation bar
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesName.navigationBar,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.appBackground(context),
      appBar: AppBar(
        backgroundColor: AppColors.containerBackground(context),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary(context)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Sign In',
          style: AppTextStyles.textSize20(context, weight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.04),

                Text(
                  "Log In",
                  style: AppTextStyles.textSize28(
                    context,
                    weight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  "Please enter your login credentials",
                  style: AppTextStyles.textSize16(
                    context,
                    weight: FontWeight.w400,
                  ),
                ),

                SizedBox(height: screenHeight * 0.04),

                // Input Card
                Container(
                  width: screenWidth * 0.9,
                  padding: EdgeInsets.all(screenHeight * 0.02),
                  decoration: BoxDecoration(
                    color: AppColors.containerBackground(context),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.border(context),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mobile Number',
                        style: AppTextStyles.textSize14(
                          context,
                          weight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        style: AppTextStyles.textSize16(context),
                        decoration: InputDecoration(
                          hintText: '01XXXXXXXXX',
                          hintStyle: AppTextStyles.textSize16(
                            context,
                            color: AppColors.hintColor(context),
                          ),
                          filled: true,
                          fillColor: AppColors.textFieldFill(context),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        'Password',
                        style: AppTextStyles.textSize14(
                          context,
                          weight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      ValueListenableBuilder<bool>(
                        valueListenable: _obscurePassword,
                        builder: (context, obscure, _) {
                          return TextField(
                            controller: _passwordController,
                            obscureText: obscure,
                            style: AppTextStyles.textSize16(context),
                            decoration: InputDecoration(
                              hintText: '••••••',
                              hintStyle: AppTextStyles.textSize16(
                                context,
                                color: AppColors.hintColor(context),
                              ),
                              filled: true,
                              fillColor: AppColors.textFieldFill(context),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: AppColors.subtitle(context),
                                ),
                                onPressed: () =>
                                    _obscurePassword.value = !obscure,
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamed(
                            context,
                            RoutesName.forgotPassword,
                          ),
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontFamily: "poppins",
                              fontSize: 14,
                              color: AppColors.button(context),
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.button(context),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.04),

                // Sign In Button
                Selector<LoginLogoutViewModel, bool>(
                  selector: (_, vm) => vm.loading,
                  builder: (context, loading, _) {
                    return GestureDetector(
                      onTap: loading ? null : () => _onSignIn(context),
                      child: Container(
                        width: screenWidth * 0.9,
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColors.button(context),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: loading
                              ? SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: AppColors.whiteColor,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Sign In',
                                      style: AppTextStyles.textSize16(
                                        context,
                                        weight: FontWeight.w600,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: AppColors.whiteColor,
                                      size: 16,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: screenHeight * 0.03),

                // Register Link
                GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, RoutesName.register),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "New user? ",
                        style: AppTextStyles.textSize16(
                          context,
                          weight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "Register",
                        style: AppTextStyles.textSize16(
                          context,
                          weight: FontWeight.w600,
                          color: AppColors.button(context),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
