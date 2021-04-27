
import 'package:flutter/material.dart';
import 'package:form_bloc/enums.dart';

const String _EMAIL_REG_EXP =
    r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";

mixin FormValidationMixin{

    bool isFieldEmpty(String field) => field?.isEmpty ?? true;

    bool isFieldValid(String field, FieldType type ){
        switch (type){
            case FieldType.FirstName: return _validFirstName(field);
            case FieldType.LastName: return _validLastName(field);
            case FieldType.Email: return _validEmailAddress(field);
            default: return false;
        }
    }


    bool _validFirstName(String firstName) {
        if(firstName.trim().length < getFieldMinLength(FieldType.FirstName)) return false;
        // if(email == null) return false;
        // return RegExp(_EMAIL_REG_EXP).hasMatch(email);
        return true;
    }

    bool _validLastName(String lastName) {
        if(lastName.trim().length < getFieldMinLength(FieldType.LastName)) return false;
        // if(email == null) return false;
        // return RegExp(_EMAIL_REG_EXP).hasMatch(email);
        return true;
    }



    bool _validEmailAddress(String email) {
        if(email == null) return false;
        return RegExp(_EMAIL_REG_EXP).hasMatch(email);
    }


    bool validEmailAddress(String email) {
        if(email == null) return false;
        return RegExp(_EMAIL_REG_EXP).hasMatch(email);
    }
}