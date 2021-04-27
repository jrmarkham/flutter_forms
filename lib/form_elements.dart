import 'package:flutter/material.dart';
import 'package:form_bloc/enums.dart';
import 'form_element_object.dart';

TextStyle _getStyle(bool error) =>
    TextStyle(color: error ? Colors.red : Colors.black);

Widget setFormField(FormFieldElementObject fieldElementObject) {
  final TextStyle _textStyle =
      _getStyle(fieldElementObject.fieldState == FieldState.Invalid);
  final String _label = getFieldName(fieldElementObject.fieldType);
  final String _status = getStateText(fieldElementObject.fieldState, _label);
  return Column(
    children: [
      Text('$_label:'),
      TextField(
          maxLines: 1,
          maxLength: 50,
          // get via enum type
          controller: fieldElementObject.dataElement,
          style: _textStyle,
          decoration:
              InputDecoration(hintText: _label, helperStyle: _textStyle)),
      if (fieldElementObject.requiredField) Text(_status, style: _textStyle),
      SizedBox(height: 15)
    ],
  );
}

Widget _getUserLanguageList(List<LanguageEnum> list){
  if(list.isEmpty)return Text('Select a Language');

  return RaisedButton(
    child: Text('Review Selected Languages'),
    onPressed: ()=> debugPrint('open lang list'),
  );
}


Widget addLanguage(FormFieldElementObject fieldElementObject) {
  // add button for popup that list available languages
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Flexible(flex: 1, child: Container()),
      Flexible(flex: 12, child: _getUserLanguageList(fieldElementObject.dataElement)),
      Flexible(flex: 1, child: Container()),
      Flexible(
        flex: 6,
        child: RaisedButton(
          onPressed: () => debugPrint('add lang'),
          color: Colors.blue,
          child: Text(
            'add lang',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      Flexible(flex: 1, child: Container()),
    ],
  );
}

Widget addContact(FormFieldElementObject fieldElementObject) {
  // add button for popup that list available languages
  return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(flex: 1, child: Container()),
        Flexible(flex: 12, child: Text('CURRENT CONTACT LIST ')),
        Flexible(flex: 1, child: Container()),
        Flexible(
          flex: 6,
          child: RaisedButton(
            onPressed: () => debugPrint('add contact'),
            color: Colors.green,
            child: Text(
              '+ contact',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Flexible(flex: 1, child: Container()),
      ]);
}



//
// TextField(
// controller: this._emailController,
// style: TextStyle(
// color: this._hasEmailError(state)
// ? Colors.red
//     : Colors.black,
// ),
// decoration: InputDecoration(
// hintText: 'Email',
// labelStyle: TextStyle(
// color: this._hasEmailError(state)
// ? Colors.red
//     : Colors.black,
// ),
// hintStyle: TextStyle(
// color: this._hasEmailError(state)
// ? Colors.red
//     : Colors.black,
// ),
// enabledBorder: this._renderBorder(state),
// focusedBorder: this._renderBorder(state),
// ),
// ),
// if (this._hasEmailError(state)) ...[
// SizedBox(height: 5),
// Text(
// this._emailErrorText(state.emailError),
// style: TextStyle(color: Colors.red),
// ),
// ],
