import 'package:mobx/mobx.dart';

part 'menu_page_status.g.dart';

class MenuPageStatus = _MenuPageStatus with _$MenuPageStatus;

abstract class _MenuPageStatus with Store{

  @observable
  int status = 0;

  @observable
  String titleSection = 'Estudos';

  //@observable
  List<String> titles = ['Estudos', 'Atividades'];
  //List<String> titles = ['Salvos', 'Estudos', 'Atividades', 'Notas', 'Projetos'];

  @action
  void changeStatus(page){
    //List<String> titles = ['Salvos', 'Estudos', 'Atividades', 'Notas', 'Projetos'];
    if(status != page){
      status = page;
      titleSection = titles.elementAt(status);
    }
  }

}