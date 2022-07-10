part of 'form_cubit.dart';

// FORM STATE AS MODEL
enum FormFlowState {
  formBlocStateInitial,
  formBlocStateFirstLoaded,
  formBlocStateValueUpdate,
  formBlocStateUpdateDynamicMaxValue,
  formBlocStateErrorReport,
  formBlocStateLoaded,
  formBlocStateRefresh
}
//
@immutable
class FormCubitStateModel {
  final String formName;
  final FormFlowState flowState;
  final List<FormElement> formElements;
  final bool allVerified;
  final dynamic value;
  final int? index;

  const FormCubitStateModel(
      {required this.formName,
        required this.flowState,
        required this.formElements,
        required this.allVerified,
        this.value,
        this.index});

  static FormCubitStateModel initializeForm({required String initName, required List<FormElement> initElements}) => FormCubitStateModel(
      formName: initName,
      flowState: FormFlowState.formBlocStateInitial,
      formElements: initElements,
      allVerified: false);

  FormCubitStateModel copyWith(
      {
        FormFlowState? updateFlowState,
        List<FormElement>? updateElements,
        dynamic updateValue,
        int? updateIndex,
        bool? updateVerified}) =>
      FormCubitStateModel(
          formName: formName,
          flowState: updateFlowState ??  flowState,
          formElements: updateElements ?? formElements,
          index: updateIndex ?? index,
          value: updateValue ?? value,
          allVerified: updateVerified ?? allVerified);
}
