import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/blocs/auth/register/register_bloc.dart';
import 'package:news/blocs/auth/register/register_state.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/models/auth/register/register_model.dart';
import 'package:news/screens/auth/login/login_screen.dart';
import 'package:news/screens/home/home_screen.dart';
import 'package:news/screens/home/widgets/language_selector.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final ValueNotifier<bool> sendBirthdayCardNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          LanguageSelector(),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(AppLocalizations.of(context)!.registerTitle, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Center(
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: BlocListener<RegisterBloc, RegisterState>(
                      listener: (context, state) {
                        if (state is RegisterSuccess) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        }
                      },
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Column(
                            children: [
                              TextField(controller: firstNameController, decoration: InputDecoration(labelText: AppLocalizations.of(context)!.firstName,border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)))),
                              SizedBox(height: 10),
                              TextField(controller: lastNameController, decoration: InputDecoration(labelText: AppLocalizations.of(context)!.lastName,border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)))),
                              SizedBox(height: 10),
                              TextField(controller: phoneNumberController, decoration: InputDecoration(labelText: AppLocalizations.of(context)!.phoneNumber, border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)))),
                              SizedBox(height: 10),
                              TextField(controller: emailController, decoration: InputDecoration(labelText: AppLocalizations.of(context)!.email, border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)))),
                              SizedBox(height: 10),
                              TextField(controller: passwordController, decoration: InputDecoration(labelText: AppLocalizations.of(context)!.password,border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))), obscureText: true),
                              SizedBox(height: 10),
                              TextField(controller: birthDateController, decoration: InputDecoration(labelText: AppLocalizations.of(context)!.birthdayLabel, border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)))),
                              Row(
                                children: [
                                  Text(AppLocalizations.of(context)!.birthdayCard),
                                  ValueListenableBuilder<bool>(
                                    valueListenable: sendBirthdayCardNotifier,
                                    builder: (context, value, child) {
                                      return Switch(
                                        value: value,
                                        onChanged: (newValue) => sendBirthdayCardNotifier.value = newValue,
                                      );
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              BlocBuilder<RegisterBloc, RegisterState>(
                                builder: (context, state) {
                                  if (state is RegisterFailure) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (state.validationErrors.isNotEmpty)
                                          ...state.validationErrors.entries.expand(
                                            (entry) => entry.value.map(
                                              (errorMsg) => Text("${entry.key}: $errorMsg", style: TextStyle(color: Colors.red)),
                                            ),
                                          ),
                                        if (state.errors.isNotEmpty)
                                          ...state.errors.map((error) => Text(error, style: TextStyle(color: Colors.red))),
                                      ],
                                    );
                                  }
                                  return SizedBox.shrink();
                                },
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<RegisterBloc>().add(RegisterUserModel(
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    phoneNumber: phoneNumberController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    birthDate: birthDateController.text,
                                    sendBirthdayCardAutomatically: sendBirthdayCardNotifier.value,
                                  ));
                                },
                                child: Text(AppLocalizations.of(context)!.registerTitle),
                              ),
                              SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => LoginScreen()),
                                  );
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.alreadyHaveAcc,
                                  style: TextStyle(color: Colors.blue, fontSize: 14),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
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
