
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_bloc/enums.dart';

class FormFieldElementObject extends Equatable{
    final String id;
    final int index;
    final FieldType fieldType;
    final FieldState fieldState;
    final bool requiredField;
    final dynamic startingValue;
    final dynamic dataElement;

  FormFieldElementObject({@required this.id, @required this.index, @required this.fieldType, @required this.fieldState, @required this.requiredField, @required this.startingValue, @required this.dataElement});

  @override
  // TODO: implement props
  List<Object> get props => [id, index, fieldType, fieldState, requiredField, dataElement];
}