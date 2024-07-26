import 'dart:math';

import 'package:efficient_school/models/announcement.model.dart';
import 'package:efficient_school/utils/constants/comment_constants.dart';
import 'package:efficient_school/utils/style.dart';
import 'package:efficient_school/widgets/announcement/post_bottom_widget.dart';
import 'package:efficient_school/widgets/announcement/post_footer.dart';
import 'package:efficient_school/widgets/announcement/post_header.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class PostCard extends StatelessWidget {
  final Announcement announcement;
  const PostCard({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        color: AppColors.secondary,
        border: Border(
          bottom: BorderSide(color: Colors.black, width: 1.5),
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostHeading(
            docId: announcement.docId ?? "",
            userName: announcement.userName,
            date: announcement.createdAt,
            profileImage: announcement.profileImage == ""
                ? "https://www.pngkey.com/png/full/114-1149878_setting-user-avatar-in-specific-size-without-breaking.png"
                : announcement.profileImage,
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              announcement.title ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 18,
                color: AppColors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 8),
            child: ReadMoreText(
              (announcement.description ?? '').trim(),
              style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  height: 1.5,
                  fontWeight: FontWeight.w300),
              textAlign: TextAlign.start,
              trimLines: 3,
              trimMode: TrimMode.Line,
              trimExpandedText: '\nShow less',
              moreStyle:
                  const TextStyle(color: AppColors.highlight, fontSize: 14),
              lessStyle:
                  const TextStyle(color: AppColors.highlight, fontSize: 14),
            ),
          ),
          const SizedBox(height: 4),
          PostBottomWidgetWithMedia(
            key: ValueKey<int>(Random().nextInt(100)),
            mediaFiles: announcement.mediaFiles,
          ),
          PostFooter(
            isLiked: Random().nextBool(),
            likesCount: announcement.likeCount + Random().nextInt(1000) + 10,
            commentsCount:
                announcement.commentCount + Random().nextInt(100) + 5,
            profileImage: CommentConstants().randomImageUrl,
            userName: CommentConstants().randomUsername,
          ),
        ],
      ),
    );
  }
}
