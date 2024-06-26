import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/widgets/column_with_text_field.dart';
class PassAndConfirmPass extends StatefulWidget {
  const PassAndConfirmPass({super.key, required this.passwordController, required this.passwordConfirmController});
final TextEditingController passwordController ;
final TextEditingController passwordConfirmController ;

  @override
  State<PassAndConfirmPass> createState() => _PassAndConfirmPassState();
}

class _PassAndConfirmPassState extends State<PassAndConfirmPass> {
  bool passwordVisible = true;
  bool confirmPasswordVisible = true;
  @override
  Widget build(BuildContext context) {
    return      Column(
      children: [
        ColumnWithTextField(
          text: StringManager.password.tr(),
          controller: widget.passwordController,
          obscureText: passwordVisible,
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                passwordVisible = !passwordVisible;
              });
            },
            child: Icon(
              passwordVisible
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: Colors.grey,
            ),
          ),
        ),
        ColumnWithTextField(
          text: StringManager.confirmPassword.tr(),
          obscureText: confirmPasswordVisible,
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                confirmPasswordVisible =
                !confirmPasswordVisible;
              });
            },
            child: Icon(
              confirmPasswordVisible
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: Colors.grey,
            ),
          ),
          controller: widget.passwordConfirmController,
        ),
      ],
    );
  }
}
