import 'package:equatable/equatable.dart';

abstract class AnnouncementEvent extends Equatable {
  const AnnouncementEvent();

  @override
  List<Object?> get props => [];
}

class LoadAnnouncements extends AnnouncementEvent {}

class AddAnnouncement extends AnnouncementEvent {
  final List<String> files;
  final String title;
  final String description;

  const AddAnnouncement({
    required this.files,
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [title, description, files];
}

class DeleteAnnouncement extends AnnouncementEvent {
  final String docId;

  const DeleteAnnouncement({required this.docId});
}
