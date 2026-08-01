import 'package:flutter/material.dart';
import 'package:tasky_app/core/services/preference_manager.dart';
import 'package:tasky_app/core/widgets/custom_svg_picture_widget.dart';
import 'package:tasky_app/core/widgets/custom_text_form_filed.dart';
import 'package:tasky_app/features/navigation/main_screen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});
  final TextEditingController controller = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomSvgPictureWidget.withOutColorFilter(
                    assetName: 'assets/images/logo.svg',
                    height: 42,
                    width: 42,
                  ),
                  SizedBox(width: 16),
                  Text(
                    'Tasky',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
              SizedBox(height: 118),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome To Tasky ',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  CustomSvgPictureWidget.withOutColorFilter(
                    assetName: 'assets/images/waving_hand.svg',
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Your productivity journey starts here.',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 24),
              CustomSvgPictureWidget.withOutColorFilter(
                assetName: 'assets/images/welcom.svg',
                height: 204,
                width: 214,
              ),
              SizedBox(height: 28),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormFiled(
                        controller: controller,
                        hintText: 'e.g. Sarah Khalid',
                        title: 'Full Name',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please Enter Your Full Name!';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 24),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_key.currentState?.validate() ?? false) {
                              await PreferenceManager().setString(
                                'fullName',
                                controller.value.text,
                              );
                              Navigator.pushReplacement(
                                // ignore: use_build_context_synchronously
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainScreen(),
                                ),
                              );
                              controller.clear();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Please Enter Your Full Name!'),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(100),
                            ),
                          ),
                          child: Text("Let's Get Started",),
                        ),
                      ),
                      SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
