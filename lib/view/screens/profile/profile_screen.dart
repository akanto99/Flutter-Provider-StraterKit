import 'package:flutter/material.dart';
import 'package:flutter_provider_straterkit/configs/res/color.dart';
import 'package:flutter_provider_straterkit/configs/res/text_styles.dart';
import 'package:flutter_provider_straterkit/view_model/authview_model/login_logout_view_model.dart';
import 'package:flutter_provider_straterkit/view_model/userview_model/userview_model.dart';
import 'package:flutter_provider_straterkit/theme/theme_provider.dart';
import 'package:provider/provider.dart';

/// Profile Screen - User profile and settings
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel = context.watch<UserViewModel>();
    final themeProvider = context.watch<ThemeProvider>();
    final user = userViewModel.currentUser?.data?.user;

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
          'Profile',
          style: AppTextStyles.textSize20(context, weight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.containerBackground(context),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border(context)),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                    child: user?.profilePicture?.url != null
                        ? ClipOval(
                            child: Image.network(
                              user!.profilePicture!.url!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Icon(
                                Icons.person,
                                size: 50,
                                color: AppColors.primary,
                              ),
                            ),
                          )
                        : Icon(
                            Icons.person,
                            size: 50,
                            color: AppColors.primary,
                          ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    user?.fullName ?? user?.phone ?? 'User',
                    style: AppTextStyles.textSize24(
                      context,
                      weight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    user?.phone ?? 'N/A',
                    style: AppTextStyles.textSize14(
                      context,
                      color: AppColors.subtitle(context),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      user?.role?.toUpperCase() ?? 'USER',
                      style: AppTextStyles.textSize12(
                        context,
                        weight: FontWeight.w600,
                        color: AppColors.success,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Settings Section
            Text(
              'Settings',
              style: AppTextStyles.textSize18(context, weight: FontWeight.w600),
            ),
            SizedBox(height: 12),

            // Dark Mode Toggle
            _buildSettingTile(
              context,
              icon: Icons.dark_mode_outlined,
              title: 'Dark Mode',
              trailing: Switch(
                value: themeProvider.isDarkMode,
                onChanged: (value) => themeProvider.toggleTheme(value),
                activeColor: AppColors.primary,
              ),
            ),

            SizedBox(height: 12),

            // Profile Info
            _buildInfoTile(
              context,
              icon: Icons.phone,
              label: 'Phone',
              value: user?.phone ?? 'N/A',
            ),
            SizedBox(height: 8),
            _buildInfoTile(
              context,
              icon: Icons.badge_outlined,
              label: 'User ID',
              value: user?.userId ?? 'N/A',
            ),
            SizedBox(height: 8),
            _buildInfoTile(
              context,
              icon: Icons.verified_user_outlined,
              label: 'Status',
              value: user?.userStatus ?? 'Active',
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
                  color: AppColors.error.withValues(alpha: 0.1),
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

  Widget _buildSettingTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Widget trailing,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.containerBackground(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border(context)),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textPrimary(context), size: 24),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.textSize16(context, weight: FontWeight.w500),
            ),
          ),
          trailing,
        ],
      ),
    );
  }

  Widget _buildInfoTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.containerBackground(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border(context)),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 24),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.textSize12(
                    context,
                    color: AppColors.subtitle(context),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: AppTextStyles.textSize14(
                    context,
                    weight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
