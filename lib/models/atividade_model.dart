class AtividadeModel {
  final Object? id;
  final Object? nome;
  final Object? enunciado;
  final Object? respostaCerta;
  final Object? respostaAluno;
  final Object? tipo;
  final Object? unidadefk;
  final Object? unidadeNome;

  AtividadeModel(
      {this.tipo,
      this.respostaAluno,
      this.respostaCerta,
      this.unidadeNome,
      required this.id,
      required this.nome,
      this.enunciado,
      this.unidadefk});

  Map<String, dynamic> toMap() {
    // used when inserting data to the database
    return <String, dynamic>{
      "id": id,
      "nome": nome,
      "enunciado": enunciado,
      "respostaCerta": respostaCerta,
      "respostaAluno": respostaAluno,
      "tipo": tipo,
      "unidadefk": unidadefk,
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    return data;
  }
}
