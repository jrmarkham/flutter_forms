enum FieldState { Empty, Invalid, Valid }
enum FieldType { FirstName, LastName, Email, LanguageArray, ContactArray }
enum LanguageEnum { English, Spanish, German, French }
// ENUM FUNCTIONS
String getFieldName(FieldType type){
    switch(type){
        case FieldType.LastName: return 'Last Name';
        case FieldType.Email: return 'Email';
        case FieldType.FirstName:default: return 'First Name';

    }
}

int getFieldMaxLength(FieldType type){
    switch(type){
        case FieldType.LastName: return 25;
        case FieldType.Email: return 50;
        case FieldType.FirstName:default: return 10;

    }
}


int getFieldMinLength(FieldType type){
    switch(type){
        case FieldType.LastName: return 2;
        case FieldType.Email: return 6;
        case FieldType.FirstName:default: return 2;

    }
}

String getStateText(FieldState state, String label){
    switch(state){
        case FieldState.Invalid: return 'Invalid $label';
        case FieldState.Empty: return 'Enter $label';
        case FieldState.Valid:default: return '$label valid';

    }
}