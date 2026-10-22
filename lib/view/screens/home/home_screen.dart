import 'package:flutter/material.dart';
import 'package:flutter_provider_straterkit/configs/res/color.dart';
import 'package:flutter_provider_straterkit/configs/res/text_styles.dart';
import 'package:flutter_provider_straterkit/configs/utils/routes/routes_name.dart';
import 'package:flutter_provider_straterkit/view_model/authview_model/login_logout_view_model.dart';
import 'package:flutter_provider_straterkit/view_model/userview_model/userview_model.dart';
import 'package:provider/provider.dart';

/// Home Screen - Main landing page after login
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel = context.watch<UserViewModel>();
    final user = userViewModel.currentUser?.data?.user;

    return Scaffold(
      backgroundColor: AppColors.appBackground(context),
      appBar: AppBar(
        backgroundColor: AppColors.containerBackground(context),
        elevation: 0,
        title: Text(
          'Home',
          style: AppTextStyles.textSize20(context, weight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: AppColors.textPrimary(context)),
            onPressed: () => Navigator.pushNamed(context, RoutesName.profile),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back!',
                    style: AppTextStyles.textSize16(
                      context,
                      color: AppColors.whiteColor,
                      weight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    user?.fullName ?? user?.phone ?? 'User',
                    style: AppTextStyles.textSize24(
                      context,
                      color: AppColors.whiteColor,
                      weight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Phone: ${user?.phone ?? 'N/A'}',
                    style: AppTextStyles.textSize14(
                      context,
                      color: AppColors.whiteColor.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Quick Actions
            Text(
              'Quick Actions',
              style: AppTextStyles.textSize20(context, weight: FontWeight.w600),
            ),
            SizedBox(height: 16),

            _buildActionCard(
              context,
              icon: Icons.list_alt,
              title: 'View Posts',
              subtitle: 'Browse starter posts',
              onTap: () => Navigator.pushNamed(context, RoutesName.postList),
            ),

            SizedBox(height: 12),

            _buildActionCard(
              context,
              icon: Icons.add_circle_outline,
              title: 'Create Post',
              subtitle: 'Create a new post (example)',
              onTap: () => Navigator.pushNamed(context, RoutesName.createPost),
            ),

            SizedBox(height: 12),

            _buildActionCard(
              context,
              icon: Icons.person_outline,
              title: 'My Profile',
              subtitle: 'View and edit your profile',
              onTap: () => Navigator.pushNamed(context, RoutesName.profile),
            ),

            SizedBox(height: 24),

            // Logout Button
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    backgroundColor: AppColors.containerBackground(context),
                    title: Text(
                      'Logout',
                      style: AppTextStyles.textSize18(
                        context,
                        weight: FontWeight.w600,
                      ),
                    ),
                    content: Text(
                      'Are you sure you want to logout?',
                      style: AppTextStyles.textSize14(context),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: AppColors.subtitle(context)),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          context.read<LoginLogoutViewModel>().logoutUser(
                            context,
                          );
                        },
                        child: Text(
                          'Logout',
                          style: TextStyle(color: AppColors.error),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.containerBackground(context),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.error, width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: AppColors.error, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Logout',
                      style: AppTextStyles.textSize16(
                        context,
                        weight: FontWeight.w600,
                        color: AppColors.error,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.containerBackground(context),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border(context)),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.primary, size: 24),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.textSize16(
                      context,
                      weight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: AppTextStyles.textSize12(
                      context,
                      color: AppColors.subtitle(context),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: AppColors.subtitle(context)),
          ],
        ),
      ),
    );
  }
}
