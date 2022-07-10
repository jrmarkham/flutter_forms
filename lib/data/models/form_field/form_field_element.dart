import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum FieldType { firstName, lastName, email, address, city, zipCode, checkboxGroup, dropdown, password, textLabel, widget, spacer;

  int getMinLength() {
    switch (this) {
      case FieldType.firstName:
        return 2;
      case FieldType.lastName:
        return 2;
      case FieldType.email:
        return 5;
      case FieldType.zipCode:
        return 5;
      case FieldType.address:
        return 3;
      case FieldType.city:
        return 3;
      case FieldType.password:
        return 6;


    // length does apply

      case FieldType.dropdown:
      case FieldType.checkboxGroup:
      case FieldType.textLabel:
      case FieldType.spacer:
      case FieldType.widget:
        return 0;
    }
  }

  int getMaxLength() {
    switch (this) {
      case FieldType.firstName:
        return 20;
      case FieldType.lastName:
        return 25;
      case FieldType.email:
        return 50;
      case FieldType.zipCode:
        return 5;

      case FieldType.address: return 30;
      case FieldType.password:
        return 15;

      case FieldType.city:
        return 20;


      case FieldType.dropdown:
      case FieldType.checkboxGroup:
      case FieldType.textLabel:
      case FieldType.spacer:
      case FieldType.widget:
        return 0;
    }
  }

  String getInvalidError() {
    switch (this) {
      case FieldType.firstName:
        return 'Error';
      case FieldType.lastName:
        return 'Error';
      case FieldType.email:
        return 'Error';
      case FieldType.zipCode:
        return 'Error';
      case FieldType.checkboxGroup:
        return 'Error';
      case FieldType.password:return 'Error';
      case FieldType.city:return 'Error';
      case FieldType.address:
        return 'Error';
    // not necessary
      case FieldType.dropdown:
      case FieldType.textLabel:
      case FieldType.spacer:
      case FieldType.widget:
        return 'Error';

    }
  }

}

enum FieldState { valid, empty, invalid, unchanged }

enum FieldReportError { tooLow, tooHigh, empty, invalid, unchanged, applePay, eftPayment, cardPayment }

// create models for global types -- text fields / dropdown / radio / checkbox group /
@immutable
class FormElement extends Equatable {
  // core props
  final int index;
  final String name;
  final String? label;

  // use to to coordinate validation logic
  final FieldType type;
  final FieldState state;

  // error reporting state
  final bool showError;

  // the text editor controller where the value gets updated //
  // left dynamic so it could be other form elements
  final dynamic dataElement;

  // controls and validation props
  final bool needsListener;
  final bool isRequiredField;
  final bool isRequiredUpdate;
  final bool isConstantRefresh;
  final bool useClearField;

  // fields for the starting value
  final dynamic startValue;

  // particular fields //
  final dynamic bannedValue;

  // check box group
  final List<CheckboxItemElement> checkboxes;
  final int maxRequiredCheckbox;
  final int minRequiredCheckbox;

  // dropbox item
  final List<DropdownElementItem> dropdownElementItems;

  const FormElement(
      {required this.index,
      required this.name,
      required this.type,
      required this.state,
      required this.showError,
      required this.dataElement,
      required this.checkboxes,
      required this.dropdownElementItems,
      required this.maxRequiredCheckbox,
      required this.minRequiredCheckbox,
      required this.needsListener,
      required this.isRequiredField,
      required this.isRequiredUpdate,
      required this.isConstantRefresh,
      required this.useClearField,
      required this.startValue,
      required this.bannedValue,
      this.label = ''});

  FormElement copyWith(
          {FieldState? newState,
          bool? newShowError,
          List<CheckboxItemElement>? newCheckboxes,
          dynamic newDataElement,
          String? setLabel,
          bool? newUseClearField}) =>
      FormElement(
          index: index,
          name: name,
          type: type,
          label: setLabel ?? label,
          state: newState ?? state,
          showError: newShowError ?? showError,
          dataElement: newDataElement ?? dataElement,
          checkboxes: newCheckboxes ?? checkboxes,
          dropdownElementItems: dropdownElementItems,
          needsListener: needsListener,
          isRequiredField: isRequiredField,
          isRequiredUpdate: isRequiredUpdate,
          maxRequiredCheckbox: maxRequiredCheckbox,
          minRequiredCheckbox: minRequiredCheckbox,
          isConstantRefresh: isConstantRefresh,
          useClearField: newUseClearField ?? true,
          startValue: startValue,
          bannedValue: bannedValue);

  @override
  List<Object?> get props =>
      [index, name, label, type, state, showError, dataElement, isRequiredField, isRequiredUpdate, isConstantRefresh, startValue, bannedValue];

  static FieldState _getStartingTextFieldState({required bool isRequiredField, required bool isRequiredUpdate, required String startVal}) =>
      isRequiredField == false
          ? FieldState.valid
          : startVal.isEmpty == true
              ? FieldState.empty
              : isRequiredUpdate == true
                  ? FieldState.unchanged
                  : FieldState.valid;

