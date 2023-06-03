import 'package:mobx/mobx.dart';
import 'package:edifica/db/dbprovider.dart';

part 'atividade_screen_status.g.dart';

class AtividadeScreenStatus = _AtividadeScreenStatus with _$AtividadeScreenStatus;

UnidadeDbProvider unidadeDb = UnidadeDbProvider();

abstract class _AtividadeScreenStatus  with Store{
  @observable
  int ?id;

  @observable
  String ?titulo;

  @observable
  String ?unidade;

  @observable
  String ?enunciado;

  @observable
  String ?respostaAluno;

  @observable
  String ?respostaCerta;

  @observable
  String ?tipo;

  @action
  Future<void> atualizaAtividade(id2) async {
    var atividade = await unidadeDb.getAtividadeById(id2);

    id = atividade[0].id as int?;
    titulo = atividade[0].nome as String?;
    unidade = atividade[0].unidadeNome as String?;
    enunciado = atividade[0].enunciado as String?;
    respostaAluno = atividade[0].respostaAluno as String?;
    respostaCerta = atividade[0].respostaCerta as String?;
    tipo = atividade[0].tipo as String?;
  }
}