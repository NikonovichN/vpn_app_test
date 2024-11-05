import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../src.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return switch (state) {
          SettingsLoading() => const Center(child: CircularProgressIndicator()),
          // TODO: add handle error
          SettingsError() || SettingsInitial() => const Settings(),
          SettingsLoaded() => Settings(state: state),
        };
      },
    );
  }
}

class Settings extends StatefulWidget {
  final SettingsLoaded? state;

  const Settings({super.key, this.state});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // TODO: should be intl
  static const _addressHint = 'Адрес сервера';
  static const _loginHint = 'Логин';
  static const _passwordHint = 'Пароль';
  static const _textButton = 'Сохранить';

  static const _emptySpaceM = SizedBox(height: 10.0);
  static const _emptySpaceL = SizedBox(height: 30.0);

  final _formKey = GlobalKey<FormState>();
  final _addressServerTextController = TextEditingController();
  final _loginTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _SettingTextFormField(
            hint: _addressHint,
            initialValue: widget.state?.serverAddress,
            controller: _addressServerTextController,
          ),
          _emptySpaceM,
          _SettingTextFormField(
            hint: _loginHint,
            initialValue: widget.state?.login,
            controller: _loginTextController,
          ),
          _emptySpaceM,
          _SettingTextFormField(
            hint: _passwordHint,
            obscureText: true,
            controller: _passwordTextController,
            initialValue: widget.state?.password,
          ),
          _emptySpaceL,
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<SettingsCubit>().save(
                      serverAddress: _addressServerTextController.text,
                      login: _loginTextController.text,
                      password: _passwordTextController.text,
                    );
              }
            },
            child: const Text(_textButton),
          )
        ],
      ),
    );
  }
}

class _SettingTextFormField extends StatefulWidget {
  final String hint;
  final String? initialValue;
  final bool obscureText;
  final TextEditingController? controller;

  const _SettingTextFormField({
    required this.hint,
    this.initialValue,
    this.obscureText = false,
    this.controller,
  });

  @override
  State<_SettingTextFormField> createState() => __SettingTextFormFieldState();
}

class __SettingTextFormFieldState extends State<_SettingTextFormField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        hintText: widget.hint,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }
}
