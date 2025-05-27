import 'package:app_base/app_base.dart';
import 'package:base_flutter/data/api_repositories/authentication/authentication_repository.dart';
import 'package:base_flutter/data/local_repositories/local_repository.dart';
import 'package:base_flutter/shared/extension/context_extension.dart';
import 'package:flutter/material.dart';

class LoginVM extends BaseViewModel {
  final AuthenticationRepository _authenticationRepository;
  final LocalRepository _localRepository;
  const LoginVM(this._authenticationRepository, this._localRepository);

  bool validate(String username, String password) {
    return username.isNotEmpty && password.isNotEmpty;
  }

  Future<bool> login(
      {required BuildContext context,
      required String username,
      required String password}) async {
    if (!validate(username, password)) {
      // showError('Please enter username and password');
      return false;
    }
    showLoading();
    return _authenticationRepository
        .login(username: username, password: password)
        .then((value) async {
      hideLoading();
      if (value.accessToken != null) {
        return _localRepository.saveLoginInfo(value);
      } else {
        showDefaultDialog('Login failed', icon: context.envConfig.appIcon,);
        return false;
      }
    }).onError(
      (error, stackTrace) {
        hideLoading();
        showError(error.toString());
        return false;
      },
    );
  }
}
