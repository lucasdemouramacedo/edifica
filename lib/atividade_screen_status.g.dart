// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'atividade_screen_status.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AtividadeScreenStatus on _AtividadeScreenStatus, Store {
  late final _$idAtom =
      Atom(name: '_AtividadeScreenStatus.id', context: context);

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
      Atom(name: '_AtividadeScreenStatus.titulo', context: context);

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
      Atom(name: '_AtividadeScreenStatus.unidade', context: context);

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

  late final _$enunciadoAtom =
      Atom(name: '_AtividadeScreenStatus.enunciado', context: context);

  @override
  String? get enunciado {
    _$enunciadoAtom.reportRead();
    return super.enunciado;
  }

  @override
  set enunciado(String? value) {
    _$enunciadoAtom.reportWrite(value, super.enunciado, () {
      super.enunciado = value;
    });
  }

  late final _$respostaAlunoAtom =
      Atom(name: '_AtividadeScreenStatus.respostaAluno', context: context);

  @override
  String? get respostaAluno {
    _$respostaAlunoAtom.reportRead();
    return super.respostaAluno;
  }

  @override
  set respostaAluno(String? value) {
    _$respostaAlunoAtom.reportWrite(value, super.respostaAluno, () {
      super.respostaAluno = value;
    });
  }

  late final _$respostaCertaAtom =
      Atom(name: '_AtividadeScreenStatus.respostaCerta', context: context);

  @override
  String? get respostaCerta {
    _$respostaCertaAtom.reportRead();
    return super.respostaCerta;
  }

  @override
  set respostaCerta(String? value) {
    _$respostaCertaAtom.reportWrite(value, super.respostaCerta, () {
      super.respostaCerta = value;
    });
  }

  late final _$tipoAtom =
      Atom(name: '_AtividadeScreenStatus.tipo', context: context);

  @override
  String? get tipo {
    _$tipoAtom.reportRead();
    return super.tipo;
  }

  @override
  set tipo(String? value) {
    _$tipoAtom.reportWrite(value, super.tipo, () {
      super.tipo = value;
    });
  }

  late final _$atualizaAtividadeAsyncAction =
      AsyncAction('_AtividadeScreenStatus.atualizaAtividade', context: context);

  @override
  Future<void> atualizaAtividade(dynamic id2) {
    return _$atualizaAtividadeAsyncAction
        .run(() => super.atualizaAtividade(id2));
  }

  @override
  String toString() {
    return '''
id: ${id},
titulo: ${titulo},
unidade: ${unidade},
enunciado: ${enunciado},
respostaAluno: ${respostaAluno},
respostaCerta: ${respostaCerta},
tipo: ${tipo}
    ''';
  }
}
