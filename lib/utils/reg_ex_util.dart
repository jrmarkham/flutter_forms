

const String _EMAIL_REG_EXP =
     r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";

///::: TODO create regular expressions
final RegExp regExpEmail = RegExp(_EMAIL_REG_EXP);
final RegExp regExpZip = RegExp('');
final RegExp regExpFirstName = RegExp('');
final RegExp regExpLastName = RegExp('');
