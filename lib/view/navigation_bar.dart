import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_provider_straterkit/configs/res/text_styles.dart';
import 'package:flutter_provider_straterkit/view/screens/home/home_screen.dart';
import 'package:flutter_provider_straterkit/view/screens/explore/explore_screen.dart';
import 'package:flutter_provider_straterkit/view/screens/notifications/notifications_screen.dart';
import 'package:flutter_provider_straterkit/view/screens/profile/profile_screen.dart';

import '../theme/app_colors_extension.dart';

class NavigationScreen extends StatefulWidget {
  final int initialIndex;
  const NavigationScreen({super.key, this.initialIndex = 0});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;
  late final List<Widget> _pages;
  late final List<String> _labels;
  late final List<IconData> _icons;
  late final List<IconData> _iconsOutlined;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pages = [const HomeScreen(), const ExploreScreen(), const NotificationsScreen(), const ProfileScreen()];
    _labels = ['Home', 'Explore', 'Notifications', 'Profile'];
    _icons = [Icons.home, Icons.explore, Icons.notifications, Icons.person];
    _iconsOutlined = [Icons.home_outlined, Icons.explore_outlined, Icons.notifications_outlined, Icons.person_outline];
  }

  DateTime? _lastBackPressed;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final now = DateTime.now();
        final isDoubleBack = _lastBackPressed != null && now.difference(_lastBackPressed!) < const Duration(seconds: 2);

        if (isDoubleBack) {
          SystemNavigator.pop();
        } else {
          _lastBackPressed = now;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(
                child: Text('Double tap to exit', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
              ),
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              backgroundColor: context.colors.containerBackground,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: _pages[_currentIndex],
        bottomNavigationBar: SafeArea(
          child: Container(
            height: 65,
            decoration: BoxDecoration(
              color: context.colors.containerBackground,
              boxShadow: [BoxShadow(color: Colors.black12.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -2))],
            ),
            child: Column(
              children: [
                Divider(color: context.colors.border, height: 1),
                Expanded(
                  child: Row(
                    children: List.generate(_icons.length, (index) {
                      final bool isSelected = _currentIndex == index;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _currentIndex = index),
                          child: Container(
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(isSelected ? _icons[index] : _iconsOutlined[index], size: 24, color: isSelected ? Theme.of(context).colorScheme.primary : context.colors.subtitle),
                                const SizedBox(height: 4),
                                Text(
                                  _labels[index],
                                  style: AppTextStyles.textSize11(
                                    context,
                                    weight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                    color: isSelected ? Theme.of(context).colorScheme.primary : context.colors.subtitle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
