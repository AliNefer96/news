import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class LoginUser extends LoginEvent {
  final String email, password;
  LoginUser(this.email, this.password);
}
class CheckLoginStatus extends LoginEvent {}
class LogoutUser extends LoginEvent {}

