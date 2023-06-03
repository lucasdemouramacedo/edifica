// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capitulo_screen_status.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CapituloScreenStatus on _CapituloScreenStatus, Store {
  late final _$idAtom =
      Atom(name: '_CapituloScreenStatus.id', context: context);

  @override
  int? get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(int? value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  late final _$tituloAtom =
      Atom(name: '_CapituloScreenStatus.titulo', context: context);

  @override
  String? get titulo {
    _$tituloAtom.reportRead();
    return super.titulo;
  }

  @override
  set titulo(String? value) {
    _$tituloAtom.reportWrite(value, super.titulo, () {
      super.titulo = value;
    });
  }

  late final _$unidadeAtom =
      Atom(name: '_CapituloScreenStatus.unidade', context: context);

  @override
  String? get unidade {
    _$unidadeAtom.reportRead();
    return super.unidade;
  }

  @override
  set unidade(String? value) {
    _$unidadeAtom.reportWrite(value, super.unidade, () {
      super.unidade = value;
    });
  }

  late final _$conteudoAtom =
      Atom(name: '_CapituloScreenStatus.conteudo', context: context);

  @override
  String? get conteudo {
    _$conteudoAtom.reportRead();
    return super.conteudo;
  }

  @override
  set conteudo(String? value) {
    _$conteudoAtom.reportWrite(value, super.conteudo, () {
      super.conteudo = value;
    });
  }

  late final _$fonteImagemAtom =
      Atom(name: '_CapituloScreenStatus.fonteImagem', context: context);

  @override
  String? get fonteImagem {
    _$fonteImagemAtom.reportRead();
    return super.fonteImagem;
  }

  @override
  set fonteImagem(String? value) {
    _$fonteImagemAtom.reportWrite(value, super.fonteImagem, () {
      super.fonteImagem = value;
    });
  }

  late final _$atualizaConteudoAsyncAction =
      AsyncAction('_CapituloScreenStatus.atualizaConteudo', context: context);

  @override
  Future<void> atualizaConteudo(dynamic id2) {
    return _$atualizaConteudoAsyncAction.run(() => super.atualizaConteudo(id2));
  }

  @override
  String toString() {
    return '''
id: ${id},
titulo: ${titulo},
unidade: ${unidade},
conteudo: ${conteudo},
fonteImagem: ${fonteImagem}
    ''';
  }
}
