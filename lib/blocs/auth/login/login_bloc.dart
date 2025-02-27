import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:news/blocs/auth/login/login_event.dart';
import 'package:news/blocs/auth/login/login_state.dart';
import 'package:news/models/auth/login/login_model.dart';
import 'package:news/network/auth/login/login_api_service.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginApiService _apiService;
  // ignore: unused_field
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  LoginBloc(this._apiService) : super(LoginInitial()) {
    on<LoginUser>(_onLoginUser);
    on<CheckLoginStatus>(_onCheckLoginStatus);
  }

  /// **Prijava korisnika**
 Future<void> _onLoginUser(LoginUser event, Emitter<LoginState> emit) async {
  emit(LoginLoading());

  if (event.email.isEmpty || event.password.isEmpty) {
    emit(LoginFailure("Fields cannot be empty"));
    return;
  }

  // Kreiranje LoginUserModel instance
  final loginUserModel = LoginUserModel(
    email: event.email,
    password: event.password,
    isGuest: false, // Postavite prema potrebi
  );

  final success = await _apiService.loginUser(loginUserModel);

  if (success) {
    emit(LoginSuccess());
  } else {
    emit(LoginFailure("Invalid email or password"));
  }
}



  /// **Provjera statusa prijave**
  Future<void> _onCheckLoginStatus(CheckLoginStatus event, Emitter<LoginState> emit) async {
    final token = await _apiService.getAccessToken();

    if (token != null) {
      emit(LoginSuccess());
    } else {
      emit(LoginInitial());
    }
  }

  // /// **Odjava korisnika**
  // Future<void> _onLogoutUser(LogoutUser event, Emitter<LoginState> emit) async {
  //   await _apiService.logout();
  //   emit(LoginInitial());
  // }
}
