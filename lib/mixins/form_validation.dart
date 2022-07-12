import '../utils/reg_ex_util.dart' as reg_ex_util;
import '../data/models/form_field/form_field_element.dart';

mixin FormValidationMixin {
  bool isFieldEmpty(FormElement element) => element.dataElement.text == null || element.dataElement.text.isEmpty;

  bool isFieldUnchanged(FormElement element) => element.dataElement.text == element.startValue ? false : true;

  Future<bool> isFieldValid(FormElement element) async {
    switch (element.type) {
      case FieldType.textLabel:
      case FieldType.spacer:
      case FieldType.dropdown:
      case FieldType.widget:
        return true;
        case FieldType.firstName:
        return _isFirstNameVerified(element.dataElement.text);
      case FieldType.lastName:
        return _isLastNameVerified(element.dataElement.text);
      case FieldType.checkboxGroup:
        return _isCheckboxGroupVerified(element);
      case FieldType.zipCode:
        return _isZipCodeVerified(element.dataElement.text);
      case FieldType.email:
        return _isEmailNameVerified(element.dataElement.text);
      case FieldType.password:
        return _isPasswordVerified(element.dataElement.text);
    // need checks
      case FieldType.address: return true;
      case FieldType.city: return true;
    }
  }


  // private checkers
  // firstName
  bool _isFirstNameVerified(String currentFirstName) {
    if (currentFirstName.length < FieldType.firstName.getMinLength()) return false;
    if (currentFirstName.length > FieldType.firstName.getMaxLength()) return false;
    return true; //
  }

  // lastName
  bool _isLastNameVerified(String currentLastName) {
    if (currentLastName.length < FieldType.lastName.getMinLength()) return false;
    if (currentLastName.length > FieldType.lastName.getMaxLength()) return false;
    return true; //
  }

  // email
  bool _isEmailNameVerified(String currentEmail) {
    if (currentEmail.length < FieldType.email.getMinLength()) return false;
    if (currentEmail.length > FieldType.email.getMaxLength()) return false;
    return reg_ex_util.regExpEmail.hasMatch(currentEmail); //
  }


  // check through list and see what is selected //
  // check for individual items required //
  bool _isCheckboxGroupVerified(FormElement element) {
    final int selectedCount = element.checkboxes.map((CheckboxItemElement item) => item.isSelected ? 1 : 0).reduce((value, element) => value + element);
    // check against minimum requires
    if (selectedCount < element.minRequiredCheckbox) {
      return false;
    }
    // check against max and that max is not zero for no requirement requires
    if (selectedCount > element.maxRequiredCheckbox && element.maxRequiredCheckbox > 0) {
      return false;
    }

    return !element.checkboxes.any((CheckboxItemElement item) => !item.isSelected && item.isRequired);
  }

  // [password]
  bool _isPasswordVerified(String currentPassword) {
    if (currentPassword.length < FieldType.password.getMinLength()) return false;
    if (currentPassword.length > FieldType.password.getMaxLength()) return false;
    return true;
  }


  // zip
  bool _isZipCodeVerified(String currentZipCode) {
    if (currentZipCode.length < FieldType.zipCode.getMinLength()) return false;
    if (currentZipCode.length > FieldType.zipCode.getMaxLength()) return false;
    // add check for characters allow maybe add regEx no spaces
    return true;
  }
}
