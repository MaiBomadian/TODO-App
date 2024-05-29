import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/config/constants/page_routes.dart';
import 'package:todo_app/core/services/firebase_services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/config/constants/constants.dart';
import '../../../core/config/constants/settings_provider.dart';
import '../../../core/widgets/text_form_field.dart';

class RegisterView extends StatelessWidget {
  RegisterView({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var vm = Provider.of<SettingsProvider>(context);

    return Container(
      padding: const EdgeInsets.only(top: 28),
      decoration: BoxDecoration(
        color: vm.isDark() ? const Color(0xff060E1E) : const Color(0xffDFECDB),
        image: const DecorationImage(
          image: AssetImage(
            'assets/images/login_background.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            Constants.locale.createAccount,
            style: theme.textTheme.titleLarge,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: mediaQuery.height * .2,
                  ),
                  Text(
                    Constants.locale.fullName,
                    style: theme.textTheme.bodySmall,
                  ),
                  CustomTextFormField(
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return Constants.locale.enterYourFullName;
                      }
                      return null;
                    },
                    controller: nameController,
                    hintText: Constants.locale.enterYourFullName,
                    hintColor:
                        vm.isDark() ? Colors.grey.shade600 : Colors.black54,
                    keyboardType: TextInputType.emailAddress,
                    suffixWidget: const Icon(Icons.person),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    Constants.locale.email,
                    style: theme.textTheme.bodySmall,
                  ),
                  CustomTextFormField(
                    controller: emailController,
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return Constants.locale.youMustEnterYourEmail;
                      }
                      var regex = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                      if (!regex.hasMatch(value)) {
                        return Constants.locale.invalidEmailAddress;
                      }
                      return null;
                    },
                    hintText: Constants.locale.enterYourEmailAddress,
                    hintColor:
                        vm.isDark() ? Colors.grey.shade600 : Colors.black54,
                    keyboardType: TextInputType.emailAddress,
                    suffixWidget: const Icon(Icons.email_rounded),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    Constants.locale.password,
                    style: theme.textTheme.bodySmall,
                  ),
                  CustomTextFormField(
                    controller: passwordController,
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return Constants.locale.youMustEnterYourPassword;
                      }
                      var regex = RegExp(
                          r"(?=^.{8,}$)(?=.*[!@#$%^&*]+)(?![.\\n])(?=.*[A-Z])(?=.*[a-z]).*$");
                      if (!regex.hasMatch(value)) {
                        return Constants.locale.invalidPassword;
                      }
                      return null;
                    },
                    hintText: Constants.locale.enterYourPassword,
                    hintColor:
                        vm.isDark() ? Colors.grey.shade600 : Colors.black54,
                    keyboardType: TextInputType.visiblePassword,
                    maxLines: 1,
                    isPassword: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    Constants.locale.confirmPassword,
                    style: theme.textTheme.bodySmall,
                  ),
                  CustomTextFormField(
                    controller: confirmPasswordController,
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return Constants.locale.youMustEnterYourPassword;
                      }
                      if (value != passwordController.text) {
                        return Constants.locale.passwordDoesNotMatch;
                      }
                      return null;
                    },
                    hintText: Constants.locale.confirmPassword,
                    hintColor:
                        vm.isDark() ? Colors.grey.shade600 : Colors.black54,
                    keyboardType: TextInputType.visiblePassword,
                    maxLines: 1,
                    isPassword: true,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        FirebaseService()
                            .createUserAccount(
                              emailController.text,
                              passwordController.text,
                            )
                            .then((value) => {
                                  if (value == true)
                                    {
                                      EasyLoading.dismiss(),
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          PageRoutesName.login,
                                          (route) => false)
                                    }
                                });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                      backgroundColor: theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Constants.locale.createAccount,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