  static FormElement firstName(
          {required int index, bool? isRequiredField, bool? isRequiredUpdate, bool? isConstantRefresh, dynamic startVal = '', String? setLabel}) =>
      FormElement(
          index: index,
          name: 'name',
          type: FieldType.firstName,
          label: setLabel,
          state:
              _getStartingTextFieldState(isRequiredField: isRequiredField ?? true, isRequiredUpdate: isRequiredUpdate ?? false, startVal: startVal),
          showError: false,
          dataElement: TextEditingController(),
          checkboxes: const [],
          dropdownElementItems: const [],
          maxRequiredCheckbox: 0,
          minRequiredCheckbox: 0,
          needsListener: true,
          isRequiredField: isRequiredField ?? true,
          isRequiredUpdate: isRequiredUpdate ?? false,
          isConstantRefresh: isConstantRefresh ?? false,
          useClearField: true,
          startValue: startVal,
          bannedValue: '');

  static FormElement lastName(
          {required int index, bool? isRequiredField, bool? isRequiredUpdate, bool? isConstantRefresh, dynamic startVal = '', String? setLabel}) =>
      FormElement(
          index: index,
          name: 'name',
          type: FieldType.lastName,
          label: setLabel,
          state:
              _getStartingTextFieldState(isRequiredField: isRequiredField ?? true, isRequiredUpdate: isRequiredUpdate ?? false, startVal: startVal),
          showError: false,
          dataElement: TextEditingController(),
          checkboxes: const [],
          dropdownElementItems: const [],
          maxRequiredCheckbox: 0,
          minRequiredCheckbox: 0,
          needsListener: true,
          isRequiredField: isRequiredField ?? true,
          isRequiredUpdate: isRequiredUpdate ?? false,
          isConstantRefresh: isConstantRefresh ?? false,
          useClearField: true,
          startValue: startVal,
          bannedValue: '');

  static FormElement email(
          {required int index, bool? isRequiredField, bool? isRequiredUpdate, bool? isConstantRefresh, dynamic startVal = '', String? setLabel}) =>
      FormElement(
          index: index,
          name: 'name',
          type: FieldType.email,
          label: setLabel,
          state:
              _getStartingTextFieldState(isRequiredField: isRequiredField ?? true, isRequiredUpdate: isRequiredUpdate ?? false, startVal: startVal),
          showError: false,
          dataElement: TextEditingController(),
          checkboxes: const [],
          dropdownElementItems: const [],
          maxRequiredCheckbox: 0,
          minRequiredCheckbox: 0,
          needsListener: true,
          isRequiredField: isRequiredField ?? true,
          isRequiredUpdate: isRequiredUpdate ?? false,
          isConstantRefresh: isConstantRefresh ?? false,
          useClearField: true,
          startValue: startVal,
          bannedValue: '');

  static FormElement zipCode(
          {required int index, bool? isRequiredField, bool? isRequiredUpdate, bool? isConstantRefresh, dynamic startVal = '', String? setLabel}) =>
      FormElement(
          index: index,
          name: 'name',
          type: FieldType.zipCode,
          label: setLabel,
          state:
              _getStartingTextFieldState(isRequiredField: isRequiredField ?? true, isRequiredUpdate: isRequiredUpdate ?? false, startVal: startVal),
          showError: false,
          dataElement: TextEditingController(),
          checkboxes: const [],
          dropdownElementItems: const [],
          maxRequiredCheckbox: 0,
          minRequiredCheckbox: 0,
          needsListener: true,
          isRequiredField: isRequiredField ?? true,
          isRequiredUpdate: isRequiredUpdate ?? false,
          isConstantRefresh: isConstantRefresh ?? false,
          useClearField: true,
          startValue: startVal,
          bannedValue: '');

  static FormElement address(
          {required int index, bool? isRequiredField, bool? isRequiredUpdate, bool? isConstantRefresh, dynamic startVal = '', String? setLabel}) =>
      FormElement(
          index: index,
          name: 'name',
          type: FieldType.address,
          label: setLabel,
          state:
              _getStartingTextFieldState(isRequiredField: isRequiredField ?? true, isRequiredUpdate: isRequiredUpdate ?? false, startVal: startVal),
          showError: false,
          dataElement: TextEditingController(),
          checkboxes: const [],
          dropdownElementItems: const [],
          maxRequiredCheckbox: 0,
          minRequiredCheckbox: 0,
          needsListener: true,
          isRequiredField: isRequiredField ?? true,
          isRequiredUpdate: isRequiredUpdate ?? false,
          isConstantRefresh: isConstantRefresh ?? false,
          useClearField: true,
          startValue: startVal,
          bannedValue: '');

