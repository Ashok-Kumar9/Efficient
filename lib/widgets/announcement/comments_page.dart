import 'package:efficient_school/utils/constants/comment_constants.dart';
import 'package:efficient_school/utils/reusable_functions.dart';
import 'package:efficient_school/utils/reusable_widgets.dart';
import 'package:efficient_school/utils/shared_prefs.dart';
import 'package:efficient_school/utils/size.dart';
import 'package:efficient_school/utils/style.dart';
import 'package:flutter/material.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({super.key});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final TextEditingController _commentController = TextEditingController();
  bool _isCommenting = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.8,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          decoration: const BoxDecoration(
            color: AppColors.tertiary,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: <Widget>[
              Container(
                width: SizeConfig.width * 0.2,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.only(top: 8, bottom: 8),
              ),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: CommentWidget(),
                    );
                  },
                ),
              ),
              SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0)
                      .copyWith(top: 8),
                  color: AppColors.tertiary,
                  child: Row(
                    children: [
                      ReusableWidgets.buildProfileImage(
                        profileImageUrl:
                            SharedPrefs().getCurrentUser?.profileImage ?? "",
                        userName: SharedPrefs().getCurrentUser?.userName ?? "",
                        size: 42,
                        border: 0,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ReusableWidgets().customTextField(
                          controller: _commentController,
                          hintText: 'Add a comment...',
                        ),
                      ),
                      const SizedBox(width: 10),
                      _isCommenting
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.white,
                                ),
                                strokeWidth: 1,
                              ),
                            )
                          : IconButton(
                              icon: const Icon(Icons.send),
                              color: AppColors.white,
                              onPressed: () async {
                                _commentController.clear();
                                setState(() {
                                  _isCommenting = true;
                                });
                                await Future.delayed(const Duration(seconds: 2),
                                    () {
                                  _isCommenting = false;
                                });
                                if (mounted) {
                                  Navigator.pop(context);
                                }
                              },
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final comment = CommentConstants().comment;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ReusableWidgets.buildProfileImage(
                  profileImageUrl: comment.profileImage,
                  userName: comment.userName,
                  size: 30,
                  border: 0),
              const SizedBox(width: 10),
              Text(
                comment.userName,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(comment.content, style: const TextStyle(color: AppColors.white)),
          const SizedBox(height: 4),
          Text(
            ReusableFunctions.formatDateTimeWithDateAndTime(comment.dateTime),
            style: const TextStyle(color: AppColors.grey),
          ),
        ],
      ),
    );
  }
}
