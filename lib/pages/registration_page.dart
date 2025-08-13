import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_notes/change_notifiers/registration_controller.dart';
import 'package:personal_notes/core/constans.dart';
import 'package:personal_notes/core/validator.dart';
import 'package:personal_notes/pages/recover_password.dart';
import 'package:personal_notes/widgets/note_button.dart';
import 'package:personal_notes/widgets/note_form_field.dart';
import 'package:personal_notes/widgets/note_icon_button_outline.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late final RegistrationController registrationController;
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    registrationController = context.read();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    formKey = GlobalKey();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Selector<RegistrationController, bool>(
                selector: (_, controller) => controller.isRegisterMode,
                builder: (_, isREgisterMode, _) => Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        isREgisterMode ? 'Register' : 'Sign in ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 45,
                          fontFamily: 'Fredoka',
                          fontWeight: FontWeight.w600,
                          color: primary,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'In order to save your notes on cloud,  you have to register / sign in to app',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.0),

                      if (isREgisterMode) ...[
                        NoteFormField(
                          labelText: 'Full Name',
                          Controller: nameController,
                          filled: false,
                          textCapitalization: TextCapitalization.sentences,
                          textInputAction: TextInputAction.next,
                          validator: Validator.nameValidator,
                          onChanged: (newValue) {
                            registrationController.fullname = newValue;
                          },
                        ),
                        SizedBox(height: 8.0),
                      ],
                      NoteFormField(
                        Controller: emailController,
                        labelText: 'Email adress',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,

                        validator: Validator.emailValidator,
                        onChanged: (newValue) {
                          registrationController.email = newValue;
                        },
                      ),
                      SizedBox(height: 8.0),
                      Selector<RegistrationController, bool>(
                        selector: (_, controller) =>
                            controller.isPasswordHidden,
                        builder: (_, isPasswordHidden, _) => NoteFormField(
                          labelText: 'Password ',
                          Controller: passwordController,
                          obscureText: isPasswordHidden,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              registrationController.isPasswordHidden =
                                  !isPasswordHidden;
                            },
                            child: Icon(
                              isPasswordHidden
                                  ? FontAwesomeIcons.eye
                                  : FontAwesomeIcons.eyeSlash,
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          validator: Validator.passwordValidator,
                          onChanged: (newValue) {
                            registrationController.password = newValue;
                          },
                        ),
                      ),
                      SizedBox(height: 11.0),
                      if (!isREgisterMode) ...[
                        GestureDetector(
                          child: Text(
                            'Forgate Password ',
                            style: TextStyle(
                              color: primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RecoverPassword(),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 24.0),
                      ],

                      SizedBox(height: 48.0),
                      SizedBox(
                        height: 48,

                        
                      ),
                      const SizedBox(height: 32),

                      Selector<RegistrationController, bool>(
                        selector: (_, controller) => controller.isLoading,
                        builder: (_, isLoading, _) => NoteButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    registrationController
                                        .authenticateWithEamilAndPassword(
                                          context: context,
                                        );
                                  }

                                  // //gpt help
                                  // if (formKey.currentState?.validate() ??
                                  //     false) {
                                  //   await Future.microtask(() {
                                  //     registrationController
                                  //         .authenticateWithEamilAndPassword(
                                  //           context: context,
                                  //         );
                                  //   });
                                  // }
                                },
                          child: isLoading
                              ? SizedBox(
                                  width: 24,
                                  height: 24,

                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  isREgisterMode
                                      ? 'Create my account'
                                      : 'Log in ',
                                ),
                        ),
                      ),

                      SizedBox(height: 32.0),
                      Row(
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Text(
                              isREgisterMode
                                  ? 'or register with'
                                  : 'Or sign in with ',
                            ),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                      SizedBox(height: 32.0),
                      Row(
                        children: [
                          Expanded(
                            child: NoteIconBottonOutline(
                              icon: FontAwesomeIcons.google,
                              OnPressed: () {},
                            ),
                          ),
                          SizedBox(width: 16.0),

                          Expanded(
                            child: NoteIconBottonOutline(
                              icon: FontAwesomeIcons.facebook,
                              OnPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 32.0),

                      Text.rich(
                        TextSpan(
                          text: isREgisterMode
                              ? 'Already have an  acount?'
                              : 'Do not hane account? ',
                          style: TextStyle(color: gray700),
                          children: [
                            TextSpan(
                              text: isREgisterMode ? 'Sign in ' : 'Register',
                              style: TextStyle(
                                color: primary,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  registrationController.isRegisterMode =
                                      !isREgisterMode;
                                },
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
 