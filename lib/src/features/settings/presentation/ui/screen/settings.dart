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
  static const _settingsTitleMobile = 'Настройки';
  static const _settingsTitleDesktop = '917 VPN';
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
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 320.0),
      child: Column(
        children: [
          SizedBox(height: isDesktop ? 96.0 : (30.0 + MediaQuery.paddingOf(context).top)),
          Text(
            isDesktop ? _settingsTitleDesktop : _settingsTitleMobile,
            style: isDesktop ? VpnAppFonts.appTitle : VpnAppFonts.regularBold,
          ),
          SizedBox(height: isDesktop ? 140.0 : 40.0),
          Form(
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
                SizedBox(
                  width: double.infinity,
                  child: VpnAppButton.primary(
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
                  ),
                )
              ],
            ),
          ),
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
  // TODO: should be intl
  static const _errorMessage = 'Please enter some text';

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
    return Container(
      height: 60.0,
      decoration: const BoxDecoration(
        color: BasicVpnAppColors.textForm,
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      child: TextFormField(
        controller: _controller,
        obscureText: widget.obscureText,
        cursorColor: BasicVpnAppColors.main,
        style: VpnAppFonts.inputHelper.copyWith(color: BasicVpnAppColors.main),
        decoration: InputDecoration(
          hintText: widget.hint,
          fillColor: BasicVpnAppColors.textForm,
          hintStyle: VpnAppFonts.inputHelper,
          disabledBorder: const KitTextFormOutlineInputBorder(
            borderSide: BorderSide(color: BasicVpnAppColors.textForm),
          ),
          enabledBorder: const KitTextFormOutlineInputBorder(
            borderSide: BorderSide(color: BasicVpnAppColors.textForm),
          ),
          focusedBorder: const KitTextFormOutlineInputBorder(
            borderSide: BorderSide(color: BasicVpnAppColors.textForm),
          ),
          errorBorder: const KitTextFormOutlineInputBorder(
            borderSide: BorderSide(color: BasicVpnAppColors.textForm),
          ),
        ),
        validator: (value) => value == null || value.isEmpty ? _errorMessage : null,
      ),
    );
  }
}

class KitTextFormOutlineInputBorder extends OutlineInputBorder {
  const KitTextFormOutlineInputBorder({super.borderSide})
      : super(borderRadius: const BorderRadius.all(Radius.circular(15.0)));
}
