import 'package:edifica/capitulo_screen_status.dart';
import 'package:edifica/db/dbprovider.dart';
import 'package:edifica/estudo/section_row/section_row.dart';
import 'package:edifica/models/unidade_model.dart';
import 'package:flutter/material.dart';

class EstudoSection extends StatelessWidget {
  const EstudoSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CapituloScreenStatus capituloScreenStatus = CapituloScreenStatus();
    Future<List<UnidadeModel>> getUnidades() async {
      UnidadeDbProvider unidadeDb = UnidadeDbProvider();
      return await unidadeDb.fetchUnidades();
    }

    // ignore: unused_element
    Future<int> getQtdUnidades() async {
      UnidadeDbProvider unidadeDb = UnidadeDbProvider();
      int qtdUnidades = await unidadeDb.countUnidades();
      return qtdUnidades;
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 1,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(45),
                  bottomRight: Radius.circular(45)),
              color: Color.fromRGBO(213, 224, 237, 1),
            ),
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 50, bottom: 15),
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      
                      const Text(
                        'Estudo',
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w500,
                          fontSize: 28,
                          color: Color.fromRGBO(52, 68, 86, 1.0),
                        ),
                        
                      ),
                      if(1 != 1)
                      const Icon(
                            Icons.settings,
                            color: Color.fromRGBO(52, 68, 86, 1.0),
                            size: 30,
                          ),
                    ],
                  ),
                  if(1 != 1)
                  Material(
                    color: Colors.transparent,
                    child: TextField(
                      style: const TextStyle(
                        color: Colors.black38,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      cursorColor: Colors.black87,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.black38,
                          ),
                          hintText: 'Busque',
                          hintStyle: const TextStyle(
                              color: Colors.black38,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(color: Color.fromRGBO(52, 68, 86, 1.0), width: 2.0),
                          ),
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.85,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(top: 20.0),
              child: FutureBuilder<List<UnidadeModel>>(
                  future: getUnidades(),
                  builder: (context, snapshot) {
                    var data = snapshot.data;
                    
                    if (!snapshot.hasData) {
                      return const Center(child: Text("Carregando dados!"));
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: data!.length,
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 70),
                        itemBuilder: (_, index) {
                          return SectionRow(
                              id: data[index].id, nome: data[index].nome, capituloScreenStatus: capituloScreenStatus,);
                        });
                  })),
        ],
      ),
    );
  }
}
