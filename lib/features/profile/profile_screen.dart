import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasky_app/core/constance/storage_key.dart';
import 'package:tasky_app/core/services/preference_manager.dart';
import 'package:tasky_app/core/theme/theme_controller.dart';
import 'package:tasky_app/core/widgets/custom_svg_picture_widget.dart';
import 'package:tasky_app/features/profile/user_profile_details_screen.dart';
import 'package:tasky_app/features/welcome/welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? fullName = 'guest';
  String? motivationQuote;
  String? userImagePath ;
  

  @override
  void initState() {
    super.initState();
    _getFullNameAndMotivationQuoteAndIamge();
    ThemeController().init();
  }

  Future<void> _getFullNameAndMotivationQuoteAndIamge() async {
    setState(() {
      fullName = PreferenceManager().getString(StorageKey.userName) ?? 'guest';
      motivationQuote =
          PreferenceManager().getString('motivation_quote') ??
          'One task at a time. One step closer.';
      userImagePath = PreferenceManager().getString(StorageKey.userImage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'My Profile',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
          SizedBox(height: 16),
          Center(
            child: Column(
              children: [
                Stack(
                  //it use if you have two children of stack
                  // alignment: AlignmentGeometry.bottomRight,
                  children: [
                    CircleAvatar(
                      backgroundImage: userImagePath == null
                          ? AssetImage('assets/images/Leading element.png')
                          : FileImage(File(userImagePath!)),
                      radius: 60,
                      backgroundColor: Colors.transparent,
                    ),
                    // it use if you have more than two stack
                    Positioned(
                      bottom: -10,
                      right: -10,
                      child: GestureDetector(
                        onTap: () {
                          _showImageSourceDialog(
                            context,
                            selectedFile: (XFile file) {
                              _saveImage(file);
                            setState(() {
                              userImagePath = (file.path);
                            });
                          });

                          // }
                        },
                        child: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Theme.of(
                              context,
                            ).colorScheme.primaryContainer,
                          ),
                          child: Icon(Icons.camera_alt, size: 26),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  fullName ?? 'guest',
                  style: Theme.of(context).textTheme.labelSmall!,
                ),

                Text(
                  motivationQuote ?? 'One task at a time. One step closer.',
                  style: Theme.of(context).textTheme.titleSmall!,
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          Text('Profile Info', style: Theme.of(context).textTheme.labelSmall),

          SizedBox(height: 16),
          ListTile(
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return UserProfileDetailsScreen(
                      userName: fullName ?? '',
                      motivationQuote: motivationQuote ?? '',
                    );
                  },
                ),
              );
              if (result != null && result) {
                _getFullNameAndMotivationQuoteAndIamge();
              }
            },
            contentPadding: EdgeInsets.zero,
            title: Text('User Details'),

            leading: CustomSvgPictureWidget(
              assetName: 'assets/images/user_icon.svg',
            ),
            trailing: CustomSvgPictureWidget(
              assetName: 'assets/images/arrow_right.svg',
            ),
          ),

          Divider(),

          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Dark Mode'),

            leading: CustomSvgPictureWidget(
              assetName: 'assets/images/moon-01.svg',
            ),
            trailing: ValueListenableBuilder(
              valueListenable: ThemeController.themeNotifier,

              builder: (context, value, child) {
                return Switch(
                  value: value == ThemeMode.dark,
                  onChanged: (value) async {
                    ThemeController().toggle();
                  },
                );
              },
            ),
          ),
          Divider(),

          ListTile(
            onTap: () async {
              PreferenceManager().remove(StorageKey.tasks);
              PreferenceManager().remove(StorageKey.userName);
              PreferenceManager().remove(StorageKey.motivationQuote);

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return WelcomeScreen();
                  },
                ),
                (Route<dynamic> route) => false,
              );
            },
            contentPadding: EdgeInsets.zero,
            title: Text('Log Out'),

            leading: CustomSvgPictureWidget(
              assetName: 'assets/images/login.svg',
            ),
            trailing: CustomSvgPictureWidget(
              assetName: 'assets/images/arrow_right.svg',
            ),
          ),
        ],
      ),
    );
  }


  _saveImage(XFile file)async
  {
    final appDir = await getApplicationDocumentsDirectory();
    final newFile = await File(file.path).copy("${appDir.path}/${file.name}");
    PreferenceManager().setString(StorageKey.userImage, newFile.path);
  }

  _showImageSourceDialog(BuildContext context, {required Function(XFile) selectedFile}) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            'Choose Image Source',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          children: [
            SimpleDialogOption(
              onPressed: () async {
                  Navigator .pop(context);
                XFile? fileImage = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                );
                if (fileImage != null) {
                  selectedFile(fileImage);
                }
              },
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.camera_alt),
                  SizedBox(width: 8),
                  Text('Camera'),
                ],
              ),
            ),

            SimpleDialogOption(
              onPressed: () async {
                Navigator .pop(context);
                XFile? fileImage = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                if (fileImage != null) {
                  selectedFile(fileImage);
                }
              },
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.photo_library),
                  SizedBox(width: 8),
                  Text('Gallery'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}











// void _showButonSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     context: context,
  //     builder: (context) {
  //       return Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: DraggableScrollableSheet(
  //           initialChildSize: .7,
  //           maxChildSize: .9,
  //           minChildSize: .2,
  //           expand: false,
  //           snap: true,
  //           snapSizes: [0.25, 0.5, 0.9],
  //           builder: (context, scrollController) {
  //             return ListView.builder(
  //               shrinkWrap: true,
  //               controller: scrollController,
  //               itemCount: 20,
  //               itemBuilder: (context, index) {
  //                 return Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Container(
  //                     width: MediaQuery.of(context).size.width,
  //                     height: 50,
  //                     color: Colors.red,
  //                   ),
  //                 );
  //               },
  //             );
  //           },
  //         ),
  //       );
  //     },
  //   );

  // How caluc the hight of sheet?

  // void _showButonSheetAntherWay(BuildContext context) {
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     context: context,
  //     builder: (context) {
  //       return Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: ConstrainedBox(
  //           constraints: BoxConstraints(
  //             maxHeight: MediaQuery.of(context).size.height * .9,
  //              minHeight: MediaQuery.of(context).size.height * .2,
  //           ),
  //           child: ListView.builder(
  //             shrinkWrap: true,
  //             itemCount: 20,
  //             itemBuilder: (context, index) {
  //               return Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Container(
  //                   width: MediaQuery.of(context).size.width,
  //                   height: 50,
  //                   color: Colors.red,
  //                 ),
  //               );
  //             },
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }



// TODO :  Sreach about Date picker dialog and Time Picker Dialog !!!