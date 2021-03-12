///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.dart.commons.eval.text;

import 'package:verbal_expressions/verbal_expressions.dart';

///
/// Utlidades para validacao de textos
///
abstract class ValidateText {
  /// validate if something contains only text
  static bool validateText(String text) =>
      (VerbalExpression()..word()).hasMatch(text.trim()) &&
      text.trim().isNotEmpty;

  /// validate if something contains only text with fucking limit
  static bool validateTextWithLimit(String text, int limit) =>
      (VerbalExpression()..word()).hasMatch(text.trim()) &&
      text.trim().isNotEmpty &&
      text.trim().length <= limit;

  /// validate if something contains only text
  static bool validateName(String name) =>
      !(VerbalExpression()..add(r'[0-9 !@#$%"&.*()-=_+\[\]{}<>|\\/\^]+'))
          .hasMatch(name.trim()) &&
      name.trim().isNotEmpty;

  /// validate if something contains only text
  static bool validateNameWithSpace(String name) =>
      !(VerbalExpression()..add(r'[0-9!@#$%"&.*()-=_+\[\]{}<>|\\/\^]+'))
          .hasMatch(name.trim()) &&
      name.trim().isNotEmpty;

  /// funcao que valida email
  static bool validateEmail(String email) =>
      (VerbalExpression()
            ..add(r'\b[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,20}\b'))
          .hasMatch(email) &&
      email.trim().isNotEmpty;

  /// funcao que valida url
  static bool validateURL(String url) =>
      (VerbalExpression()
            ..startOfLine()
            ..maybe('http')
            ..maybe('s')
            ..maybe('://')
            ..maybe('www.')
            ..anythingBut(' ')
            ..endOfLine())
          .hasMatch(url) &&
      url.trim().isNotEmpty;
}
