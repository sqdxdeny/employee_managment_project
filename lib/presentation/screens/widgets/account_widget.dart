import 'package:flutter/material.dart';

class AccountWidget extends StatelessWidget {
  final Widget image;
  final String name;

  const AccountWidget({
    super.key,
    required this.image,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        image,
        Text(name),
      ],
    );
  }
}
