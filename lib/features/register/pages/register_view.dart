import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/config/constants/page_routes.dart';
import 'package:todo_app/core/services/firebase_services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/config/constants/settings_provider.dart';
import '../../../core/services/snack_bar_services.dart';
import '../../../core/widgets/text_form_field.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

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
    var locale =AppLocalizations.of(context)!;

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
            locale.createAccount,
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
                   locale.fullName,
                    style: theme.textTheme.bodySmall,
                  ),
                  CustomTextFormField(
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return locale.enterYourFullName;
                      }
                      return null;
                    },
                    controller: nameController,
                    hintText:locale.enterYourFullName,
                    hintColor:
                        vm.isDark() ? Colors.grey.shade600 : Colors.black54,
                    keyboardType: TextInputType.emailAddress,
                    suffixWidget: const Icon(Icons.person),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    locale.email,
                    style: theme.textTheme.bodySmall,
                  ),
                  CustomTextFormField(
                    controller: emailController,
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return locale.youMustEnterYourEmail;
                      }
                      var regex = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                      if (!regex.hasMatch(value)) {
                        return locale.invalidEmailAddress;
                      }
                      return null;
                    },
                    hintText: locale.enterYourEmailAddress,
                    hintColor:
                        vm.isDark() ? Colors.grey.shade600 : Colors.black54,
                    keyboardType: TextInputType.emailAddress,
                    suffixWidget: const Icon(Icons.email_rounded),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    locale.password,
                    style: theme.textTheme.bodySmall,
                  ),
                  CustomTextFormField(
                    controller: passwordController,
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return locale.youMustEnterYourPassword;
                      }
                      var regex = RegExp(
                          r"(?=^.{8,}$)(?=.*[!@#$%^&*]+)(?![.\\n])(?=.*[A-Z])(?=.*[a-z]).*$");
                      if (!regex.hasMatch(value)) {
                        return locale.thePasswordProvidedIsTooWeak;
                      }
                      return null;
                    },
                    hintText: locale.enterYourPassword,
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
                    locale.confirmPassword,
                    style: theme.textTheme.bodySmall,
                  ),
                  CustomTextFormField(
                    controller: confirmPasswordController,
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return locale.youMustEnterYourPassword;
                      }
                      if (value != passwordController.text) {
                        return locale.passwordDoesNotMatch;
                      }
                      return null;
                    },
                    hintText: locale.confirmPassword,
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
                          context
                            )
                            .then((value) => {
                                  if (value == true)
                                    {
                                      EasyLoading.dismiss(),
                                      SnackBarService.showSuccessMessage(locale.accountSuccessfullyCreated,context),
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          PageRoutesName.login,
                                          (route) => false)
                                    }
                                  else{
                                    EasyLoading.dismiss(),
                                    SnackBarService.showErrorMessage(locale.accountCreationFailed,context),
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
                         locale.createAccount,
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
