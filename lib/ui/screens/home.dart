import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/blocs/form/form_cubit.dart';
import '../../data/models/form_field/form_field_element.dart';
import '../../utils/form_bloc_util.dart' as form_bloc_utils;


const Duration _duration = Duration(milliseconds: 500);

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(primary: Colors.blue);
    final FormCubit testForm = FormCubit(initName: 'testForm', initElements: form_bloc_utils.defaultForm(addDefault: true, firstName: 'John', lastName: 'Markham'));
    return BlocConsumer<FormCubit, FormCubitStateModel>(
        bloc: testForm,
        listener: (BuildContext context, FormCubitStateModel state) {
          if (state.flowState == FormFlowState.formBlocStateErrorReport) {
            Future.delayed(_duration, ()=> showAlertDialog(context, title: 'alert', message: 'alert'));
          }
        },
        builder: (BuildContext context, FormCubitStateModel state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('::: Dynamic Form :::'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: state.formElements.isNotEmpty
                  ? ListView.builder(
                      itemCount: state.formElements.length,
                      itemBuilder: (BuildContext context, int idx) {
                        final FormElement element = state.formElements[idx] ;

                        final bool isTextField = element.type != FieldType.widget && element.type != FieldType.dropdown && element.type !=
                            FieldType.spacer && element.type != FieldType.checkboxGroup && element.type != FieldType.textLabel;

                        debugPrint('elem name ${element.name} type ${element.type} state ${element.state} ');
                        return isTextField ? SetFormField(
                          formCubit: testForm, element: element): Text(' coming soon  ${element.name} type ${element.type} state ${element
                            .state} ');
                      })
                  : const Text('Form Loading '),
            ),
            bottomNavigationBar: ElevatedButton(
                style: style,
                onPressed: state.allVerified
                    ? () => testForm.resetBloc(resetElements: form_bloc_utils.defaultForm(addDefault: true, firstName: 'Bruce', lastName: 'Wayne'))
                    : null,
                child: const SizedBox(height: 100.0, child: Center(child: Text('submit')))),
          );
        });
  }
}



// FORM FIELDS
// ENUM FUNCTIONS

int getFieldMaxLength(FieldType type) {
  switch (type) {
    case FieldType.email:
      return 50;
    // case FieldType.subject:
    //   return 50;
    // case FieldType.chat:
    //   return 50;
    // case FieldType.body:
    //   return 500;
    // case FieldType.displayName:
    // case FieldType.enemyName:
    default:
      return 25;
  }
}

int getFieldMaxLines(FieldType type) {
  switch (type) {
    // case FieldType.body:
    //   return 5;
    default:
      return 1;
  }
}

int getFieldMinLength(FieldType type) {
  switch (type) {
    case FieldType.email:
      return 6;
    // case FieldType.subject:
    //   return 0;
    // case FieldType.chat:
    //   return 1;
    // case FieldType.body:
    //   return 25;
    // case FieldType.displayName:
    // case FieldType.enemyName:
    default:
      return 2;
  }
}

// TODO: Localize Messages
String getStateText(FieldState fieldState, String label) {
// TODO localization
  switch (fieldState) {
    case FieldState.invalid:
      return 'Invalid $label';
    case FieldState.empty:
      return 'Enter $label';
    case FieldState.unchanged:
      return '$label Not changed';
    case FieldState.valid:
    default:
      return '$label valid';
  }
}

const double corePadding = 25.0;

class SetFormField extends StatelessWidget {
  final FormElement element;
  final FormCubit formCubit;

  const SetFormField({required this.formCubit, required this.element, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String label = element.type.name;
    final String status = getStateText(element.state, label);
    final int max = getFieldMaxLength(element.type);
    final int maxLines = getFieldMaxLines(element.type);
    final bool hint = element.state == FieldState.empty;
    final bool error = element.state == FieldState.invalid && element.isRequiredField && element.showError;

    final FocusScope inputTextField = FocusScope(
         onFocusChange: (bool focus) => formCubit.updateChangeState(idx: element.index, focus: focus),

        child: InputTextField(
        con: element.dataElement,
        input: element.type == FieldType.email ? TextInputType.emailAddress : TextInputType.text,
        label: label,
        maxLen: max,
        hintText: hint ? status : '',
        errorText: error ? status : '',
        maxLines: maxLines));

    return element.useClearField
        ? Padding(
      padding: const EdgeInsets.all(corePadding),
      child: Stack(
        children: [
          inputTextField,
          Align(
              alignment: Alignment.topRight,
              child: AppIconButton(
                icon: Icons.clear,
                function: () => element.dataElement.text = '',
              ))
        ],
      ),
    )
        : inputTextField;
  }
}


class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? function;


  const AppIconButton({required this.icon, this.function, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Icon(icon,
          size: 25.0,
          color: function == null ? Colors.grey : Colors.blue),
    );
  }
}


class InputTextField extends StatelessWidget {
  final TextEditingController con;
  final int maxLen;
  final int maxLines;
  final String label;
  final String hintText;
  final String errorText;
  final TextInputType input;

  const InputTextField(
      {required this.con,
        required this.maxLen,
        required this.maxLines,
        required this.label,
        required this.hintText,
        required this.errorText,
        this.input = TextInputType.text,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: input,
      controller: con,
      maxLength: maxLen,
      maxLines: maxLines,
      textAlign: TextAlign.left,
//       style: bodyTextStyle(),
      decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          errorText: errorText,
          // hintStyle: bodyTextStyle(),
          // labelStyle: labelTextStyle(),
          // helperStyle: bodyTextStyle(),
          // focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: colorMain)


          ) );
  }
}


showAlertDialog(BuildContext context, {required String title, required String message }) {

  // set up the button
  Widget okButton = TextButton(
    child: const Text('OK'),
    onPressed: () => Navigator.of(context).pop(),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
