// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:edifica/capitulo_screen_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:flutter_mobx/flutter_mobx.dart';

class CapituloScreen extends StatefulWidget {
  final CapituloScreenStatus capituloScreenStatus;
  const CapituloScreen({Key? key, required this.capituloScreenStatus})
      : super(key: key);

  @override
  State<CapituloScreen> createState() => _CapituloScreenState();
}

class _CapituloScreenState extends State<CapituloScreen> {
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
                                  tag: 'capitulo' +
                                      widget.capituloScreenStatus.id.toString(),
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 20),
                                    width:
                                        MediaQuery.of(context).size.width - 110,
                                    child: Text(
                                      widget.capituloScreenStatus.titulo
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
                                      widget.capituloScreenStatus.id.toString(),
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 20),
                                    width:
                                        MediaQuery.of(context).size.width - 110,
                                    child: Text(
                                      widget.capituloScreenStatus.unidade
                                          .toString(),
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color:
                                            Color.fromRGBO(196, 223, 255, 1),
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
                      controller: _scrollController,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 0.0, bottom: 20.0),
                            child: SizedBox(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              child: Hero(
                                tag: 'image' +
                                    widget.capituloScreenStatus.id.toString(),
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
                                          Colors.black,
                                          Colors.black,
                                          Colors.black,
                                          Colors.black
                                        ],
                                      ).createShader(Rect.fromLTRB(
                                          0, 0, rect.width, rect.height));
                                    },
                                    blendMode: BlendMode.dstATop,
                                    child: Image.asset(
                                      'assets/images/' +
                                          widget.capituloScreenStatus.id
                                              .toString() +
                                          '.jpg',
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                      color:
                                          const Color.fromARGB(60, 255, 230, 0),
                                      colorBlendMode: BlendMode.dst,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(bottom: 80),
                              child: SingleChildScrollView(
                                controller: _scrollController,
                                child: Html(
                                  useRichText: false,
                                  data: widget.capituloScreenStatus.conteudo
                                      .toString(),
                                  customTextStyle: (dom.Node node, textstyle) {
                                    if (node is dom.Element) {
                                      switch (node.localName) {
                                        case "body":
                                          return const TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20,
                                            color:
                                                Color.fromRGBO(52, 68, 86, 1.0),
                                          );
                                        case "h2":
                                          return const TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24,
                                            color:
                                                Color.fromRGBO(52, 68, 86, 1.0),
                                          );
                                        case "h3":
                                          return const TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                            color:
                                                Color.fromRGBO(52, 68, 86, 0.9),
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
                                            padding: const EdgeInsets.fromLTRB(
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
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: double.maxFinite,
                                                    color: const Color.fromRGBO(
                                                        113, 151, 194, 0.4),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Text(
                                                        node.attributes['alt']
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'Montserrat',
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
                                                    alignment:
                                                        AlignmentDirectional
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
                                                                EdgeInsets.all(
                                                                    5.0),
                                                            child: Text(
                                                              'Fonte da Imagem',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 15,
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
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Text(
                                                        node.attributes['label']
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'Montserrat',
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
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        15, 20, 15, 20),
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
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                30, 20, 30, 20),
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
                                              ],
                                            ),
                                          );
                                      }
                                    }

                                    return null;
                                  },
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 15,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: 
                  widget.capituloScreenStatus.id! == 1 ?
                    MainAxisAlignment.end :
                    MainAxisAlignment.spaceBetween
                  ,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    if(widget.capituloScreenStatus.id! > 1)
                    GestureDetector(
                      onTap:  () => {
                        _scrollController.jumpTo(0.0),
                        widget.capituloScreenStatus.atualizaConteudo(widget.capituloScreenStatus.id! - 1)
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        color: const Color.fromRGBO(213, 232, 255, 1),
                        clipBehavior: Clip.antiAlias,
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          child: Text(
                            'Anterior',
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              decoration: TextDecoration.none,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Color.fromRGBO(52, 68, 86, 1.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if(widget.capituloScreenStatus.id! < 32)
                    GestureDetector(
                      onTap:  () => {
                        _scrollController.jumpTo(0.0),
                        widget.capituloScreenStatus.atualizaConteudo(widget.capituloScreenStatus.id! + 1)
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: const Color.fromRGBO(213, 232, 255, 1),
                        elevation: 5,
                        clipBehavior: Clip.antiAlias,
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          child: Text(
                            'Próximo',
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              decoration: TextDecoration.none,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Color.fromRGBO(52, 68, 86, 1.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    ));
  }
}

/*Text(
                          widget.capituloScreenStatus.conteudo.toString(),
                          style: const TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: 'Source Sans Pro',
                            fontWeight: FontWeight.w500,
                            fontSize: 22,
                            color: Color.fromRGBO(52, 68, 86, 1),
                          ),
                        ),
                        */
