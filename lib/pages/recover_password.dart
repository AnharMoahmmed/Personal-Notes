import 'package:flutter/material.dart';
import 'package:personal_notes/change_notifiers/registration_controller.dart';
import 'package:personal_notes/core/validator.dart';
import 'package:personal_notes/widgets/note_back_botton.dart';
import 'package:personal_notes/widgets/note_button.dart';

import 'package:personal_notes/widgets/note_form_field.dart';
import 'package:provider/provider.dart';

class RecoverPassword extends StatefulWidget {
  const RecoverPassword({super.key});

  @override
  State<RecoverPassword> createState() => _RecoverPasswordState();
}

class _RecoverPasswordState extends State<RecoverPassword> {
  late final TextEditingController emailController;
  GlobalKey<FormFieldState> emailKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    emailController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: NoteBackButton(),
        title: Text('recover password '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Don\' worry! happens to best of us ! ',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              NoteFormField(
                filled: false,
                labelText: 'email',
                validator: Validator.emailValidator,
                Controller: emailController,
                key: emailKey,
              ),
              SizedBox(height: 24),

              SizedBox(
                height: 48,
                child: Selector<RegistrationController, bool>(
                  selector: (_, controller) => controller.isLoading,
                  builder: (_, isLoding, _) => NoteButton(
                    child: isLoding
                        ? SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text('send me recovery link!'),
                    onPressed: () {
                      if (emailKey.currentState?.validate() ?? false) {
                        context.read<RegistrationController>().resetPassword(
                          context: context,
                          email: emailController.text.trim(),
                        );
                      }
                    },
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
