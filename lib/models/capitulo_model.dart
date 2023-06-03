class CapituloModel {
  final Object? id;
  final Object? nome;
  final Object? conteudo;
  final Object? unidadefk;
  final Object? fonteImagem;
  final Object? unidadeNome;

  CapituloModel({this.unidadeNome, this.fonteImagem,required this.id, required this.nome,this.conteudo, this.unidadefk});

  Map<String,dynamic> toMap(){ // used when inserting data to the database
    return <String,dynamic>{
      "id" : id,
      "nome" : nome,
      "conteudo" : conteudo,
      "unidadefk" : unidadefk,
      "fonteImagem" : fonteImagem,
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    return data;
  }
}
