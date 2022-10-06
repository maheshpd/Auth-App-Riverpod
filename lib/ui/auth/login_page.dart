import 'package:auth_app_riverpod/root.dart';
import 'package:auth_app_riverpod/ui/auth/providers/auth_view_model_provider.dart';
import 'package:auth_app_riverpod/utils/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final styles = theme.textTheme;
    final model = ref.watch(authViewModelProvider);
    return Stack(
      children: [
        Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  Icon(
                    Icons.favorite,
                    size: 80,
                    color: scheme.primary,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    Labels.appName.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: styles.titleLarge,
                  ),
                  const Spacer(),
                  Text(
                    Labels.signIn,
                    style: styles.headlineLarge,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    initialValue: model.email,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        labelText: Labels.email),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (v) => model.email = v,
                    validator: (v) => model.emailValidate(v!),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    initialValue: model.password,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      suffixIcon: IconButton(
                        onPressed: () {
                          model.obscurePassword = !model.obscurePassword;
                        },
                        icon: Icon(model.obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_rounded),
                      ),
                      labelText: Labels.password,
                    ),
                    onChanged: (v) => model.email = v,
                    obscureText: model.obscurePassword,
                    enableSuggestions: false,
                    autocorrect: false,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  MaterialButton(
                    onPressed:
                        model.email.isNotEmpty && model.password.isNotEmpty
                            ? () async {
                                if (_formKey.currentState!.validate()) {
                                  try {
                                    await model.login();
                                    // ignore: use_build_context_synchronously
                                    Navigator.pushReplacementNamed(
                                        context, Root.route);
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "$e",
                                          style: styles.bodyLarge!.copyWith(
                                              color: scheme.onErrorContainer),
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: scheme.errorContainer,
                                      ),
                                    );
                                  }
                                  model.login();
                                }
                              }
                            : null,
                    color: scheme.primaryContainer,
                    padding: const EdgeInsets.all(16),
                    child: const Text("Sign In"),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (model.loading)
          Material(
            color: scheme.surfaceVariant.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
      ],
    );
  }
}
