import 'dart:io';

import 'package:efficient_school/blocs/announcement/announcement_bloc.dart';
import 'package:efficient_school/blocs/announcement/announcement_event.dart';
import 'package:efficient_school/repositories/user_repository.dart';
import 'package:efficient_school/services/file_picker.dart';
import 'package:efficient_school/services/user_notifier.dart';
import 'package:efficient_school/utils/media/raw_video_widget.dart';
import 'package:efficient_school/utils/size.dart';
import 'package:efficient_school/utils/style.dart';
import 'package:efficient_school/widgets/create_announcement/add_file_button.dart';
import 'package:efficient_school/widgets/create_announcement/user_dropdown.dart';
import 'package:efficient_school/widgets/create_user/create_user_popup.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../services/upload_files.dart';
import '../utils/reusable_widgets.dart';

class CreateAnnouncementScreen extends StatefulWidget {
  const CreateAnnouncementScreen({super.key});

  @override
  State<CreateAnnouncementScreen> createState() =>
      _CreateAnnouncementScreenState();
}

class _CreateAnnouncementScreenState extends State<CreateAnnouncementScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  List<PlatformFile> _pickedFiles = [];
  bool _isPostCreating = false;

  Future<void> _pickFiles() async {
    List<PlatformFile>? files = await pickFiles();
    if (files != null) {
      setState(() {
        _pickedFiles = [...files, ..._pickedFiles];
      });
    }
  }

  void _createAnnouncement() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    FocusScope.of(context).unfocus();

    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Title, description, and user name are required')),
      );
      return;
    }

    setState(() {
      _isPostCreating = true;
    });

    List<String> uploadedFileUrls = await uploadFiles(_pickedFiles);

    if (mounted) {
      BlocProvider.of<AnnouncementBloc>(context).add(AddAnnouncement(
        title: _titleController.text,
        description: _descriptionController.text,
        files: uploadedFileUrls,
      ));
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  UserRepository userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0,
        title: const Text('Create Announcement',
            style: TextStyle(color: AppColors.white)),
        actions: [
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.userPlus,
              color: AppColors.white,
              size: 18,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const CreateUserPopup();
                },
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const UserInfoSection(),
                const SizedBox(height: 12),
                ReusableWidgets().customTextField(
                  controller: _titleController,
                  hintText: 'Enter title of the post',
                ),
                const SizedBox(height: 12),
                ReusableWidgets().customTextField(
                  controller: _descriptionController,
                  hintText: 'Enter description of the post',
                  minLines: 4,
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AddFileButton(onPressed: _pickFiles),
                    const SizedBox(width: 8),
                    Flexible(
                      child: SizedBox(
                        height: SizeConfig.width * 0.25,
                        width: SizeConfig.width,
                        child: ListView.builder(
                          itemCount: _pickedFiles.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final file = _pickedFiles[index];
                            return Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  height: SizeConfig.height * 0.16,
                                  width: SizeConfig.height * 0.12,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: (file.path ?? "").contains("mp4")
                                        ? VideoPreviewRaw(
                                            filePath: file.path!,
                                          )
                                        : Image.file(File(file.path!),
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    const Text(
                                                        'Error loading image')),
                                  ),
                                ),
                                Positioned(
                                  right: 2,
                                  bottom: 2,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _pickedFiles.removeAt(index);
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(
                                        color: AppColors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.delete,
                                        color: AppColors.error,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: ReusableWidgets().customButton(
        title: 'Create Announcement',
        onTap: _isPostCreating ? null : _createAnnouncement,
        isLoading: _isPostCreating,
      ),
    );
  }
}

class UserInfoSection extends StatelessWidget {
  const UserInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          ReusableWidgets.buildProfileImage(
            profileImageUrl:
                Provider.of<UserNotifier>(context).user?.profileImage ?? '',
          ),
          const SizedBox(width: 12),
          Text(
            Provider.of<UserNotifier>(context).user?.userName ?? '',
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          const UserDropdown(),
        ],
      ),
    );
  }
}
