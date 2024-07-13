import 'dart:math';

import 'package:admin_panel/models/user.dart';
import 'package:admin_panel/utils/inputvalidatsiya.dart';
import 'package:admin_panel/utils/user_input_validation.dart';

class MakeUserToAdd {
  final checker = UserInputValidation();
  String getLastFourCharacters(String input) {
    if (input.length <= 4) {
      return input;
    } else {
      return input.substring(input.length - 4);
    }
  }

  Future makeUser(User user) async {
    user.name = Validate.capitalizeFirstLetter(user.name);
    user.surname = Validate.capitalizeFirstLetter(user.surname);
    user.role = Validate.capitalizeFirstLetter(user.role);
    user.workPlace = Validate.capitalizeFirstLetter(user.workPlace);
    user.password = user.name + getLastFourCharacters(user.phoneNumber);
    user.id = await makeId();
    return user;
  }

  Future<int> makeId() async {
    while (true) {
      int id = Random().nextInt(90000) + 10000;
      int response = await checker.checkId(id.toString());
      if (response == 0) {
        return id;
      }
    }
  }
}
