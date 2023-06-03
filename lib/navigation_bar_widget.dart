import 'package:edifica/menu_page_status.dart';
import 'package:edifica/navigation_bar_item.dart';
import 'package:flutter/material.dart';

class NavigationBarWidget extends StatelessWidget {
  final MenuPageStatus menuPageStatus;
  const NavigationBarWidget({Key? key, required this.menuPageStatus})
      : super(key: key);

  static const TextStyle optionStyle = TextStyle(
      fontFamily: 'Source Sans Pro',
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      decoration: TextDecoration.none);
  static const TextStyle optionStyle2 = TextStyle(
      fontFamily: 'Source Sans Pro',
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: Color.fromRGBO(52, 68, 86, 1),
      decoration: TextDecoration.none);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Color.fromRGBO(213, 224, 237, 1),
              boxShadow: [
                //BoxShadow
                BoxShadow(
                  color: Color.fromRGBO(52, 68, 86, 0.5),
                  offset: Offset(0.0, -1.0),
                  blurRadius: 5.0,
                  spreadRadius: 0.1,
                ), //BoxShadow
              ],
            ), //const Color.fromRGBO(213, 224, 237, 1),
            height: 50,
            width: MediaQuery.of(context).size.width * 1,
          ),
          Container(
            color: Colors.transparent,
            height: 70,
            width: MediaQuery.of(context).size.width * 1,
            child: Padding(
                padding: const EdgeInsets.only(left: 0, right: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                  children: [for
                     (var i = 0; i < menuPageStatus.titles.length; i++)
                      NavigationBarItem(
                          menuPageStatus: menuPageStatus, index: i)
                  ],
                )
                /* ListView.builder(
                      scrollDirection: Axis.horizontal,
                        itemCount: menuPageStatus.titles.length,
                        itemBuilder: (_, index) {
                          return NavigationBarItem(
                              menuPageStatus: menuPageStatus, index: index);
                        }),*/
                ),
          )
        ],
      ),
    );
  }
}


/*
return Positioned(
      bottom: 0,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Color.fromRGBO(213, 224, 237, 1),
              boxShadow: [
                //BoxShadow
                BoxShadow(
                  color: Color.fromRGBO(52, 68, 86, 0.5),
                  offset: Offset(0.0, -1.0),
                  blurRadius: 5.0,
                  spreadRadius: 0.1,
                ), //BoxShadow
              ],
            ), //const Color.fromRGBO(213, 224, 237, 1),
            height: 60,
            width: MediaQuery.of(context).size.width * 1,
          ),
          Container(
            color: Colors.transparent,
            height: 80,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => {menuPageStatus.changeStatus(0)},
                      child: Observer(
                        builder: (_) {
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom: menuPageStatus.status == 0 ? 30 : 0,
                                top: menuPageStatus.status == 0 ? 0 : 22.5),
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12.0)),
                                  color: menuPageStatus.status == 0
                                      ? const Color.fromRGBO(113, 151, 194, 1)
                                      : Colors.transparent,
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: SvgPicture.asset(
                                        'assets/images/salvo_preenchido.svg',
                                        height: 30.0,
                                        color: menuPageStatus.status == 0
                                            ? Colors.white
                                            : const Color.fromRGBO(
                                                52, 68, 86, 1),
                                        semanticsLabel: 'Salvos'))),
                          );
                        },
                      ),
                    ),
                    GestureDetector(
                        onTap: () => {menuPageStatus.changeStatus(1)},
                        child: Observer(builder: (_) {
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom: menuPageStatus.status == 1 ? 20 : 0,
                                top: menuPageStatus.status == 1 ? 0 : 22.5),
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12.0)),
                                  color: menuPageStatus.status == 1
                                      ? const Color.fromRGBO(113, 151, 194, 1)
                                      : Colors.transparent,
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: SvgPicture.asset(
                                        'assets/images/estudo.svg',
                                        height: 30.0,
                                        color: menuPageStatus.status == 1
                                            ? Colors.white
                                            : const Color.fromRGBO(
                                                52, 68, 86, 1),
                                        semanticsLabel: 'Estudos'))),
                          );
                        })),
                    GestureDetector(
                      onTap: () => {menuPageStatus.changeStatus(2)},
                      child: Observer(builder: (_) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: menuPageStatus.status == 2 ? 20 : 0,
                              top: menuPageStatus.status == 2 ? 0 : 22.5),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12.0)),
                                color: menuPageStatus.status == 2
                                    ? const Color.fromRGBO(113, 151, 194, 1)
                                    : Colors.transparent,
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SvgPicture.asset(
                                      'assets/images/atividade.svg',
                                      height: 30.0,
                                      color: menuPageStatus.status == 2
                                          ? Colors.white
                                          : const Color.fromRGBO(52, 68, 86, 1),
                                      semanticsLabel: 'Atividades'))),
                        );
                      }),
                    ),
                    GestureDetector(
                      onTap: () => {menuPageStatus.changeStatus(3)},
                      child: Observer(
                        builder: (_) {
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom: menuPageStatus.status == 3 ? 20 : 0,
                                top: menuPageStatus.status == 3 ? 0 : 22.5),
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12.0)),
                                  color: menuPageStatus.status == 3
                                      ? const Color.fromRGBO(113, 151, 194, 1)
                                      : Colors.transparent,
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: SvgPicture.asset(
                                        'assets/images/nota.svg',
                                        height: 30.0,
                                        color: menuPageStatus.status == 3
                                            ? Colors.white
                                            : const Color.fromRGBO(
                                                52, 68, 86, 1),
                                        semanticsLabel: 'Notas'))),
                          );
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () => {menuPageStatus.changeStatus(4)},
                      child: Observer(builder: (_) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: menuPageStatus.status == 4 ? 20 : 0,
                              top: menuPageStatus.status == 4 ? 0 : 22.5),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12.0)),
                                color: menuPageStatus.status == 4
                                    ? const Color.fromRGBO(113, 151, 194, 1)
                                    : Colors.transparent,
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/images/projeto.svg',
                                          height: 30.0,
                                          color: menuPageStatus.status == 4
                                              ? Colors.white
                                              : const Color.fromRGBO(
                                                  52, 68, 86, 1),
                                          semanticsLabel: 'Projetos'),
                                      Text(menuPageStatus.status == 4
                                              ? '  Projetos' : '',
                                          style: optionStyle),
                                    ],
                                  ))),
                        );
                      }),
                    ),
                  ]),
            ),
          )
        ],
      ),
    );*/