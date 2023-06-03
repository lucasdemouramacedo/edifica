import 'package:edifica/atividades/atividades_section.dart';
import 'package:edifica/estudo/estudo_section.dart';
import 'package:edifica/menu_page_status.dart';
import 'package:edifica/navigation_bar_widget.dart';
import 'package:edifica/notas/notas_section.dart';
import 'package:edifica/projetos/projetos_section.dart';
import 'package:edifica/salvos/salvos_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class InicialPage extends StatelessWidget {
  const InicialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MenuPageStatus menuPageStatus = MenuPageStatus();
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Stack(children: [
        Observer(builder: (_) {
          return Positioned(
              top: MediaQuery.of(context).size.height * 0,
              child: Column(
                children: [

                  if (menuPageStatus.status == 0) ...[
                    const EstudoSection(),
                  ],
                  if (menuPageStatus.status == 1) ...[
                    const AtividadesSection(),
                  ],
                  
                ],
              ));
        }),
        NavigationBarWidget(menuPageStatus: menuPageStatus),
      ]),
    );
  }
}