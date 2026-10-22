import 'package:flutter/material.dart';
import 'package:flutter_provider_straterkit/configs/res/color.dart';
import 'package:flutter_provider_straterkit/configs/res/text_styles.dart';
import 'package:flutter_provider_straterkit/configs/res/components/exception_errorstate/exception_errorstate.dart';
import 'package:flutter_provider_straterkit/configs/utils/routes/routes_name.dart';
import 'package:flutter_provider_straterkit/data/response/status.dart';
import 'package:flutter_provider_straterkit/view_model/post_view_model/post_view_model.dart';
import 'package:provider/provider.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PostViewModel>().fetchAllPosts();
    });
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
          'Posts',
          style: AppTextStyles.textSize20(context, weight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: AppColors.textPrimary(context)),
            onPressed: () =>
                Navigator.pushNamed(context, RoutesName.createPost),
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          switch (postViewModel.postList.status) {
            case Status.LOADING:
              return Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );

            case Status.ERROR:
              return ExceptionErrorState(
                message: postViewModel.postList.message.toString(),
                onRetry: () => postViewModel.fetchAllPosts(),
              );

            case Status.COMPLETED:
              final posts = postViewModel.postList.data ?? [];
              if (posts.isEmpty) {
                return Center(
                  child: Text(
                    'No posts found',
                    style: AppTextStyles.textSize16(
                      context,
                      color: AppColors.subtitle(context),
                    ),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () => postViewModel.fetchAllPosts(),
                color: AppColors.primary,
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        RoutesName.postDetail,
                        arguments: post.id,
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.containerBackground(context),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border(context)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withValues(
                                      alpha: 0.1,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${post.userId}',
                                      style: AppTextStyles.textSize12(
                                        context,
                                        weight: FontWeight.w600,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'User ${post.userId}',
                                    style: AppTextStyles.textSize12(
                                      context,
                                      color: AppColors.subtitle(context),
                                    ),
                                  ),
                                ),
                                Text(
                                  '#${post.id}',
                                  style: AppTextStyles.textSize12(
                                    context,
                                    color: AppColors.subtitle(context),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              post.title,
                              style: AppTextStyles.textSize16(
                                context,
                                weight: FontWeight.w600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              post.body,
                              style: AppTextStyles.textSize14(
                                context,
                                color: AppColors.subtitle(context),
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
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
