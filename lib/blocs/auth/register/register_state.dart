import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final String message;

  RegisterSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class RegisterFailure extends RegisterState {
  final Map<String, List<String>> validationErrors;
  final List<String> errors;
  final String generalError;

  RegisterFailure({this.validationErrors = const {}, this.errors = const [], this.generalError = "An unknown error occurred"});

  @override
  List<Object> get props => [validationErrors, errors, generalError];
}