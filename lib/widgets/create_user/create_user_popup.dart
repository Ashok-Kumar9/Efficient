import 'package:efficient_school/repositories/user_repository.dart';
import 'package:efficient_school/services/file_picker.dart';
import 'package:efficient_school/services/user_notifier.dart';
import 'package:efficient_school/utils/reusable_functions.dart';
import 'package:efficient_school/utils/reusable_widgets.dart';
import 'package:efficient_school/utils/shared_prefs.dart';
import 'package:efficient_school/utils/style.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../models/user.model.dart';
import '../../services/upload_media_files.dart';

class CreateUserPopup extends StatefulWidget {
  const CreateUserPopup({super.key});

  @override
  State<CreateUserPopup> createState() => _CreateUserPopupState();
}

class _CreateUserPopupState extends State<CreateUserPopup> {
  final TextEditingController _userNameController = TextEditingController();
  PlatformFile? _profileImage;
  String? _profileImageUrl;
  bool _isUploading = false;

  Future<void> _createUser() async {
    if (_userNameController.text.isEmpty || _profileImage == null) {
      ReusableFunctions().showToast("User name and profile image are required");
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() {
      _isUploading = true;
    });

    if (_profileImage != null) {
      _profileImageUrl = await uploadFiles([_profileImage!]).then((value) {
        return value.first;
      });
    }

    try {
      User newUser = User(
        userName: _userNameController.text,
        profileImage: _profileImageUrl ?? '',
      );
      await UserRepository().addUser(newUser);
      SharedPrefs().setCurrentUser = newUser;
      Provider.of<UserNotifier>(context, listen: false).updateUser();
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      setState(() {
        _isUploading = false;
      });
      ReusableFunctions().showToast("Failed to create user");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.black.withOpacity(0.6),
      child: AlertDialog(
        title: Row(
          children: [
            const Text('Create User',
                style: TextStyle(
                    color: AppColors.white, fontWeight: FontWeight.w300)),
            const Spacer(),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const FaIcon(
                FontAwesomeIcons.xmark,
                color: AppColors.white,
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.primary,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () async {
                if (_isUploading) return;
                _profileImage = await pickFile();
                setState(() {});
              },
              child: _profileImage == null
                  ? Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppColors.tertiary,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: const Icon(
                        Icons.add_a_photo_outlined,
                        color: AppColors.white,
                        size: 36,
                      ),
                    )
                  : ReusableWidgets.buildImageLocal(
                      imagePath: _profileImage!.path!,
                      size: 100,
                    ),
            ),
            const SizedBox(height: 16),
            ReusableWidgets().customTextField(
              controller: _userNameController,
              hintText: "Enter your name",
            ),
          ],
        ),
        actions: [
          FilledButton(
            onPressed: _isUploading ? null : _createUser,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(
                _isUploading ? AppColors.grey : AppColors.highlight,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_isUploading)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0)
                        .copyWith(right: 16),
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: _isUploading ? AppColors.black : AppColors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                Text('Create User',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color:
                            _isUploading ? AppColors.black : AppColors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
