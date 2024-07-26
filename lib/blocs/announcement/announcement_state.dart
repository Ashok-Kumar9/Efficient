import 'package:efficient_school/models/announcement.model.dart';
import 'package:equatable/equatable.dart';

abstract class AnnouncementState extends Equatable {
  const AnnouncementState();

  @override
  List<Object?> get props => [];
}

class AnnouncementLoading extends AnnouncementState {}

class AnnouncementLoaded extends AnnouncementState {
  final List<Announcement> announcements;

  const AnnouncementLoaded(this.announcements);

  @override
  List<Object?> get props => [announcements];
}

class AnnouncementError extends AnnouncementState {}
