import 'package:efficient_school/utils/reusable_widgets.dart';
import 'package:efficient_school/utils/style.dart';
import 'package:efficient_school/widgets/announcement/comments_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostFooter extends StatefulWidget {
  final bool isLiked;
  final int likesCount;
  final int commentsCount;
  final String profileImage;
  final String userName;

  const PostFooter({
    super.key,
    required this.isLiked,
    required this.likesCount,
    required this.commentsCount,
    required this.profileImage,
    required this.userName,
  });

  @override
  State<PostFooter> createState() => _PostFooterState();
}

class _PostFooterState extends State<PostFooter> {
  bool isLiked = false;
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    isLiked = widget.isLiked;
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  void toggleBookmark() {
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              ReusableWidgets.buildProfileImage(
                profileImageUrl: widget.profileImage,
                userName: widget.userName,
                size: 24,
                border: 0,
              ),
              const SizedBox(width: 6),
              Text(
                "Liked by ${widget.userName.split(" ").first} & ${widget.likesCount} others",
                style: const TextStyle(color: AppColors.grey, fontSize: 14),
              ),
              const Spacer(),
              Text(
                "${widget.commentsCount} Comments",
                style: const TextStyle(color: AppColors.grey, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              iconButton(
                icon: isLiked
                    ? FontAwesomeIcons.solidThumbsUp
                    : FontAwesomeIcons.thumbsUp,
                isClicked: isLiked,
                onTap: toggleLike,
              ),
              const SizedBox(width: 8),
              iconButton(
                  icon: FontAwesomeIcons.comment,
                  onTap: () async {
                    await showModalBottomSheet(
                      sheetAnimationStyle: AnimationStyle(
                        curve: Curves.bounceInOut,
                        duration: const Duration(milliseconds: 300),
                        reverseCurve: Curves.easeOut,
                        reverseDuration: const Duration(milliseconds: 300),
                      ),
                      useRootNavigator: true,
                      context: context,
                      useSafeArea: true,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: const CommentsPage(),
                        );
                      },
                    );
                  }),
              const SizedBox(width: 8),
              iconButton(icon: FontAwesomeIcons.share),
              const Spacer(),
              iconButton(
                  icon: isBookmarked
                      ? FontAwesomeIcons.solidBookmark
                      : FontAwesomeIcons.bookmark,
                  onTap: toggleBookmark),
            ],
          ),
        ],
      ),
    );
  }

  GestureDetector iconButton(
      {required IconData icon, Function()? onTap, bool isClicked = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: AppColors.tertiary,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Center(
          child: FaIcon(
            icon,
            size: 20,
            color: isClicked ? AppColors.error : AppColors.white,
          ),
        ),
      ),
    );
  }
}
