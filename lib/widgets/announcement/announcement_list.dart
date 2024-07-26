import 'package:efficient_school/utils/size.dart';
import 'package:efficient_school/widgets/announcement/post_card.dart';
import 'package:flutter/material.dart';

import '../../models/announcement.model.dart';

class AnnouncementList extends StatelessWidget {
  final List<Announcement> announcements;

  const AnnouncementList({super.key, required this.announcements});

  @override
  Widget build(BuildContext context) {
    return announcements.isEmpty
        ? const Center(child: Text("No data found"))
        : ListView.builder(
            padding: EdgeInsets.only(bottom: SizeConfig.height * 0.1),
            itemCount: announcements.length,
            itemBuilder: (context, index) {
              final announcement = announcements[index];
              return PostCard(announcement: announcement);
            },
          );
  }
}
