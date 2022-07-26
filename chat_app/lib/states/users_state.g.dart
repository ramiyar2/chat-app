// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UsersState on _UsersState, Store {
  late final _$usersAtom = Atom(name: '_UsersState.users', context: context);

  @override
  Map<String, dynamic> get users {
    _$usersAtom.reportRead();
    return super.users;
  }

  @override
  set users(Map<String, dynamic> value) {
    _$usersAtom.reportWrite(value, super.users, () {
      super.users = value;
    });
  }

  late final _$pakedImageAtom =
      Atom(name: '_UsersState.pakedImage', context: context);

  @override
  File? get pakedImage {
    _$pakedImageAtom.reportRead();
    return super.pakedImage;
  }

  @override
  set pakedImage(File? value) {
    _$pakedImageAtom.reportWrite(value, super.pakedImage, () {
      super.pakedImage = value;
    });
  }

  late final _$_UsersStateActionController =
      ActionController(name: '_UsersState', context: context);

  @override
  void initUseresListeners() {
    final _$actionInfo = _$_UsersStateActionController.startAction(
        name: '_UsersState.initUseresListeners');
    try {
      return super.initUseresListeners();
    } finally {
      _$_UsersStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
users: ${users},
pakedImage: ${pakedImage}
    ''';
  }
}
