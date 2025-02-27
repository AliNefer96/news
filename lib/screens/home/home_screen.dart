import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/blocs/auth/login/login_bloc.dart';
import 'package:news/blocs/auth/login/login_event.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/screens/auth/login/login_screen.dart';
import 'package:news/screens/news/news_list_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.newsTitle),
        actions: [
           IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
             
              context.read<LoginBloc>().add(LogoutUser());
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ],
      ),
      body:
      NewsListScreen()
    );
  }
}
