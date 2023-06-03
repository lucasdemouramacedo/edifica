// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:edifica/capitulo_screen_status.dart';
import 'package:edifica/models/unidade_model.dart';
import 'package:flutter/material.dart';
import '../../db/dbprovider.dart';

class SectionRowItem extends StatelessWidget {
  final id, titulo;
  final CapituloScreenStatus capituloScreenStatus;
  const SectionRowItem({Key? key, this.titulo, this.id, required this.capituloScreenStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UnidadeDbProvider unidadeDb = UnidadeDbProvider();
    // ignore: unused_element
    Future<List<UnidadeModel>> getUnidades() async {
      var data = await unidadeDb.fetchUnidades();
      //print(data[0].nome);
      return data;
    }

    return Material(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          child: InkWell(
            onTap: () => {
              capituloScreenStatus.atualizaConteudo(id),
              Navigator.pushNamed(context, '/capitulo', arguments: {
                'capituloScreenStatus': capituloScreenStatus,
              })
            },
            child: Ink(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(11, 33, 61, 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.width / 2.8,
                width: MediaQuery.of(context).size.width / 2.8,
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Hero(
                      tag: 'image' + id.toString(),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        child: ShaderMask(
                          shaderCallback: (rect) {
                            return const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black,
                                Color.fromRGBO(0, 0, 0, 0.8),
                                Color.fromRGBO(0, 0, 0, 0.4),
                                Color.fromRGBO(0, 0, 0, 0.05),
                                Colors.transparent
                              ],
                            ).createShader(
                                Rect.fromLTRB(0, 0, rect.width, rect.height));
                          },
                          blendMode: BlendMode.dstATop,
                          child: Image.asset(
                            'assets/images/' + id.toString() + '.jpg',
                            height: double.infinity,
                            fit: BoxFit.cover,
                            color: const Color.fromARGB(60, 255, 230, 0),
                            colorBlendMode: BlendMode.dst,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: (MediaQuery.of(context).size.width / 5.6),
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right:
                                    10, //(MediaQuery.of(context).size.width / 4.5),
                                left: 10),
                            child: Hero(
                              tag: 'capitulo' + id.toString(),
                              child: Text(
                                titulo,
                                style: const TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 13,
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
