import 'package:mobx/mobx.dart';
import 'package:edifica/db/dbprovider.dart';

part 'capitulo_screen_status.g.dart';

class CapituloScreenStatus = _CapituloScreenStatus with _$CapituloScreenStatus;

UnidadeDbProvider unidadeDb = UnidadeDbProvider();

abstract class _CapituloScreenStatus  with Store{
  @observable
  int ?id;

  @observable
  String ?titulo;

  @observable
  String ?unidade;

  @observable
  String ?conteudo;

  @observable
  String ?fonteImagem;

  @action
  Future<void> atualizaConteudo(id2) async {
    var capitulo = await unidadeDb.getCapituloById(id2);

    id = capitulo[0].id as int?;
    titulo = capitulo[0].nome as String?;
    unidade = capitulo[0].unidadeNome as String?;
    conteudo = capitulo[0].conteudo as String?;
    fonteImagem = capitulo[0].fonteImagem as String?;
  }
}