// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChatState on _ChatState, Store {
  late final _$messageAtom = Atom(name: '_ChatState.message', context: context);

  @override
  Map<String, dynamic> get message {
    _$messageAtom.reportRead();
    return super.message;
  }

  @override
  set message(Map<String, dynamic> value) {
    _$messageAtom.reportWrite(value, super.message, () {
      super.message = value;
    });
  }

  late final _$_ChatStateActionController =
      ActionController(name: '_ChatState', context: context);

  @override
  void RefrenceChatForCurrentUser() {
    final _$actionInfo = _$_ChatStateActionController.startAction(
        name: '_ChatState.RefrenceChatForCurrentUser');
    try {
      return super.RefrenceChatForCurrentUser();
    } finally {
      _$_ChatStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
message: ${message}
    ''';
  }
}
