import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_bloc/enums.dart';
import 'package:form_bloc/form_data/form_data_bloc.dart';
import 'package:form_bloc/form_element_object.dart';

import '../form_elements.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  FormDataBloc _formDataBloc;

  @override
  void initState() {
    // TODO: implement initState

    _formDataBloc = BlocProvider.of<FormDataBloc>(context);

    // generate w/ json and current data from firebase
    // firebase setting the initial values


    final List<FormFieldElementObject> _formFields = [];
    _formFields.add(FormFieldElementObject(
        id: 'first',
        index: 0,
        fieldType: FieldType.FirstName,
        fieldState: FieldState.Valid,
        requiredField: true,
        startingValue: 'John',
        dataElement: TextEditingController()));
    _formFields.add(FormFieldElementObject(
        id: 'last',
        index: 1,
        fieldType: FieldType.LastName,
        fieldState: FieldState.Empty,
        requiredField: true,
        startingValue: null,
        dataElement: TextEditingController()));
    _formFields.add(FormFieldElementObject(
        id: 'email',
        index: 2,
        fieldType: FieldType.Email,
        fieldState: FieldState.Empty,
        requiredField: true,
        startingValue: null,
        dataElement: TextEditingController()));
    // _formFields.add(FormFieldElementObject(
    //     id: 'lang',
    //     index: 3,
    //     fieldType: FieldType.LanguageArray,
    //     fieldState: FieldState.Empty,
    //     requiredField: false,
    //     startingValue: [LanguageEnum.English],
    //     dataElement: []));
    // _formFields.add(FormFieldElementObject(
    //     id: 'contact',
    //     index: 4,
    //     fieldType: FieldType.ContactArray,
    //     fieldState: FieldState.Empty,
    //     requiredField: false,
    //     startingValue: [],
    //     dataElement: []));
    _formDataBloc.add(FormDataSetFormFieldsEvent(_formFields));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('FORM FUN'),
              BlocBuilder<FormDataBloc, FormDataState>(
                cubit: _formDataBloc,
                builder: (context, state) {
                  if (state is FormDataStateLoaded) {
                    final Function submit =state.allVerified ?  ()=> _formDataBloc.add(FormDataSubmitFormEvent()):null;
                    return Column(
                      children: [
                        Text('STATE ${state.toString()}'),

                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.formElements.length,
                            itemBuilder: (BuildContext context, int idx) {
                              final FormFieldElementObject _formElementObject =
                                  state.formElements[idx];
                              //
                              // if(_formElementObject.fieldType == FieldType.LanguageArray)return addLanguage(_formElementObject);
                              // if(_formElementObject.fieldType == FieldType.ContactArray)return addContact(_formElementObject);
                              return setFormField(_formElementObject);
                            }),

                        RaisedButton(
                          onPressed: submit,
                          color: submit != null ? Colors.red: Colors.grey,
                          child: Text(
                            'submit',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    );
                  }

                  return CircularProgressIndicator();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
