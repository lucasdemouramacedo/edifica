// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:edifica/atividade_screen_status.dart';
import 'package:edifica/db/dbprovider.dart';
import 'package:edifica/models/opcao_atividade_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:flutter_mobx/flutter_mobx.dart';

class AtividadeScreen extends StatefulWidget {
  final AtividadeScreenStatus atividadeScreenStatus;
  const AtividadeScreen({Key? key, required this.atividadeScreenStatus})
      : super(key: key);

  @override
  State<AtividadeScreen> createState() => _AtividadeScreenState();
}

class _AtividadeScreenState extends State<AtividadeScreen> {
  Future<List<OpcaoAtividadeModel>> getOpcoesByAtividadeId() async {
    UnidadeDbProvider unidadeDb = UnidadeDbProvider();
    return await unidadeDb
        .getOpcoesByAtividadeId(widget.atividadeScreenStatus.id);
  }

  Color? _color;
  int? _opcao;

  Color getColor(id) {
    if (widget.atividadeScreenStatus.respostaAluno != null &&
        widget.atividadeScreenStatus.respostaAluno !=
            widget.atividadeScreenStatus.respostaCerta &&
        widget.atividadeScreenStatus.respostaAluno.toString() ==
            id.toString()) {
      return const Color.fromRGBO(255, 114, 114, 1);
    }
    if (widget.atividadeScreenStatus.respostaAluno ==
            widget.atividadeScreenStatus.respostaCerta &&
        widget.atividadeScreenStatus.respostaCerta.toString() ==
            id.toString()) {
      return const Color.fromRGBO(156, 223, 139, 1);
    }
    return const Color.fromRGBO(213, 224, 237, 1);
  }

  setOpcao(id) {
    setState(() {
      _opcao = id;
    });
  }

