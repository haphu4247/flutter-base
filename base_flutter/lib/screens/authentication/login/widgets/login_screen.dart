import 'package:app_base/app_base.dart';
import 'package:base_flutter/app/di_config.dart';
import 'package:base_flutter/data/api_repositories/authentication/authentication_repository.dart';
import 'package:base_flutter/data/local_repositories/local_repository.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/screens/authentication/login/vm/login_vm.dart';
import 'package:base_flutter/shared/extension/context_extension.dart';
import 'package:flutter/material.dart';

//https://dummyjson.com/docs/auth
class LoginScreen extends BaseScreen<LoginVM> {
  LoginScreen({super.key})
      : super(
            vm: LoginVM(
          getIt.get<AuthenticationRepository>(),
          getIt.get<LocalRepository>(),
        ));

  @override
  Widget buildView(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final email = TextEditingController(text: 'emilys');
    final password = TextEditingController(text: 'emilyspass');
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: email,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              // onChanged: (value) => vm.email = value,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Enter your email' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: password,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              // onChanged: (value) => vm.password = value,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Enter your password' : null,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState?.validate() ?? false) {
                  vm
                      .login(
                          context: context,
                          username: email.text.trim(),
                          password: password.text.trim())
                      .then(
                    (value) {
                      if (value) {
                        context.navigation.back();
                      }
                    },
                  );
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
