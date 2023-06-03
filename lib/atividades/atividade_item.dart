import 'package:edifica/atividade_screen_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AtividadeItem extends StatelessWidget {
  final dynamic id, nome, respostaCerta, respostaAluno, tipo;
  final AtividadeScreenStatus atividadeScreenStatus;
  const AtividadeItem(
      {Key? key,
      required this.nome,
      this.id,
      required this.atividadeScreenStatus, this.respostaCerta, this.respostaAluno, this.tipo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color getColor() {
      if (respostaAluno == '') {
        return const Color.fromRGBO(213, 224, 237, 1);
      }else if (respostaAluno ==
          respostaCerta) {
        return const Color.fromRGBO(156, 223, 139, 1);
      }else {
        return const Color.fromRGBO(255, 114, 114, 1);
      }
      
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(10,0,10,5),
      child: InkWell(
        onTap: () => {
          atividadeScreenStatus.atualizaAtividade(id),
          Navigator.pushNamed(context, '/atividade', arguments: {
            'atividadeScreenStatus': atividadeScreenStatus,
          })
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 4,
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    nome,
                    style: const TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 22,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(52, 68, 86, 1.0),
                    ),
                  ),
                ),
                if(tipo.toString() != 'instrucao')
                SvgPicture.asset(
                  'assets/images/circle-check-solid.svg',
                  height: 25.0,
                  color: getColor(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
