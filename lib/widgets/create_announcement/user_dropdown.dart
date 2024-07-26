import 'package:efficient_school/models/user.model.dart';
import 'package:efficient_school/repositories/user_repository.dart';
import 'package:efficient_school/services/user_notifier.dart';
import 'package:efficient_school/utils/reusable_widgets.dart';
import 'package:efficient_school/utils/shared_prefs.dart';
import 'package:efficient_school/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class UserDropdown extends StatefulWidget {
  const UserDropdown({super.key});

  @override
  State<UserDropdown> createState() => _UserDropdownState();
}

class _UserDropdownState extends State<UserDropdown> {
  List<User>? users;
  bool isUserLoading = false;

  UserRepository userRepository = UserRepository();

  void fetchUsersAndShow() async {
    if (users == null) {
      setState(() {
        isUserLoading = true;
      });
      users = await userRepository.getUsers();
      setState(() {
        isUserLoading = false;
      });
    }
    if (mounted) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return UserListModal(
              users: users ?? [],
              onUserSelected: (User user) {
                SharedPrefs().setCurrentUser = user;
                Provider.of<UserNotifier>(context, listen: false).updateUser();

                Navigator.pop(context);
              },
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        fetchUsersAndShow();
      },
      child: isUserLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: AppColors.white,
                strokeWidth: 2,
              ),
            )
          : const FaIcon(
              FontAwesomeIcons.chevronDown,
              size: 24,
              color: AppColors.white,
            ),
    );
  }
}

class UserListModal extends StatefulWidget {
  final List<User> users;
  final ValueChanged<User> onUserSelected;

  const UserListModal(
      {super.key, required this.users, required this.onUserSelected});

  @override
  State<UserListModal> createState() => _UserListModalState();
}

class _UserListModalState extends State<UserListModal> {
  List<User> filteredUsers = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredUsers = widget.users;
  }

  void filterUsers(String query) {
    final filtered = widget.users.where((user) {
      final usernameLower = user.userName.toLowerCase();
      final searchLower = query.toLowerCase();
      return usernameLower.contains(searchLower);
    }).toList();

    setState(() {
      filteredUsers = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppTextField(
          onTextChanged: (value) {
            filterUsers(value);
          },
          searchHintText: 'Search user',
        ),
        Expanded(
          child: ListView(
            children: filteredUsers.map((User user) {
              return ListTile(
                leading: ReusableWidgets.buildProfileImage(
                    profileImageUrl: user.profileImage),
                title: Text(user.userName),
                onTap: () {
                  widget.onUserSelected(user);
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class AppTextField extends StatefulWidget {
  final Function(String) onTextChanged;
  final String? searchHintText;

  const AppTextField({
    required this.onTextChanged,
    this.searchHintText,
    super.key,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final TextEditingController _editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        controller: _editingController,
        cursorColor: Colors.black,
        onChanged: (value) {
          widget.onTextChanged(value);
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black12,
          contentPadding:
              const EdgeInsets.only(left: 0, bottom: 0, top: 0, right: 15),
          hintText: widget.searchHintText,
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          prefixIcon: const IconButton(
            icon: Icon(Icons.search),
            onPressed: null,
          ),
          suffixIcon: GestureDetector(
            onTap: onClearTap,
            child: const Icon(
              Icons.cancel,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  void onClearTap() {
    widget.onTextChanged("");
    _editingController.clear();
  }
}
