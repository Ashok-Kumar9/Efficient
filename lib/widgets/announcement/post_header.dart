import 'package:efficient_school/blocs/announcement/announcement_bloc.dart';
import 'package:efficient_school/blocs/announcement/announcement_event.dart';
import 'package:efficient_school/utils/reusable_functions.dart';
import 'package:efficient_school/utils/reusable_widgets.dart';
import 'package:efficient_school/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostHeading extends StatelessWidget {
  final String docId;
  final String profileImage;
  final String userName;
  final DateTime date;

  const PostHeading({
    super.key,
    required this.docId,
    required this.profileImage,
    required this.userName,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ReusableWidgets.buildProfileImage(
              profileImageUrl: profileImage, userName: userName),
          const SizedBox(width: 10),
          Text(
            userName,
            style: const TextStyle(
              fontSize: 18,
              color: AppColors.white,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            ReusableFunctions.timeAgo(date),
            style: const TextStyle(color: AppColors.grey, fontSize: 14),
          ),
          const Spacer(),
          PopupMenuButton(
            icon:
                const FaIcon(FontAwesomeIcons.ellipsis, color: AppColors.grey),
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {
                  context.read<AnnouncementBloc>().add(
                        DeleteAnnouncement(docId: docId),
                      );
                },
                child: const Row(
                  children: [
                    FaIcon(FontAwesomeIcons.trash, color: AppColors.error),
                    SizedBox(width: 10),
                    Text("Delete"),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
