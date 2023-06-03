// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_page_status.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MenuPageStatus on _MenuPageStatus, Store {
  late final _$statusAtom =
      Atom(name: '_MenuPageStatus.status', context: context);

  @override
  int get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(int value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  late final _$titleSectionAtom =
      Atom(name: '_MenuPageStatus.titleSection', context: context);

  @override
  String get titleSection {
    _$titleSectionAtom.reportRead();
    return super.titleSection;
  }

  @override
  set titleSection(String value) {
    _$titleSectionAtom.reportWrite(value, super.titleSection, () {
      super.titleSection = value;
    });
  }

  late final _$_MenuPageStatusActionController =
      ActionController(name: '_MenuPageStatus', context: context);

  @override
  void changeStatus(dynamic page) {
    final _$actionInfo = _$_MenuPageStatusActionController.startAction(
        name: '_MenuPageStatus.changeStatus');
    try {
      return super.changeStatus(page);
    } finally {
      _$_MenuPageStatusActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
status: ${status},
titleSection: ${titleSection}
    ''';
  }
}
