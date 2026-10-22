import 'package:flutter_provider_straterkit/configs/res/color.dart';
import 'package:flutter_provider_straterkit/configs/res/text_styles.dart';
import 'package:flutter_provider_straterkit/configs/services/splash_services/splash_services.dart';
import 'package:flutter_provider_straterkit/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SplashService().navigateAfterDelay(context);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: Stack(
          children: [
            Center(
              child: Container(
                height: screenHeight,
                width: screenWidth * 0.6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // color: Colors.red
                ),
                child: SvgPicture.asset(
                  'assets/images/splash/flutter-logo.svg',
                  height: 160,
                  width: 160,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              child: Container(
                width: screenWidth,
                child: Column(
                  children: [
                    Center(
                      child:
                          // LoadingAnimationWidget.fourRotatingDots(
                          // color: AppColors.button(context),
                          // size: 50,
                          Container(
                            height: 15,
                            width: 50,
                            // color: Colors.red,
                            child: LoadingAnimationWidget.progressiveDots(
                              color: AppColors.button(context),
                              size: 50,
                            ),
                          ),
                    ),
                    Text("Loading", style: AppTextStyles.textSize14(context)),
                    SizedBox(height: 4),
                    Text("Flutter Starter Kit", style: AppTextStyles.textSize14(context, weight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
