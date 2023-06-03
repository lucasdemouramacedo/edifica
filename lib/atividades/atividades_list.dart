import 'package:edifica/atividade_screen_status.dart';
import 'package:edifica/atividades/atividade_item.dart';
import 'package:edifica/db/dbprovider.dart';
import 'package:edifica/models/atividade_model.dart';
import 'package:flutter/material.dart';

class AtividadesList extends StatelessWidget {
  final dynamic id, nome;
  const AtividadesList({Key? key, this.nome, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<List<AtividadeModel>> getAtividadesByUnidadeId(id) async {
      UnidadeDbProvider unidadeDb = UnidadeDbProvider();
      return await unidadeDb.fetchAtividadesByUnidadeId(id);
    }

    AtividadeScreenStatus atividadeScreenStatus = AtividadeScreenStatus();
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(
        nome,
        style: const TextStyle(
          decoration: TextDecoration.none,
          fontSize: 18,
          fontFamily: 'Lato',
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(52, 68, 86, 1.0),
        ),
      ),
      iconColor: const Color.fromRGBO(52, 68, 86, 1.0),
      backgroundColor: Colors.transparent,
      collapsedBackgroundColor: Colors.transparent,
      collapsedIconColor: const Color.fromRGBO(52, 68, 86, 1.0),
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        FutureBuilder<List<AtividadeModel>>(
          
            future: getAtividadesByUnidadeId(id),
            builder: (context, snapshot) {
              var data2 = snapshot.data;
             
              if (!snapshot.hasData) {
                return const Center(child: Text("Carregando dados!"));
              }
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: data2!.length,
                  itemBuilder: (_, index) {
                    return AtividadeItem(
                      id: data2[index].id,
                      nome: data2[index].nome,
                      atividadeScreenStatus: atividadeScreenStatus,
                      respostaAluno: data2[index].respostaAluno,
                      respostaCerta: data2[index].respostaCerta,
                      tipo: data2[index].tipo
                    );
                  });
            })
      ],
    );
  }
}
