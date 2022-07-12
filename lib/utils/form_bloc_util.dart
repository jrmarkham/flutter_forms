

  import '../data/models/form_field/form_field_element.dart';
import '../data/models/form_field/form_name_key_constants.dart';

List<FormElement> defaultForm({String? firstName, String? lastName, FieldState? cbGroupStartingFieldState, bool addDefault = false}) {
    List<FormElement> elements = [];
    elements.add(FormElement.firstName(index: elements.length, startVal: firstName, isRequiredField: true));
    elements.add(FormElement.lastName(index: elements.length, startVal: lastName, isRequiredField: true));
    elements.add(FormElement.email(index: elements.length, isRequiredField: true));
    elements.add(FormElement.zipCode(index: elements.length, isRequiredField: true));

    elements.add(FormElement.spacer(index: elements.length));
     elements.add(FormElement.checkboxGroup(
        index: elements.length,
        startingFieldState: cbGroupStartingFieldState,
        checkboxes: [
          const CheckboxItemElement(index: 0, isRequired: true, isSelected: false, label: 'authorized your payment', name:'required'),
          if (addDefault) const CheckboxItemElement(index: 0, name: 'test', isRequired: false, isSelected: false, label: 'default')
        ],
        maxRequiredCheckbox: 0,
        minRequiredCheckbox: 0));
    elements.add(FormElement.textLabel(index: elements.length, startVal: '=========================='));

    elements.add(FormElement.textLabel(index: elements.length, startVal: ' Pick at least 2 items but no more than four'));


    elements.add(FormElement.checkboxGroup(
        index: elements.length,
        startingFieldState: cbGroupStartingFieldState,
        checkboxes: [
          CheckboxItemElement(index: 0, isRequired: false, isSelected: false, label: 'Zero', name: CBNameConst.item0),
          CheckboxItemElement(index: 1, isRequired: false, isSelected: false, label: 'One', name: CBNameConst.item1),
          CheckboxItemElement(index: 2, isRequired: false, isSelected: false, label: 'Two', name: CBNameConst.item2),
          CheckboxItemElement(index: 3, isRequired: false, isSelected: false, label: 'Three', name: CBNameConst.item3),
          CheckboxItemElement(index: 4, isRequired: false, isSelected: false, label: 'Four', name: CBNameConst.item4),
          CheckboxItemElement(index: 5, isRequired: false, isSelected: false, label: 'Five', name: CBNameConst.item5),
          CheckboxItemElement(index: 6, isRequired: false, isSelected: false, label: 'Six', name: CBNameConst.item6),
          CheckboxItemElement(index: 7, isRequired: false, isSelected: false, label: 'Seven', name: CBNameConst.item7),
          CheckboxItemElement(index: 8, isRequired: false, isSelected: false, label: 'Eight', name: CBNameConst.item8),
          CheckboxItemElement(index: 9, isRequired: false, isSelected: false, label: 'Nine', name: CBNameConst.item9),
          CheckboxItemElement(index: 10, isRequired: false, isSelected: false, label: 'Ten', name: CBNameConst.item10),
          CheckboxItemElement(index: 11, isRequired: false, isSelected: false, label: 'Eleven', name: CBNameConst.item11),
        ],
        maxRequiredCheckbox: 4,
        minRequiredCheckbox: 2));


    return elements;
  }

  FormElement? getFormElementFromListByIndex({required List<FormElement> elements, required int idx}) => elements[idx];

  FormElement? getFormElementFromListByName({required List<FormElement> elements, required String findName}) =>
      elements.singleWhere((FormElement elem) => elem.name == findName);

  // TEXT FIELD RETURN
  String getTextFieldStringFromIndex({required List<FormElement> elements, required int idx}) => elements[idx].dataElement.text.toString().trim();

  String getTextFieldStringFromName({required List<FormElement> elements, required String name}) =>
      elements.singleWhere((FormElement element) => element.name == name).dataElement.text.toString().trim();

  // CHECK BOX GROUP RETURN
  List<CheckboxItemElement> getSelectedCheckboxItemFromIndex({required List<FormElement> elements, required int idx}) =>
      elements[idx].checkboxes.where((CheckboxItemElement cbe) => cbe.isSelected).toList();

  List<CheckboxItemElement> getSelectedCheckboxItemFromName({required List<FormElement> elements, required String name}) =>
      elements.singleWhere((FormElement element) => element.name == name).checkboxes.where((CheckboxItemElement cbe) => cbe.isSelected).toList();

  bool getSelectedByCBIndexFromGroupIndex({required List<FormElement> elements, required int groupIdx, required int cbIdx}) =>
      elements[groupIdx].checkboxes[cbIdx].isSelected;

  bool getSelectedByCBNameFromGroupIndex({required List<FormElement> elements, required int groupIdx, required String cbName}) =>
      elements[groupIdx].checkboxes.singleWhere((CheckboxItemElement cbe) => cbe.name == cbName).isSelected;

  bool getSelectedByCBIndexFromGroupName({required List<FormElement> elements, required String groupName, required int cbIdx}) =>
      elements.singleWhere((FormElement element) => element.name == groupName).checkboxes[cbIdx].isSelected;

  bool getSelectedByCBNameFromGroupName({required List<FormElement> elements, required String groupName, required String cbName}) =>
      elements.singleWhere((FormElement element) => element.name == groupName).checkboxes.singleWhere((CheckboxItemElement cbe) => cbe.name == cbName).isSelected;

// RADIO ITEM RETURN
// DROPDOWN ITEM RETURN