  static FormElement city(
          {required int index, bool? isRequiredField, bool? isRequiredUpdate, bool? isConstantRefresh, dynamic startVal = '', String? setLabel}) =>
      FormElement(
          index: index,
          name: 'name',
          type: FieldType.city,
          label: setLabel,
          state:
              _getStartingTextFieldState(isRequiredField: isRequiredField ?? true, isRequiredUpdate: isRequiredUpdate ?? false, startVal: startVal),
          showError: false,
          dataElement: TextEditingController(),
          checkboxes: const [],
          dropdownElementItems: const [],
          maxRequiredCheckbox: 0,
          minRequiredCheckbox: 0,
          needsListener: true,
          isRequiredField: isRequiredField ?? true,
          isRequiredUpdate: isRequiredUpdate ?? false,
          isConstantRefresh: isConstantRefresh ?? false,
          useClearField: true,
          startValue: startVal,
          bannedValue: '');

  // dummy text fields for labels and info
  // for static text to drop into a form
  static FormElement textLabel({required int index, required String startVal}) => FormElement(
      index: index,
      name: 'name',
      type: FieldType.textLabel,
      state: FieldState.valid,
      showError: false,
      dataElement: null,
      checkboxes: const [],
      dropdownElementItems: const [],
      maxRequiredCheckbox: 0,
      minRequiredCheckbox: 0,
      needsListener: false,
      isRequiredField: false,
      isRequiredUpdate: false,
      isConstantRefresh: false,
      useClearField: true,
      startValue: startVal,
      bannedValue: '');

  static FormElement spacer({required int index}) => FormElement(
      index: index,
      name: 'name',
      type: FieldType.textLabel,
      state: FieldState.valid,
      showError: false,
      dataElement: null,
      checkboxes: const [],
      dropdownElementItems: const [],
      maxRequiredCheckbox: 0,
      minRequiredCheckbox: 0,
      needsListener: false,
      isRequiredField: false,
      isRequiredUpdate: false,
      isConstantRefresh: false,
      useClearField: true,
      startValue: '',
      bannedValue: '');

  static FormElement widget({required int index, required Widget widget}) => FormElement(
      index: index,
      name: 'name',
      type: FieldType.widget,
      state: FieldState.valid,
      showError: false,
      dataElement: widget,
      checkboxes: const [],
      dropdownElementItems: const [],
      maxRequiredCheckbox: 0,
      minRequiredCheckbox: 0,
      needsListener: false,
      isRequiredField: false,
      isRequiredUpdate: false,
      isConstantRefresh: false,
      useClearField: true,
      startValue: '',
      bannedValue: '');

  static FormElement checkboxGroup(
          {required int index,
          required List<CheckboxItemElement> checkboxes,
          required int minRequiredCheckbox,
          required int maxRequiredCheckbox,
          String? setLabel,
          bool? isRequiredField,
          FieldState? startingFieldState}) =>
      FormElement(
          index: index,
          name: 'name',
          type: FieldType.checkboxGroup,
          label: setLabel,
          checkboxes: checkboxes,
          dropdownElementItems: const [],
          maxRequiredCheckbox: maxRequiredCheckbox,
          minRequiredCheckbox: minRequiredCheckbox,
          needsListener: false,
          // will update on first pass in form bloc
          state: startingFieldState ?? FieldState.invalid,
          showError: false,
          // ignored
          dataElement: null,
          isRequiredField: isRequiredField ?? true,
          isRequiredUpdate: false,
          isConstantRefresh: false,
          useClearField: true,
          startValue: '',
          bannedValue: '');

  // NON TEXT FIELD
  static FormElement dropdown({
    required int index,
    required List<DropdownElementItem> items,
    String? name,
    String? setLabel,
    DropdownElementItem? selectedItem,
  }) =>
      FormElement(
          index: index,
          name: name ?? 'drops',
          type: FieldType.dropdown,
          label: setLabel,
          state: selectedItem == null ? FieldState.invalid : FieldState.valid,
          showError: false,
          dataElement: selectedItem,
          checkboxes: const [],
          dropdownElementItems: items,
          maxRequiredCheckbox: 0,
          minRequiredCheckbox: 0,
          needsListener: false,
          isRequiredField: false,
          isRequiredUpdate: false,
          isConstantRefresh: false,
          useClearField: true,
          startValue: '',
          bannedValue: '');
}

// class checkbox elements
@immutable
class CheckboxItemElement {
  final String label;
  final int index;
  final String name;
  final bool isSelected;
  final bool isRequired;

  const CheckboxItemElement({required this.index, required this.name, required this.label, required this.isRequired, required this.isSelected});

  CheckboxItemElement toggleSelected() =>
      CheckboxItemElement(index: index, name: name, label: label, isRequired: isRequired, isSelected: isSelected ? false : true);
}

@immutable
class DropdownElementItem {
  final String label;
  final String value;

  const DropdownElementItem({required this.label, required this.value});
}