  Future<void> _corrigirAtividade() async {
    UnidadeDbProvider unidadeDb = UnidadeDbProvider();
    await unidadeDb.registraResposta(widget.atividadeScreenStatus.id, _opcao);
    widget.atividadeScreenStatus
        .atualizaAtividade(widget.atividadeScreenStatus.id);
    setOpcao(null);
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();
    return Material(child: Observer(
      builder: (_) {
        return Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 1,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 20, right: 20),
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.14,
                    width: MediaQuery.of(context).size.width * 1,
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            InkWell(
                              onTap: () => {Navigator.pop(context)},
                              child: Ink(
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(52, 68, 86, 1.0),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                    color: Color.fromRGBO(210, 227, 245, 1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.arrow_back_ios_new_outlined,
                                    color: Color.fromRGBO(113, 151, 194, 1),
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Hero(
                                  tag: 'atividade' +
                                      widget.atividadeScreenStatus.id
                                          .toString(),
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 20),
                                    width:
                                        MediaQuery.of(context).size.width - 110,
                                    child: Text(
                                      widget.atividadeScreenStatus.titulo
                                          .toString(),
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        decoration: TextDecoration.none,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 24,
                                        color: Color.fromRGBO(52, 68, 86, 1.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Hero(
                                  tag: 'unidade' +
                                      widget.atividadeScreenStatus.id
                                          .toString(),
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 20),
                                    width:
                                        MediaQuery.of(context).size.width - 110,
                                    child: Text(
                                      widget.atividadeScreenStatus.unidade
                                          .toString(),
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: Color.fromRGBO(196, 223, 255, 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.86,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      controller: _scrollController,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 90),
                        child: Column(
                          children: [
                            Html(
                              useRichText: false,
                              data: widget.atividadeScreenStatus.enunciado
                                  .toString(),
                              customTextStyle: (dom.Node node, textstyle) {
                                if (node is dom.Element) {
                                  switch (node.localName) {
                                    case "body":
                                      return const TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        color: Color.fromRGBO(52, 68, 86, 1.0),
                                      );
                                    case "h2":
                                      return const TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 24,
                                        color: Color.fromRGBO(52, 68, 86, 1.0),
                                      );
                                    case "h3":
                                      return const TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        color: Color.fromRGBO(52, 68, 86, 0.9),
                                      );
                                  }
                                }
                                return null;
                              },
                              customRender: (dom.Node node, widget) {
                                if (node is dom.Element) {
                                  switch (node.localName) {
                                    case "h2":
                                      return Text(node.text,
                                          style: const TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 24,
                                            color:
                                                Color.fromRGBO(52, 68, 86, 0.9),
                                          ));
                                    case "h3":
                                      return Text(node.text,
                                          style: const TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                            color:
                                                Color.fromRGBO(52, 68, 86, 0.9),
                                          ));
                                    case "paragrafo":
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 10, 10, 10),
                                        child: Text(
                                          node.text,
                                          style: const TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20,
                                            color:
                                                Color.fromRGBO(52, 68, 86, 1.0),
                                          ),
                                        ),
                                      );
                                    case "img":
                                      //node.attributes['src'].toString(),
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          elevation: 5,
                                          clipBehavior: Clip.antiAlias,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: double.maxFinite,
                                                color: const Color.fromRGBO(
                                                    113, 151, 194, 0.4),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Text(
                                                    node.attributes['alt']
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 18,
                                                      color: Color.fromRGBO(
                                                          52, 68, 86, 0.9),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Stack(
                                                alignment: AlignmentDirectional
                                                    .bottomEnd,
                                                children: [
                                                  Image.asset(
                                                    node.attributes['src']
                                                        .toString(),
                                                    width: double.infinity,
                                                    fit: BoxFit.fill,
                                                  ),
                                                  InkWell(
                                                    onTap: () => {},
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10)),
                                                      ),
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.all(5.0),
                                                        child: Text(
                                                          'Fonte da Imagem',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Montserrat',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15,
                                                            color:
                                                                Color.fromRGBO(
                                                                    52,
                                                                    68,
                                                                    86,
                                                                    0.9),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    case "card":
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, bottom: 20),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          elevation: 5,
                                          clipBehavior: Clip.antiAlias,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: double.maxFinite,
                                                color: const Color.fromRGBO(
                                                    113, 151, 194, 0.4),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Text(
                                                    node.attributes['label']
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 20,
                                                      color: Color.fromRGBO(
                                                          52, 68, 86, 0.9),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        15, 20, 15, 20),
                                                child: Text(
                                                  node.text,
                                                  style: const TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 20,
                                                    color: Color.fromRGBO(
                                                        52, 68, 86, 0.9),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    case "formula":
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, bottom: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              elevation: 5,
                                              clipBehavior: Clip.antiAlias,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        30, 20, 30, 20),
                                                    child: Text(
                                                      node.text,
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 20,
                                                        color: Color.fromRGBO(
                                                            52, 68, 86, 0.9),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                  }
                                }

                                return null;
                              },
                            ),
                            if (widget.atividadeScreenStatus.tipo.toString() ==
                                "multipla-escolha")
                              FutureBuilder<List<OpcaoAtividadeModel>>(
                                  future: getOpcoesByAtividadeId(),
                                  builder: (context, snapshot) {
                                    var data2 = snapshot.data;

                                    if (!snapshot.hasData) {
                                      return const Center(
                                          child: Text("Carregando dados!"));
                                    }
                                    return ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: data2!.length,
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        itemBuilder: (_, index) {
                                          return Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: const EdgeInsets.only(
                                                bottom: 2, top: 3),
                                            child: InkWell(
                                              onTap: () =>
                                                  setOpcao(data2[index].id),
                                              child: Card(
                                                color: _opcao == data2[index].id
                                                    ? const Color.fromRGBO(
                                                        113, 151, 194, 1)
                                                    : getColor(data2[index].id),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                ),
                                                elevation: 4,
                                                clipBehavior: Clip.antiAlias,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Text(
                                                    data2[index]
                                                        .enunciado
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 18,
                                                      color: _opcao ==
                                                              data2[index].id
                                                          ? Colors.white
                                                          : const Color
                                                                  .fromRGBO(
                                                              52, 68, 86, 1.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  }),
                            if (widget.atividadeScreenStatus.tipo.toString() ==
                                "reflexao")
                              ExpansionTile(
                                  initiallyExpanded: false,
                                  title: const Text(
                                    'Resposta',
                                    style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 18,
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(52, 68, 86, 1.0),
                                    ),
                                  ),
                                  iconColor:
                                      const Color.fromRGBO(52, 68, 86, 1.0),
                                  backgroundColor: Colors.transparent,
                                  collapsedBackgroundColor: Colors.transparent,
                                  collapsedIconColor:
                                      const Color.fromRGBO(52, 68, 86, 1.0),
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    SingleChildScrollView(
                                      physics:
                                            const NeverScrollableScrollPhysics(),
                                      child: Html(
                                        useRichText: false,
                                        data: widget
                                            .atividadeScreenStatus.respostaCerta
                                            .toString(),
                                        customTextStyle:
                                            (dom.Node node, textstyle) {
                                          if (node is dom.Element) {
                                            switch (node.localName) {
                                              case "body":
                                                return const TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20,
                                                  color: Color.fromRGBO(
                                                      52, 68, 86, 1.0),
                                                );
                                              case "h2":
                                                return const TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 24,
                                                  color: Color.fromRGBO(
                                                      52, 68, 86, 1.0),
                                                );
                                              case "h3":
                                                return const TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 20,
                                                  color: Color.fromRGBO(
                                                      52, 68, 86, 0.9),
                                                );
                                            }
                                          }
                                          return null;
                                        },
                                        customRender: (dom.Node node, widget) {
                                          if (node is dom.Element) {
                                            switch (node.localName) {
                                              case "h2":
                                                return Text(node.text,
                                                    style: const TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 24,
                                                      color: Color.fromRGBO(
                                                          52, 68, 86, 0.9),
                                                    ));
                                              case "h3":
                                                return Text(node.text,
                                                    style: const TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 20,
                                                      color: Color.fromRGBO(
                                                          52, 68, 86, 0.9),
                                                    ));
                                              case "paragrafo":
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 10, 10, 10),
                                                  child: Text(
                                                    node.text,
                                                    style: const TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 20,
                                                      color: Color.fromRGBO(
                                                          52, 68, 86, 1.0),
                                                    ),
                                                  ),
                                                );
                                              case "img":
                                                //node.attributes['src'].toString(),
                                                return Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 5, bottom: 5),
                                                  child: Card(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    elevation: 5,
                                                    clipBehavior: Clip.antiAlias,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width: double.maxFinite,
                                                          color: const Color
                                                                  .fromRGBO(
                                                              113, 151, 194, 0.4),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
                                                            child: Text(
                                                              node.attributes[
                                                                      'alt']
                                                                  .toString(),
                                                              textAlign: TextAlign
                                                                  .center,
                                                              style:
                                                                  const TextStyle(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 18,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        52,
                                                                        68,
                                                                        86,
                                                                        0.9),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Stack(
                                                          alignment:
                                                              AlignmentDirectional
                                                                  .bottomEnd,
                                                          children: [
                                                            Image.asset(
                                                              node.attributes[
                                                                      'src']
                                                                  .toString(),
                                                              width:
                                                                  double.infinity,
                                                              fit: BoxFit.fill,
                                                            ),
                                                            InkWell(
                                                              onTap: () => {},
                                                              child: Container(
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius: BorderRadius.only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              10)),
                                                                ),
                                                                child:
                                                                    const Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5.0),
                                                                  child: Text(
                                                                    'Fonte da Imagem',
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          15,
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              52,
                                                                              68,
                                                                              86,
                                                                              0.9),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              case "card":
                                                return Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 20, bottom: 20),
                                                  child: Card(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    elevation: 5,
                                                    clipBehavior: Clip.antiAlias,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: double.maxFinite,
                                                          color: const Color
                                                                  .fromRGBO(
                                                              113, 151, 194, 0.4),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
                                                            child: Text(
                                                              node.attributes[
                                                                      'label']
                                                                  .toString(),
                                                              style:
                                                                  const TextStyle(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 20,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        52,
                                                                        68,
                                                                        86,
                                                                        0.9),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  15, 20, 15, 20),
                                                          child: Text(
                                                            node.text,
                                                            style:
                                                                const TextStyle(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontWeight:
                                                                  FontWeight.w500,
                                                              fontSize: 20,
                                                              color:
                                                                  Color.fromRGBO(
                                                                      52,
                                                                      68,
                                                                      86,
                                                                      0.9),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              case "formula":
                                                return Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 20, bottom: 20),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    children: [
                                                      Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10.0),
                                                        ),
                                                        elevation: 5,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      30,
                                                                      20,
                                                                      30,
                                                                      20),
                                                              child: Text(
                                                                node.text,
                                                                style:
                                                                    const TextStyle(
                                                                  fontFamily:
                                                                      'Montserrat',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 20,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          52,
                                                                          68,
                                                                          86,
                                                                          0.9),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                            }
                                          }
                                    
                                          return null;
                                        },
                                      ),
                                    ),
                                  ])
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      InkWell(
                        onTap: () => {
                          _scrollController.jumpTo(0.0),
                          widget.atividadeScreenStatus.atualizaAtividade(
                              widget.atividadeScreenStatus.id! - 1)
                        },
                        child: Ink(
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(52, 68, 86, 1.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(210, 227, 245, 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new_outlined,
                              color: Color.fromRGBO(113, 151, 194, 1),
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      if(widget.atividadeScreenStatus.tipo.toString() == 'multipla-escolha')
                      InkWell(
                        onTap: () => {
                          _corrigirAtividade(),
                        },
                        child: Ink(
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(52, 68, 86, 1.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: Container(
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(52, 68, 86, 1.0),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                                child: Text(
                                  'Corrigir',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              )),
                        ),
                      ),
                      InkWell(
                        onTap: () => {
                          _scrollController.jumpTo(0.0),
                          widget.atividadeScreenStatus.atualizaAtividade(
                              widget.atividadeScreenStatus.id! + 1)
                        },
                        child: Ink(
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(52, 68, 86, 1.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Transform.rotate(
                            angle: 3.14,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(113, 151, 194, 1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios_new_outlined,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ));
  }
}
