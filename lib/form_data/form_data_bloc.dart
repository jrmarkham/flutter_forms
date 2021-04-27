import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:form_bloc/enums.dart';
import 'package:form_bloc/form_element_object.dart';

import '../validation_mixin.dart';

part 'form_data_event.dart';

part 'form_data_state.dart';

class FormDataBloc extends Bloc<FormDataEvent, FormDataState>
    with FormValidationMixin {
  FormDataBloc() : super(FormDataStateInit());

  final List<FormFieldElementObject> _formElements = [];

  @override
  Stream<FormDataState> mapEventToState(
    FormDataEvent event,
  ) async* {
    if (event is FormDataSetFormFieldsEvent) {
      //yield FormDataStateLoading();
      //event.

      debugPrint('event ${event.eventList}');
      event.eventList.forEach((element) => _formElements.add(element));
      _formElements.forEach((element) {

        if(element.fieldType == FieldType.LanguageArray){
          return;
        }
        if(element.fieldType == FieldType.ContactArray){
          return;
        }

        element.dataElement.text = element.startingValue;
        element.dataElement.addListener(() {
          add(FormDataListenEvent(element));
        });
      });

     add(FormDataRefreshEvent());
    }

    if (event is FormDataListenEvent) {


      //
      FieldState updateFieldState = FieldState.Invalid;
      // CHECK VALIDATION AND UPDATE
      if (this.isFieldEmpty(event.formField.dataElement.text)) {
        updateFieldState = FieldState.Empty;
      } else if (this.isFieldValid(
          event.formField.dataElement.text, event.formField.fieldType)) {
        updateFieldState = FieldState.Valid;
      }
       _formElements.replaceRange(event.formField.index, event.formField.index+1, [
      FormFieldElementObject(
              id: event.formField.id,
              index: event.formField.index,
          dataElement: event.formField.dataElement,
              requiredField: event.formField.requiredField,
              fieldState: updateFieldState,
              fieldType: event.formField.fieldType,
              startingValue: event.formField.startingValue)
        ]);
        add(FormDataRefreshEvent());
    }

    if (event is FormDataRefreshEvent) {
      yield FormDataStateLoading();
      // check form
      // bool allVerified = !_formElements.any((element) =>
      //     (element.requiredField && element.fieldState != FieldState.Valid));
      // debugPrint('allVerified $allVerified');

      //await Future.delayed(Duration(seconds: 2), () => debugPrint('test'));
      // update form from verification
      // if all good // --> listener will redirect
      // errors -- update fields accordingly
      yield FormDataStateLoaded(
          allVerified: !_formElements.any((element) =>
          (element.requiredField && element.fieldState != FieldState.Valid)), formElements: _formElements);
    }
  }
}
