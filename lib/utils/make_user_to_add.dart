import 'package:admin_panel/models/user.dart';
import 'package:admin_panel/utils/inputvalidatsiya.dart';

class MakeUserToAdd {
  String getLastFourCharacters(String input) {
    if (input.length <= 4) {
      return input;
    } else {
      return input.substring(input.length - 4);
    }
  }

  void makeUser(User user) {
    user.name = Validate.capitalizeFirstLetter(user.name);
    user.surname = Validate.capitalizeFirstLetter(user.surname);
    user.role = Validate.capitalizeFirstLetter(user.role);
    user.workPlace = Validate.capitalizeFirstLetter(user.workPlace);
    user.password = user.name + getLastFourCharacters(user.phoneNumber);
  }
}
