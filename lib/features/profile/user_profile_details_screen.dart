import 'package:flutter/material.dart';
import 'package:tasky_app/core/services/preference_manager.dart';
import 'package:tasky_app/core/widgets/custom_text_form_filed.dart';

class UserProfileDetailsScreen extends StatefulWidget {
 const UserProfileDetailsScreen({super.key, required this.userName, required this.motivationQuote});
  final String userName ;
  final String? motivationQuote;

  @override
  State<UserProfileDetailsScreen> createState() => _UserProfileDetailsScreenState();
}

class _UserProfileDetailsScreenState extends State<UserProfileDetailsScreen> {

  final _formKey = GlobalKey<FormState>();

  late TextEditingController userNameController;
late TextEditingController motivationQuoteController;

@override
void initState() {
  super.initState();

  userNameController = TextEditingController(
    text: widget.userName,
  );

  motivationQuoteController = TextEditingController(
    text: widget.motivationQuote,
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Details')),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormFiled(
               
                controller: userNameController,
                hintText: 'Usama Elgendy',
                title: 'User Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Entre Your User Name";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              CustomTextFormFiled(
                controller: motivationQuoteController,
                hintText: 'One task at a time. One step closer.',
                title: 'Motivation Quote',
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Entre Your Motivation Quote";
                  }
                  return null;
                },
              ),
              Spacer(),

              ElevatedButton(
                onPressed: ()async {
                  if(_formKey.currentState?.validate() ?? false){
                
                  await PreferenceManager().setString('fullName', userNameController.text);
                  await PreferenceManager().setString('motivation_quote', motivationQuoteController.text);

                  Navigator.of(context).pop(true);

                }
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 40),
                ),
                child: Text('Save Changes'),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
