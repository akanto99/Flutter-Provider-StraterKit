import 'package:flutter/material.dart';
import 'package:flutter_provider_straterkit/configs/res/color.dart';
import 'package:flutter_provider_straterkit/configs/res/text_styles.dart';
import 'package:flutter_provider_straterkit/configs/utils/utils.dart';
import 'package:flutter_provider_straterkit/model/post/post_model.dart';
import 'package:flutter_provider_straterkit/view_model/post_view_model/post_view_model.dart';
import 'package:provider/provider.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController(
    text: '1',
  );

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    _userIdController.dispose();
    super.dispose();
  }

  Future<void> _createPost() async {
    if (_titleController.text.isEmpty) {
      Utils.flushBarErrorMessage('Please enter title', context);
      return;
    }
    if (_bodyController.text.isEmpty) {
      Utils.flushBarErrorMessage('Please enter content', context);
      return;
    }

    final post = PostModel(
      userId: int.tryParse(_userIdController.text) ?? 1,
      title: _titleController.text,
      body: _bodyController.text,
    );

    final success = await context.read<PostViewModel>().createPost(post);
    if (success && mounted) {
      Utils.flushBarSuccessMessage('Post created successfully', context);
      Navigator.pop(context);
    } else if (mounted) {
      Utils.flushBarErrorMessage('Failed to create post', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final postViewModel = context.watch<PostViewModel>();

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
          'Create Post',
          style: AppTextStyles.textSize20(context, weight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create a new post',
              style: AppTextStyles.textSize24(context, weight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Fill in the details below',
              style: AppTextStyles.textSize14(
                context,
                color: AppColors.subtitle(context),
              ),
            ),

            const SizedBox(height: 24),

            // User ID Field
            Text(
              'User ID',
              style: AppTextStyles.textSize14(context, weight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _userIdController,
              keyboardType: TextInputType.number,
              style: AppTextStyles.textSize16(context),
              decoration: InputDecoration(
                hintText: 'Enter user ID',
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

            const SizedBox(height: 16),

            // Title Field
            Text(
              'Title',
              style: AppTextStyles.textSize14(context, weight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _titleController,
              style: AppTextStyles.textSize16(context),
              decoration: InputDecoration(
                hintText: 'Enter post title',
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

            const SizedBox(height: 16),

            // Body Field
            Text(
              'Content',
              style: AppTextStyles.textSize14(context, weight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _bodyController,
              maxLines: 8,
              style: AppTextStyles.textSize16(context),
              decoration: InputDecoration(
                hintText: 'Enter post content',
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

            const SizedBox(height: 24),

            // Create Button
            GestureDetector(
              onTap: postViewModel.loading ? null : _createPost,
              child: Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.button(context),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: postViewModel.loading
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: AppColors.whiteColor,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          'Create Post',
                          style: AppTextStyles.textSize16(
                            context,
                            weight: FontWeight.w600,
                            color: AppColors.whiteColor,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
