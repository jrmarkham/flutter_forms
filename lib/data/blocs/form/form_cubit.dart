
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../mixins/form_validation.dart';
import '../../models/form_field/form_field_element.dart';

part 'form_state.dart';

class FormCubit extends Cubit<FormCubitStateModel> with FormValidationMixin {
  FormCubit({required String initName, required List<FormElement> initElements})
      : super(FormCubitStateModel.initializeForm(initName: initName, initElements: List.unmodifiable(initElements.toList()))) {
    _initForm();
  }

  void resetBloc({required List<FormElement> resetElements}) {
    emit(state
        .copyWith(updateFlowState: FormFlowState.formBlocStateFirstLoaded, updateElements: List.unmodifiable(resetElements.toList()), updateVerified: false));
    _initForm();
  }

  void updateChangeState({required int idx, required bool focus}) async {
    final FormElement element = state.formElements[idx];
    if(element.dataElement.text.toString().isEmpty) return;
    if (!focus && !element.showError) {
      for (FormElement element in state.formElements) {
        // check validation on required fields //
        if (element.isRequiredField && element.needsListener) {
          element.dataElement.removeListener(() {
            _addFormListener(element);
          });
        }
      }

      final List<FormElement> update = List.unmodifiable(state.formElements.toList()..replaceRange(element.index, element.index + 1, [element.copyWith(newShowError: true)]));
      emit(state.copyWith(
        updateFlowState: FormFlowState.formBlocStateLoaded,
        updateElements: update,
        updateVerified: !update.any((FormElement element) => element.state != FieldState.valid && element.isRequiredField),
      ));
      for (FormElement element in state.formElements) {
        // check validation on required fields //
        if (element.isRequiredField && element.needsListener) {
          element.dataElement.addListener(() {
            _addFormListener(element);
          });
        }
      }
    }
  }

  toggleCheckBoxItem({required int groupIndex, required int cbIndex}) async {
    final FormElement element = state.formElements[groupIndex];
    final List<CheckboxItemElement> checkboxes = element.checkboxes;
    final CheckboxItemElement cbItem = checkboxes[cbIndex].toggleSelected();
    checkboxes.replaceRange(cbIndex, cbIndex + 1, [cbItem]);
    element.copyWith(newCheckboxes: checkboxes);
    // check state for check boxes //
    final bool isValid = !element.isRequiredField || await isFieldValid(element.copyWith(newCheckboxes: checkboxes));
    // update state for check box
    final List<FormElement> update = List.unmodifiable(state.formElements.toList()
      ..replaceRange(element.index, element.index + 1, [element.copyWith(newCheckboxes: checkboxes, newState: isValid ? FieldState.valid : FieldState.invalid)]));
    emit(state.copyWith(
      updateFlowState: FormFlowState.formBlocStateLoaded,
      updateElements: update,
      updateVerified: !update.any((FormElement element) => element.state != FieldState.valid && element.isRequiredField),
    ));
  }

  // clean up remove controllers
  void disposeForm() {
    for (FormElement element in state.formElements) {
      // dispose on dataElement which is a form controller
      element.dataElement.dispose();
    }
  }

  void selectDropdownItem({required int dropIndex, required String updateValue}) async {
    final FormElement element = state.formElements[dropIndex];
    final List<FormElement> update = List.unmodifiable(state.formElements.toList()..replaceRange(element.index, element.index + 1, [element.copyWith(newDataElement: updateValue, newState: FieldState.valid)]));

    emit(state.copyWith(
      updateFlowState: FormFlowState.formBlocStateLoaded,
      updateElements: update,
      updateVerified: !update.any((FormElement element) => element.state != FieldState.valid && element.isRequiredField),
    ));
  }

  void _initForm() {
    _processForm();
    _firstCheck();
  }

  void _processForm() {
    emit(state.copyWith(updateFlowState: FormFlowState.formBlocStateFirstLoaded));

    // attach  listener to elements assumption elements are all text fields//
    for (FormElement element in state.formElements) {
      if (element.startValue.isNotEmpty && element.needsListener) {
        element.dataElement.text = element.startValue;
      }

      // check validation on required fields //
      if (element.isRequiredField && element.needsListener) {
        element.dataElement.addListener(() {
          _addFormListener(element);
        });
      }
    }
  }

  // check verification on first load
  void _firstCheck() async {
    bool allVerified = true;
    int idx = 0;

    do {
      FormElement elem = state.formElements[idx];
      if (elem.isRequiredField) {
        if (elem.isRequiredUpdate || isFieldEmpty(elem) || !await isFieldValid(elem)) {
          allVerified = false;
        }
      }
      idx++;
    } while (allVerified && idx < state.formElements.length);

    emit(state.copyWith(updateFlowState: FormFlowState.formBlocStateLoaded, updateElements: state.formElements, updateVerified: allVerified));
  }

  // listener for validation on text controller changes
  void _addFormListener(FormElement formField) async {
    final FormElement element = formField;

    // do verification
    // set default status to invalid
    FieldState updateFieldState = FieldState.invalid;

    // CHECKS
    // check empty
    if (isFieldEmpty(element)) updateFieldState = FieldState.empty;

    // check if original value and change is required
    if (updateFieldState == FieldState.invalid && element.isRequiredUpdate && isFieldUnchanged(element)) updateFieldState = FieldState.unchanged;
    // finally check is valid //
    if (updateFieldState == FieldState.invalid && await isFieldValid(element)) updateFieldState = FieldState.valid;



    //POST UPDATE STATE if field is set to constant refresh should be off most of the time //
    if (updateFieldState == FieldState.valid && element.isConstantRefresh) {
      emit(state.copyWith(updateFlowState: FormFlowState.formBlocStateValueUpdate, updateIndex: element.index, updateValue: element.dataElement.text));
    }

    // update list w/ changes from element update
    final List<FormElement> update = List.unmodifiable(state.formElements.toList()..replaceRange(element.index, element.index + 1, [element
        .copyWith(newState: updateFieldState)]));
    // emit update list w/ all verified check

    emit(state.copyWith(
      updateFlowState: FormFlowState.formBlocStateLoaded,
      updateElements: update,
      updateVerified: !update.any((FormElement element) => element.state != FieldState.valid && element.isRequiredField)),
    );
  }
}