part of 'form_data_bloc.dart';

abstract class FormDataState extends Equatable {
  const FormDataState();
}

class FormDataStateInit extends FormDataState {
  @override
  List<Object> get props => [];
}

class FormDataStateLoading extends FormDataState {
  @override
  List<Object> get props => [];
}

class FormDataStateLoaded extends FormDataState {
  final bool allVerified;
  final List<FormFieldElementObject> formElements;

  FormDataStateLoaded({@required this.allVerified, @required this.formElements});

  @override
  List<Object> get props => [allVerified, formElements];
}
