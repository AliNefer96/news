import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/blocs/auth/register/register_bloc.dart';
import 'package:news/blocs/auth/register/register_state.dart';
import 'package:news/models/auth/register/register_model.dart';
import 'package:news/screens/home/home_screen.dart';
import 'package:news/src/app_strings.dart'; // Dodano

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
      appBar: AppBar(title: Text(AppStrings.registerTitle)),
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          }
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth * 0.1,
                vertical: 20,
              ),
              child: Column(
                children: [
                  TextField(controller: firstNameController, decoration: InputDecoration(labelText: AppStrings.firstName)),
                  TextField(controller: lastNameController, decoration: InputDecoration(labelText: AppStrings.lastName)),
                  TextField(controller: phoneNumberController, decoration: InputDecoration(labelText: AppStrings.phoneNumber)),
                  TextField(controller: emailController, decoration: InputDecoration(labelText: AppStrings.email)),
                  TextField(controller: passwordController, decoration: InputDecoration(labelText: AppStrings.password), obscureText: true),
                  TextField(controller: birthDateController, decoration: InputDecoration(labelText: AppStrings.birthday)),
                  Row(
                    children: [
                      Text(AppStrings.birthdayCard),
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
                    child: Text(AppStrings.registerTitle),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
