import 'package:flutter/material.dart';
import 'package:muhammad/helper/size.dart';

class FormError extends StatelessWidget {
  const FormError({
    Key? key,
    required this.errors,
  }) : super(key: key);

  final List<String?> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        errors.length,
        (index) => formErrorText(error: errors[index]!, context: context),
      ),
    );
  }

  Row formErrorText({required String error, required BuildContext context}) {
    return Row(
      children: [
        Icon(
          Icons.error,
          color: Colors.red[700],
        ),
        SizedBox(
          width: ScreenSize(context: context).getProportionateScreenWidth(9),
        ),
        Text(
          error,
          style: TextStyle(
            fontSize:
                ScreenSize(context: context).getProportionateScreenWidth(12),
          ),
        ),
      ],
    );
  }
}
