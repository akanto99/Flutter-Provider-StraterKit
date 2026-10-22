import 'package:flutter/material.dart';
import 'package:flutter_provider_straterkit/configs/res/color.dart';
import 'package:flutter_provider_straterkit/configs/res/text_styles.dart';
import 'package:flutter_provider_straterkit/configs/res/components/exception_errorstate/exception_errorstate.dart';
import 'package:flutter_provider_straterkit/configs/utils/utils.dart';
import 'package:flutter_provider_straterkit/data/response/status.dart';
import 'package:flutter_provider_straterkit/view_model/post_view_model/post_view_model.dart';
import 'package:provider/provider.dart';

class PostDetailScreen extends StatefulWidget {
  final int postId;
  const PostDetailScreen({super.key, required this.postId});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PostViewModel>().fetchPostById(widget.postId);
    });
  }

  Future<void> _deletePost() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.containerBackground(context),
        title: Text(
          'Delete Post',
          style: AppTextStyles.textSize18(context, weight: FontWeight.w600),
        ),
        content: Text(
          'Are you sure you want to delete this post?',
          style: AppTextStyles.textSize14(context),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.subtitle(context)),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text('Delete', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      final success = await context.read<PostViewModel>().deletePost(
        widget.postId,
      );
      if (success && mounted) {
        Utils.flushBarSuccessMessage('Post deleted successfully', context);
        Navigator.pop(context);
      } else if (mounted) {
        Utils.flushBarErrorMessage('Failed to delete post', context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
          'Post Detail',
          style: AppTextStyles.textSize20(context, weight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: AppColors.error),
            onPressed: _deletePost,
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          switch (postViewModel.singlePost.status) {
            case Status.LOADING:
              return Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );

            case Status.ERROR:
              return ExceptionErrorState(
                message: postViewModel.singlePost.message.toString(),
                onRetry: () => postViewModel.fetchPostById(widget.postId),
              );

            case Status.COMPLETED:
              final post = postViewModel.singlePost.data;
              if (post == null) {
                return Center(
                  child: Text(
                    'Post not found',
                    style: AppTextStyles.textSize16(
                      context,
                      color: AppColors.subtitle(context),
                    ),
                  ),
                );
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User Info Card
                    Container(
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
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${post.userId}',
                                style: AppTextStyles.textSize16(
                                  context,
                                  weight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'User ${post.userId}',
                                  style: AppTextStyles.textSize16(
                                    context,
                                    weight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Post #${post.id}',
                                  style: AppTextStyles.textSize12(
                                    context,
                                    color: AppColors.subtitle(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Title
                    Text(
                      'Title',
                      style: AppTextStyles.textSize14(
                        context,
                        weight: FontWeight.w600,
                        color: AppColors.subtitle(context),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.containerBackground(context),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border(context)),
                      ),
                      child: Text(
                        post.title,
                        style: AppTextStyles.textSize18(
                          context,
                          weight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Body
                    Text(
                      'Content',
                      style: AppTextStyles.textSize14(
                        context,
                        weight: FontWeight.w600,
                        color: AppColors.subtitle(context),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.containerBackground(context),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border(context)),
                      ),
                      child: Text(
                        post.body,
                        style: AppTextStyles.textSize16(context),
                      ),
                    ),
                  ],
                ),
              );

            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
