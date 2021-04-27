part of 'form_data_bloc.dart';

abstract class FormDataEvent extends Equatable {
  const FormDataEvent();
}


class FormDataCheckValidationEvent extends FormDataEvent {
  final String email;
  FormDataCheckValidationEvent(this.email);
  @override
  List<Object> get props => [email];
}


class FormDataSetFormFieldsEvent extends FormDataEvent {
  final List<FormFieldElementObject> eventList;
  FormDataSetFormFieldsEvent(this.eventList);

  @override
  List<Object> get props => [eventList];
}


class FormDataAddLanguageEvent extends FormDataEvent {
  final LanguageEnum language;
  FormDataAddLanguageEvent(this.language);

  @override
  List<Object> get props => [language];
}
class FormDataRemoveLanguageEvent extends FormDataEvent {
  final int index;
  FormDataRemoveLanguageEvent(this.index);
  @override
  List<Object> get props => [index];
}

class FormDataAddContactEvent extends FormDataEvent {
  // final LanguageEnum language;
  // FormDataAddLanguageEvent(this.language);

  @override
  List<Object> get props => [];
}

class FormDataRemoveContactEvent extends FormDataEvent {
   final int index;
   FormDataRemoveContactEvent(this.index);
  @override
  List<Object> get props => [index];
}


class FormDataListenEvent extends FormDataEvent {
  final FormFieldElementObject formField;
  FormDataListenEvent(this.formField);

  @override
  List<Object> get props => [formField];
}


class FormDataUpdateElementEvent extends FormDataEvent {
  final FormFieldElementObject formField;
  FormDataUpdateElementEvent(this.formField);

  @override
  List<Object> get props => [formField];
}

class FormDataRefreshEvent extends FormDataEvent {
  // final String email;
  // FormDataSubmitFormEvent(this.email);
  @override
  List<Object> get props => [];
}

class FormDataSubmitFormEvent extends FormDataEvent {
  // final String email;
  // FormDataSubmitFormEvent(this.email);
  @override
  List<Object> get props => [];
}