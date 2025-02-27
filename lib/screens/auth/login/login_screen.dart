import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/blocs/auth/login/login_bloc.dart';
import 'package:news/blocs/auth/login/login_event.dart';
import 'package:news/blocs/auth/login/login_state.dart';
import 'package:news/screens/home/home_screen.dart';
import 'package:news/src/app_strings.dart'; 

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.loginTitle)),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth * 0.1,
              vertical: 20,
            ),
            child: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                }
              },
              child: Column(
                children: [
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: AppStrings.email),
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(labelText:AppStrings.password),
                    obscureText: true,
                  ),
                  SizedBox(height: 10),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      if (state is LoginFailure) {
                        return Text(
                          state.error,
                          style: TextStyle(color: Colors.red),
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<LoginBloc>().add(
                        LoginUser(emailController.text, passwordController.text),
                      );
                    },
                    child: Text(AppStrings.loginTitle),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
