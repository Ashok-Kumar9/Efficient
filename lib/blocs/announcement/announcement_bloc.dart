import 'package:efficient_school/blocs/announcement/announcement_event.dart';
import 'package:efficient_school/blocs/announcement/announcement_state.dart';
import 'package:efficient_school/models/announcement.model.dart';
import 'package:efficient_school/repositories/announcement_repository.dart';
import 'package:efficient_school/utils/shared_prefs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnnouncementBloc extends Bloc<AnnouncementEvent, AnnouncementState> {
  final AnnouncementRepository announcementRepository;

  AnnouncementBloc(this.announcementRepository) : super(AnnouncementLoading()) {
    on<LoadAnnouncements>((event, emit) async {
      emit(AnnouncementLoading());
      try {
        final announcements = await announcementRepository.getAnnouncements();
        emit(AnnouncementLoaded(announcements));
      } catch (_) {
        emit(AnnouncementError());
      }
    });

    on<AddAnnouncement>((event, emit) async {
      if (state is AnnouncementLoaded) {
        Announcement announcement = Announcement(
          title: event.title,
          description: event.description,
          mediaFiles: event.files,
          createdAt: DateTime.now(),
          userName: SharedPrefs().getCurrentUser?.userName ?? '',
          profileImage: SharedPrefs().getCurrentUser?.profileImage ?? '',
          likeCount: 0,
          commentCount: 0,
        );

        final List<Announcement> updatedAnnouncements = [
          announcement,
          ...(state as AnnouncementLoaded).announcements
        ];
        emit(AnnouncementLoaded(updatedAnnouncements));
        await announcementRepository.addAnnouncement(announcement);
      }
    });

    on<DeleteAnnouncement>((event, emit) async {
      if (state is AnnouncementLoaded) {
        final List<Announcement> updatedAnnouncements =
            (state as AnnouncementLoaded)
                .announcements
                .where((announcement) => announcement.docId != event.docId)
                .toList();
        emit(AnnouncementLoaded(updatedAnnouncements));
        await announcementRepository.deleteAnnouncement(event.docId);
      }
    });
  }
}
