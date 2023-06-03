// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:edifica/capitulo_screen_status.dart';
import 'package:edifica/db/dbprovider.dart';
import 'package:edifica/estudo/section_row/section_row_item.dart';
import 'package:edifica/models/capitulo_model.dart';
import 'package:flutter/material.dart';

class SectionRow extends StatelessWidget {
  //final Section section;
  final id, nome;
  final CapituloScreenStatus capituloScreenStatus;
  const SectionRow({Key? key, this.id, this.nome, required this.capituloScreenStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<List<CapituloModel>> getCapitulos() async {
      UnidadeDbProvider unidadeDb = UnidadeDbProvider();
      return await unidadeDb.fetchCapitulosByUnidadeId(id);
    }

    // ignore: unused_element
    Future<int> getQtdCapitulos() async {
      UnidadeDbProvider unidadeDb = UnidadeDbProvider();
      int qtdUnidades = await unidadeDb.countCapitulosByUnidadeId(id);
      return qtdUnidades;
    }

    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 15.0),
          width: MediaQuery.of(context).size.width * 0.8,
          alignment: Alignment.centerLeft,
          child: Hero(
            tag: 'unidade'+id.toString(),
            child: Text(
              nome,
              style: const TextStyle(
                decoration: TextDecoration.none,
                fontSize: 16,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(52, 68, 86, 1.0),
              ),
            ),
          ),
        ),
        Container(
            height: MediaQuery.of(context).size.width / 2.8 + 30,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 0.0),
            child: FutureBuilder<List<CapituloModel>>(
                future: getCapitulos(),
                builder: (context, snapshot) {
                  //print(snapshot.data?[0].nome);
                  var data = snapshot.data;

                  if (!snapshot.hasData) {
                    return const Center(child: Text("Carregando dados!"));
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: data!.length,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(30, 15, 0, 15),
                      itemBuilder: (_, index) {
                        return SectionRowItem(
                          titulo: data[index].nome, id: data[index].id, capituloScreenStatus: capituloScreenStatus,
                        );
                      });
                }))
      ],
    );
  }
}
