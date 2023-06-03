class OpcaoAtividadeModel {
  final Object? id;
  final Object? enunciado;
  final Object? atividadefk;

  OpcaoAtividadeModel({required this.id,this.enunciado, this.atividadefk});

  Map<String,dynamic> toMap(){ // used when inserting data to the database
    return <String,dynamic>{
      "id" : id,
      "enunciado" : enunciado,
      "atividadefk" : atividadefk,
    };
  }

 /* Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    return data;
  }*/
}
