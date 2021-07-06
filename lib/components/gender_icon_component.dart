import 'package:flutter/widgets.dart';
import 'package:nicamal_app/components/nicamal_icons_icons.dart';

Widget iconSelect(BuildContext context, String gender, double size) {
  if (gender == 'male') {
    return Icon(
      NicamalIcons.male,
      size: size,
    );
  } else if (gender == 'female') {
    return Icon(
      NicamalIcons.female,
      size: size,
    );
  }

  return Icon(
    NicamalIcons.male,
    size: size,
  );
}