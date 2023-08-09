import 'package:appnotesusingphp/constants/messages.dart';

ValidOrNot(String val, int max, int min) {
  if (val.isEmpty) {
    return isempty;
  }
  if (val.length > max) {
    return "$greaterthanmax $max";
  }
  if (val.length < min) {
    return "$lessthanmin $min";
  }
}
