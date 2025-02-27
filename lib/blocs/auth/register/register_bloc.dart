import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/blocs/auth/register/register_event.dart';
import 'package:news/blocs/auth/register/register_state.dart';
import 'package:news/models/auth/register/register_model.dart';
import 'package:news/network/auth/register/register_api_service.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterApiService _registerApiService;

  RegisterBloc(this._registerApiService) : super(RegisterInitial()) {
    on<RegisterUserModel>((event, emit) async {
      emit(RegisterLoading());

      if (!_validateEmail(event.email)) {
        emit(RegisterFailure(validationErrors: {"email": ["Invalid email format"]}));
        return;
      }
      if (!_validatePassword(event.password)) {
        emit(RegisterFailure(validationErrors: {
          "password": [
            "Password must be at least 8 characters, include upper/lowercase, number, and special character"
          ]
        }));
        return;
      }

      final response = await _registerApiService.registerUser(event);

      if (response["success"]) {
        emit(RegisterSuccess(message: ''));
      } else {
        emit(RegisterFailure(
          validationErrors: response["isValidationError"] ? response["validationErrors"] : {},
          errors: response["errors"],
        ));
      }
    });
  }

  bool _validateEmail(String email) => EmailValidator.validate(email);

  bool _validatePassword(String password) {
    return RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@\$!%*?&])[A-Za-z\d@\$!%*?&]{8,}$')
        .hasMatch(password);
  }
}
