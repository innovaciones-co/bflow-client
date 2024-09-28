import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/img/sh_logo.png',
          height: 50,
          width: 50,
        ),
        Image.asset(
          'assets/img/sh_text.png',
          height: 50,
          width: 100,
        ),
      ],
    );
  }
}
