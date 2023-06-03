import 'package:edifica/models/atividade_model.dart';
import 'package:edifica/models/capitulo_model.dart';
import 'package:edifica/models/opcao_atividade_model.dart';
import 'package:sqflite/sqflite.dart'; //sqflite package
import 'package:path_provider/path_provider.dart'; //path_provider package
import 'package:path/path.dart'; //used to join paths
import '../models/unidade_model.dart'; //import model class
import 'dart:io';
import 'dart:async';

class UnidadeDbProvider {
  Future<Database> init() async {
    Directory directory =
        await getApplicationDocumentsDirectory(); //returns a directory which stores permanent files
    final path =
        join(directory.path, "edifica115.db"); //create path to database

    return await openDatabase(
        //open the database or create a database if there isn't any
        path,
        version: 2,
        onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    //print("Creating new database with version $version");

    // this could also be part of some kind of seed method
    await db.execute(
        " CREATE TABLE IF NOT EXISTS unidade (id INTEGER PRIMARY KEY, nome TEXT);");
    await db.execute(
        " CREATE TABLE IF NOT EXISTS capitulo (id INTEGER PRIMARY KEY, nome TEXT, conteudo TEXT, unidadefk INTEGER REFERENCES unidade (id), fonteImagem TEXT);");
    await db.execute(
        " CREATE TABLE IF NOT EXISTS atividade (id INTEGER PRIMARY KEY, nome TEXT, enunciado TEXT, respostaCerta TEXT, respostaAluno TEXT, tipo TEXT, unidadefk INTEGER REFERENCES unidade (id));");
    await db.execute(
        " CREATE TABLE IF NOT EXISTS opcoesatividade (id INTEGER PRIMARY KEY, enunciado TEXT, atividadefk INTEGER REFERENCES atividade (id));");

    await _createDefaultUnidades(db);
    await _createDefaultAtividades(db);
    await _createDefaultOpcoesAtividade(db);
  }

  Future<void> _createDefaultUnidades(Database database) async {
    await database.insert(
        'unidade', UnidadeModel(id: 1, nome: 'Histórico').toMap());
    await database.insert('unidade',
        UnidadeModel(id: 2, nome: 'Instrumentos para desenho').toMap());
    await database.insert(
        'unidade', UnidadeModel(id: 3, nome: 'Formatos de papel').toMap());
    await database.insert(
        'unidade',
        UnidadeModel(
                id: 4,
                nome:
                    'Caligrafia Técnica, Tipos de Linhas e Cotagem em Desenho Técnico')
            .toMap());
    await database.insert(
        'unidade', UnidadeModel(id: 5, nome: 'Desenho projetivo').toMap());
    await database.insert('unidade',
        UnidadeModel(id: 6, nome: 'Perspectivas de Sólidos').toMap());

    await database.insert(
        'capitulo',
        CapituloModel(
                id: 1,
                nome: 'Introdução',
                conteudo: r"""
<paragrafo>
Caro usuário,
**Nesta seção, você irá estudar a importância do desenho técnico na atualidade,
bem como, compreenderá a diferença entre o desenho artístico e técnico, e
sua relação com a geometria descritiva. Conhecerá a normalização do desenho
conforme a Associação Brasileira de Normas Técnicas (ABNT), que no Brasil é
a entidade responsável pelas normas técnicas, tanto em aprovação como em
edição. E por fim, trataremos sobre a contribuição da informática na construção
de desenhos técnicos.
*O objetivo desta seção é que você reflita sobre a importância do desenho
técnico.
</paragrafo>
<h2>Convite ao estudo</h2>
<h3>Qual a importância de estudar desenho técnico?</h3>
<paragrafo>
Através do estudo do desenho técnico é possível solucionar vários problemas
ligados à área de engenharia e arquitetura. O desenho técnico tem por
finalidade a representação de forma, dimensão e posição de objetos, o mais
próximo do real. Dessa forma, a arte de representar um objeto ou fazer sua
leitura por meio do desenho técnico é tão importante quanto à execução de
uma tarefa, pois é o desenho que fornece todas as informações precisas e
necessárias para a construção de uma peça. Fazendo com que vários
profissionais necessitem do conhecimento desta ferramenta, como por
exemplo: engenheiros, arquitetos, urbanistas, técnicos, entre outros, a fim de
evitar erros que poderiam prejudicar o ajuste de peças e comprometer o nível
estrutural.
</paragrafo>
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n"),
                unidadefk: 1,
                fonteImagem: '')
            .toMap());
    await database.insert(
        'capitulo',
        CapituloModel(
                id: 2,
                nome: 'O desenho como meio de comunicação',
                conteudo: r"""
<paragrafo>
A comunicação gráfica é imprescindível para transmissão de conteúdos, idéias
e pensamentos. Trata-se de uma linguagem que tem elementos não-textuais
como códigos a serem lidos e interpretados. Uma das formas mais comuns de
comunicação gráfica é o desenho. No caso mais geral, um desenho pode ser
entendido como uma representação gráfica de ideias, conceitos e entidades
reais ou imaginárias. Assim, podemos dizer que o profissional que desenha
passa seus pensamentos para o papel de uma forma técnica, clara e objetiva.
</paragrafo>
<card label ="Esclarecendo melhor">
Para exemplificar melhor, a Figura 1.1 apresenta uma imagem. Contudo,
nos permite expressar varias ideias do autor. O que essa imagem
representa para você?
</card>
<img src="assets/images/capitulos/figura11.jpg" alt="Figura 1.1 | Imagem de desenho animado" fonte="https://br.pinterest.com/pin/785385622491685156" />
<paragrafo>
O desenho é, na verdade, uma das formas de comunicação mais antigas, que
surgiu antes da comunicação verbal. As representações gráficas feitos pelos
povos antigos, como ilustra a Figura 1.2, proporcionaram grandes contribuições
para a compreensão da história, pois possibilitaram às gerações
contemporâneas conhecerem as técnicas destes povos, seus hábitos,
costumes e ate suas ideias, pois demonstravam cenas do cotidiano.
</paragrafo>
<paragrafo>
Assim a técnica sempre esteve presente desde os primórdios da história da
humanidade, possibilitando ao ser humano alcançar o seu objetivo através de
uma ação consciente em um contexto de acumulação de conhecimentos.
Através da técnica foi possível o ser humano promover um processo de
melhoria e aperfeiçoamentos contínuos interferindo em seu meio.
</paragrafo>
<img src="assets/images/capitulos/figura12.jpg" alt="Figura 1.2 | Pintura rupestre" fonte="https://pt.wikipedia.org/wiki/Arte_rupestre#/media/Ficheiro:Serra_da_Capivara_-_Several_Paintings_2b.jpg" />
<paragrafo>
Com o passar, as formas de representação gráfica se tornaram mais
frequentemente utilizadas nas diversas áreas do conhecimento, dando-se
particular enfoque aos diferentes tipos de desenhos. De um modo simples e
abrangente, pode-se dizer que os principais tipos de desenhos usados nas
representações gráficas são o desenho artístico e o desenho técnico.
</paragrafo>
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n"),
                unidadefk: 1,
                fonteImagem:
                    'https://www.rfi.fr/br/ciencias/20100916-especialistas-questionam-datacao-de-pinturas-rupestres-no-piaui')
            .toMap());
    await database.insert(
        'capitulo',
        CapituloModel(
                id: 3,
                nome: 'O desenho artístico',
                conteudo: r"""
<paragrafo>
O desenho artístico objetiva comunicar ideias e sensações, através do estímulo
da imaginação e criatividade do observador ou leitor, podendo ser desde uma
simples linha, até ao mais famoso quadro.
</paragrafo>
<paragrafo>
Os desenhos artísticos são, em geral, acompanhados de um título e um
resumo descritivo, os quais, por sua vez, dão origem a diferentes
interpretações.
</paragrafo>
<paragrafo>
Em suma, o desenho artístico possibilita, tanto ao autor, como ao leitor, amplos
graus de liberdade em termos de representação e interpretação das obras.
</paragrafo>
<card label="Esclarecendo melhor">
Você já deve ter visto a representação da famosa obra de Leonardo Da
Vinci, a Mona Lisa. O quadro representa uma mulher com uma expressão
introspectiva e um pouco tímida. O seu sorriso restrito é muito sedutor,
mesmo que um pouco conservador. O seu corpo representa o padrão de
beleza da mulher na época de Leonardo. A Figura 1.3 assim como outras
representações artísticas são exemplos de desenhos artísticos.
</card>
<img src="assets/images/capitulos/figura13.jpg" alt="Figura 1.3 | Mona Lisa" fonte="https://pt.wikipedia.org/wiki/Mona_Lisa" />

"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n"),
                unidadefk: 1,
                fonteImagem:
                    'https://www.amazon.com.br/pintura-n%C3%BAmeros-estrelado-abstrata-iniciantes/dp/B096Y5WDYF')
            .toMap());
    await database.insert(
        'capitulo',
        CapituloModel(
                id: 4,
                nome: 'O desenho técnico',
                conteudo: r"""
<paragrafo>
O desenho técnico, por sua vez, objetiva representar objetos o mais próximo
possível da realidade, no que diz respeito às formas, às dimensões, às
especificações físicas e técnicas dos objetos.
</paragrafo>
<paragrafo>
Um desenho técnico é, pois, um meio de comunicação claro e conciso de toda
a informação necessária para transformar uma ideia ou um conceito em
realidade. Assim, qualquer profissional que venha a interpretar um desenho
técnico terá o mesmo grau de interpretação.
</paragrafo>
<paragrafo>
O desenho técnico é, portanto, uma linguagem universal utilizada por
desenhistas, projetistas, engenheiros e arquitetos no desenvolvimento de
peças e na resolução de problemas, necessitando que os profissionais sejam
conhecedores das regras e normas associados ao desenho técnico. De uma
maneira geral, um desenho técnico pode ser executado à mão livre, recorrendo
a técnicas e recursos mecânicos, ou ainda utilizando recursos e meios
computacionais.
</paragrafo>
<card label="Esclarecendo melhor">
A Figura 1.4(a) apresenta um desenho técnico da área de
arquitetura/construção civil, e a Figura 1.4(b), um desenho técnico
mecânico. Ambos informar as dimensões, formas e especificações
técnicas.
</card>
<img src="assets/images/capitulos/figura14.jpg" alt="Figura 1.4 | Desenhos técnicos de diferentes áreas" fonte="https://www.google.com/search?rlz=1C1VSNE_enBR730BR754&amp;biw=1366&amp;bih=657&amp;tbm=isch&amp;sxsrf=ACYBGNQVagmrO3_Ofi_y_gmXU1OXqN672Q%3A1577393958634&amp;sa=1&amp;ei=Jh8FXuKpJpGg5OUP2f6pqAM&amp;q=desenho+tecnico+mecanico+e+arquitetonico&amp;oq=desenho+tecnico+mecanico+e+arquitetonico&amp;gs_l=img.3...0.0..30...0.0..0.0.0.......0......gws-wiz-img.ivzdov12F7s&amp;ved=0ahUKEwji1My0mtTmAhURELkGHVl_CjUQ4dUDCAc&amp;uact=5#imgrc=EM2oWZSgvQSQMM" />
<card label="Para refletir">
Olhe a sua volta! Observe os objetos que você utiliza em seu cotidiano,
desde sua caneta até seu celular. Eles foram planejados e projetados
usando os conceitos de desenho técnico para sua fabricação.
</card>
<card label="Assimilando">
Quais são os principais tipos de desenhos usados nas representações
gráficas?
*• Desenho técnico: transmite com exatidão todas as características do
objeto e é interpretado da mesma maneira por diversos profissionais.
*• Desenho artístico: transmite a ideia do artista e suas emoções de maneira
pessoal. Um artista não tem o compromisso de retratar fielmente a
realidade.
</card>
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n"),
                unidadefk: 1,
                fonteImagem:
                    'https://www.vivadecora.com.br/pro/desenho-tecnico/')
            .toMap());
    await database.insert(
        'capitulo',
        CapituloModel(
                id: 5,
                nome: 'A geometria descritiva',
                conteudo: r"""
<paragrafo>
Os conceitos da Geometria Descritiva constituem a base do Desenho Técnico.
Ainda que esses conceitos já fossem abordados intuitivamente desde a
antiguidade, as bases da Geometria Descritiva foram criadas no final do século
XVIII pelo matemático francês Gaspar Monge.
</paragrafo>
<paragrafo>
Esta ciência tem por objetivo representar no plano (folha de desenho, quadro,
etc.) através de projeções os objetos tridimensionais, permitindo desta forma a
resolução de infinitos problemas envolvendo qualquer tipo de poliedro, no plano
do papel.
</paragrafo>
<card label="Saiba mais">
Mais à frente falaremos sobre projeções e perspectivas. Para que você
tenha maior conhecimento sobre esse assunto, consulte a livro Noções e
Fundamentos de Geometria Descritiva da autora Maria Helena Lacourt.
</card>
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n"),
                unidadefk: 1,
                fonteImagem:
                    'https://br.depositphotos.com/472860032/stock-photo-construction-three-dimensional-polygons-according.html')
            .toMap());
    await database.insert(
        'capitulo',
        CapituloModel(
                id: 6,
                nome: 'A normalização',
                conteudo: r"""
<paragrafo>
Assim como existem as regras a serem seguidas no trânsito, no trabalho, na
escola, no desenho técnico não é diferente. Essas regras são designadas
normas técnicas e devem ser aplicadas durante todo o processo de
desenvolvimento de um projeto, uma vez que se trata de uma competência
internacional que regulamenta os desenhos no mundo todo.
</paragrafo>
<paragrafo>
No Brasil, os desenhos técnicos são normatizados pela Associação Brasileira
de Normas Técnicas (ABNT) e internacionalmente pela International
Organization for Standardization (ISO). Tais normas são editadas pela ABNT,
registradas pelo INMETRO (Instituto Nacional de Metrologia, Normalização e
Qualidade Industrial) como Normas Brasileiras Regulamentadoras (NBR) e
estão em consonância com as normas internacionais aprovadas pela ISO.
</paragrafo>
<paragrafo>
As principais normas utilizadas em desenho técnico no Brasil são:
</paragrafo>
<paragrafo>
• NBR 16752 - Desenho Técnico - Requisitos para apresentação em folhas de
desenho: padroniza os formatos das folhas, os elementos gráficos, disposição
para espaço de desenho e legenda, dobramento de copias e o emprego de
escalas utilizadas em desenho.
</paragrafo>
<paragrafo>
• NBR 8402 - Caligrafia técnica: execução de caracteres para escrita em
desenhos técnicos.
</paragrafo>
<paragrafo>
• NBR 8403 - Aplicação de linhas em desenho técnico: tipos e largura das
linhas.
</paragrafo>
<paragrafo>
• NBR 10067 - Princípios gerais de representação em desenho técnico: essa
norma fixa a forma de representação aplicada em desenho técnico.
</paragrafo>
<paragrafo>
• NBR 12298 - Representação de áreas de corte por meio de hachuras em
desenho técnico.
</paragrafo>
<paragrafo>
• NBR 10126 - Emprego de cotas em desenho técnico.
</paragrafo>
<card label="Se liga">
A ABNT tem um link onde você pode adquirir as normas técnicas
completas, porém, as normas são pagas para quem não é associado na
ABNT. Link: http://www.abntcatalogo.com.br/.
</card>
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n"),
                unidadefk: 1,
                fonteImagem:
                    'https://engrenapecas.com.br/engrenagem-o-que-e-quais-sao-os-seus-principais-modelos-aprenda-tudo-sobre-esse-dispositivo-mecanico/')
            .toMap());
    await database.insert(
        'capitulo',
        CapituloModel(
                id: 7,
                nome: 'A informática',
                conteudo: r"""
<paragrafo>
No decorrer do tempo, a comunicação através do desenho foi se aprimorando,
ao mesmo que, as técnicas de desenho foram evoluindo. Tradicionalmente, o
desenho era construído a partir de técnicas manuais, na atualidade, através do
desenvolvimento da informática, o Desenho com Auxílio do Computador (CAD)
tem-se consagrado.
</paragrafo>
<paragrafo>
O desenho auxiliado por computador utiliza de programas computacionais para
representar os desenhos técnicos. Existem diversos programas com essa
mesma funcionalidade, como: Inventor, Pro_Engineer, Catia, AutoCAD,
SolidWorks, Solid Edge, Revit, Sketchup, dentre outros.
</paragrafo>
<paragrafo>
Entretanto, o desenho técnico com auxilio do computador necessita do
conhecimento prévio do desenho técnico (BALDAN, 2002). Daí se tem a
importância de conhecer as técnicas para elaboração de desenhos projetivos
conforme normatizações específicas. Pois, engana-se quem pensa que um
bom software desenvolve um bom projeto sem o projetista ter o domínio de
conceitos de desenho técnico.
</paragrafo>
<card label="Para refletir">
O desenho técnico é a ferramenta essencial para a interpretação e
representação de um projeto, por ser o instrumento de comunicação entre
a equipe de criação e a de execução (fabricação). Ocorre que muitas das
vezes, nem sempre quem projetou a peça é o mesmo que irá executá-la.
Por esse motivo, é fundamental que o projeto seja preciso, contendo todas
as informações pertinentes a fim de evitar erros na sua execução.
</card>
<card label="Saiba mais">
O conteúdo de estudo deste aplicativo irá contribuir para a sua
compreensão sobre o desenho técnico.*
O autoestudo é característica fundamental para a apreensão de
conhecimentos e formação de um profissional.
</card>
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n")
                    .replaceAll('\n ', "\n"),
                unidadefk: 1,
                fonteImagem:
                    'https://cursandotecnico.com.br/curso/desenho-tecnico-auxiliado-por-computador-e-processos-de-fabricacao')
            .toMap());
    await database.insert(
        'capitulo',
        CapituloModel(
                id: 8,
                nome: 'Introdução',
                conteudo: r"""
<paragrafo>
Caro usuário,
**Nesta seção, você conhecerá os instrumentos utilizados para elaboração de
desenho técnico e sua forma de uso. Trataremos dos principais instrumentos
utilizados em desenho técnico, como: os lápis, lapiseiras e grafites, a borracha,
a régua, o escalímetro, os esquadros, o compasso e o papel para desenho.
O objetivo desta seção é que você conheça os instrumentos de desenho e sua
forma correta de uso.
</paragrafo>
<h2>Convite ao estudo</h2>
<h3>Mas, afinal, qual a importância dos instrumentos de desenho?</h3>
<paragrafo>
O desenho técnico, para ser bem executado, necessita do uso correto dos
materiais e instrumentos de desenho quando executado manualmente.
Embora, hoje em dia os projetos sejam desenvolvidos em softwares
específicos, é fundamental que você domine os processos de elaboração das
convenções gráficas. Uma vez que, o que difere nos dois casos, é apenas a
maneira de execução, sendo idênticos os seus princípios fundamentais, tanto
para o desenho manual como para o desenho virtual, ou seja, as regras são
aplicadas para ambos os casos.
</paragrafo>
<paragrafo>
No entanto, o desenho feito à mão livre tem muita importância no cotidiano
dos profissionais da área, sejam técnicos, engenheiros, arquitetos, etc. Na
obra, muitas vezes será necessário que façamos esboços de determinados
detalhes que não são compreendidos pelos executores do projeto.
</paragrafo>
<card label="Se liga">
Qualquer aluno terá facilidade com o desenho técnico, desde que se
dedique a entender as regras e procedimentos lógicos e execute a
representação gráfica com dedicação, desenhará bem.
</card>
<paragrafo>
Os instrumentos para execução de desenho têm como objetivo principal,
auxiliar na apresentação dos desenhos, tornando-os mais claros e bem-
acabados. Entre os equipamentos utilizados no desenho técnico instrumental,
os principais são: os lápis, lapiseiras e grafites, a borracha, a régua, o
escalímetro, os esquadros, o compasso.
</paragrafo>
<paragrafo>
É provável, que você já conheça alguns deles e saiba utilizá-los. Abaixo, segue
uma explicação sobre cada um desses instrumentos.
</paragrafo>
""",
                unidadefk: 2,
                fonteImagem:
                    'https://blog.grafittiartes.com.br/conheca-os-materiais-mais-indicados-para-desenho-tecnico/')
            .toMap());
    await database.insert(
        'capitulo',
        CapituloModel(
                id: 9,
                nome: 'Lápis, lapiseiras e grafite, borracha e régua',
                conteudo: r"""
<h2>Lápis, lapiseiras e grafite</h2>
<paragrafo>
O lápis comum de madeira pode ser usado para desenho. O lápis dever ser
apontado, afiado com uma lixa pequena e, logo após, ser limpo com algodão,
pano ou papel para se obter um traço uniforme.
</paragrafo>
<paragrafo>
De maneira geral, costuma se classificar o lápis através de letras, números, ou
ambos, de acordo com o grau de dureza do grafite (também chamado de
“mina”).
</paragrafo>
<h3>Classificação por números:</h3>
<paragrafo>
Nº 1 - macio, geralmente usado para esboçar e para destacar traços que
devem sobressair;*
Nº 2 - médio, é o mais usado para qualquer traçado e para a escrita em geral;*
Nº 3 - duro, usado em desenho geométrico e técnico.
</paragrafo>
<h3>Classificação por letras:</h3>
<paragrafo>
A classificação mais comum é H para o lápis duro e B para lápis macio. Esta
classificação precedida de números dará a gradação que vai de 6B (muito
macio) à 9H (muito duro), sendo HB a gradação intermediária.
</paragrafo>
<img src="assets/images/capitulos/figura21.jpg" alt="Figura 2.1 | Lápis de desenho" fonte="https://www.ifmg.edu.br/ceadop3/apostilas/desenho-tecnico" />
<paragrafo>
As lapiseiras são designadas quanto à graduação da espessura do grafite,
sendo geralmente encontradas as de numero: 0,3 mm, 0,5 mm, 0,7 mm e 0,9
mm. Recomenda-se que a lapiseira tenha uma ponta de aço, com o intuito de
proteger o grafite da quebra quando pressionado sobre o papel.
</paragrafo>
<card label="Para refletir">
Afinal, qual utilizar, lápis ou lapiseira?**
O lápis necessita de outras ferramentas para o seu uso, como por exemplo,
o apontador. Assim, a lapiseira se torna mais prática para o uso.*
Agora a escolha é sua!
</card>
<card label="Se liga">
Na disciplina de Desenho Técnico não é permitido o uso de caneta por
parte dos estudantes.
</card>
<h2>Borracha</h2>
<paragrafo>
Sempre use borracha macia, compatível com o trabalho para evitar danificar a
superfície do desenho e do tipo prismática, para facilitar a aplicação de seus
vértices em áreas pequenas do desenho. Evite o uso de borrachas para tinta,
que geralmente são mais abrasivas para a superfície de desenho.
</paragrafo>
<h2>Régua</h2>
<paragrafo>
A régua é um instrumento utilizado em desenho técnico com o objetivo de
traçar segmentos de retas e medir pequenas distâncias. Normalmente medem
em centímetros e milímetros, mas dependendo da necessidade, em alguns
casos podem medir em polegadas.
</paragrafo>
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n")
                    .replaceAll('\n ', "\n"),
                unidadefk: 2,
                fonteImagem:
                    'https://casa.abril.com.br/arquitetura/acao-arrecada-materiais-para-estudantes-de-arquitetura-com-baixa-renda/')
            .toMap());
    await database.insert(
        'capitulo',
        CapituloModel(
                id: 10,
                nome: 'Escalímetro',
                conteudo: r"""
<paragrafo>
O escalímetro é uma régua-escala de seção triangular contendo seis escalas
gráficas em suas faces. Esse instrumento evita os cálculos na conversão de
medidas para uma determinada escala, agilizando a elaboração do desenho.
Existem diferentes escalímetros com escalas apropriadas para cada tipo de
representação gráfica. É recomendado a utilização do Escalímetro n° 1 com as
escalas: 1/125; 1/100; 1/75; 1/50; 1/25 e 1/20 para construção de desenhos
arquitetônicos.
</paragrafo>
<img src="assets/images/capitulos/figura22.jpg" alt="Figura 2.2 | Escalímetro" fonte="https://www.ifmg.edu.br/ceadop3/apostilas/desenho-tecnico" />
<card label="Esclarecendo melhor">
Independente da escala a ser usada no escalímetro, o n° 1 representará
sempre 1 m em escala, conforme mostra a Figura 2.3.
</card>
<img src="assets/images/capitulos/figura23.jpg" alt="Figura 2.3 | Marcação do Escalímetro" fonte="https://www.ifmg.edu.br/ceadop3/apostilas/desenho-tecnico" />
<card label="Se liga">
O escalímetro não deve ser utilizado no traçado de linhas. Ele é utilizado
apenas para medições, evitando-se o desgaste das marcações das
escalas. As linhas devem ser traçadas com o auxílio dos esquadros ou da
régua.
</card>
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n")
                    .replaceAll('\n ', "\n"),
                unidadefk: 2,
                fonteImagem: 'https://desenho-tecnico-eq9.webnode.page/')
            .toMap());
    await database.insert(
        'capitulo',
        CapituloModel(
                id: 11,
                nome: 'Esquadros',
                conteudo: r"""
<paragrafo>
Em desenho técnico deve se utilizar um par de esquadros, que consiste em um
conjunto formado por duas peças de formato triangular, sendo um contendo
ângulos de 45º, 45º e 90º e o outro com ângulos de 30º, 60º e 90º, como indica
a Figura 2.4.
</paragrafo>
<img src="assets/images/capitulos/figura24.jpg" alt="Figura 2.4 | Modelo de par de esquadros" fonte="https://www.ifmg.edu.br/ceadop3/apostilas/desenho-tecnico" />
<paragrafo>
O par de esquadros é utilizado em desenho técnico para solução de problemas
de geometria gráfica e também para traçar linhas verticais, horizontais e
inclinadas, conforme demonstra a Figura 2.5.
</paragrafo>
<img src="assets/images/capitulos/figura25.jpg" alt="Figura 2.5 | Utilização correta do esquadro" fonte="https://www.ifmg.edu.br/ceadop3/apostilas/desenho-tecnico" />
<card label="Esclarecendo melhor">
O par de esquadros deve ser utilizado apoiado na borda superior da régua
T ou da régua paralela, fixada na prancheta de desenho.*
Combinando o par de esquadros, pode-se obter uma série de ângulos sem
o auxílio do transferidor, como mostra a Figura 2.6.
</card>
<img src="assets/images/capitulos/figura26.jpg" alt="Figura 2.6 | Ângulos obtidos com a combinação dos esquadros" fonte="https://www.ifmg.edu.br/ceadop3/apostilas/desenho-tecnico" />
<card label="Saiba mais">
Quer revisar sobre o uso dos esquadros? Quando estiver conectado com a
internet acesse o link a seguir e assista ao vídeo de apoio da utilização do
par de esquadros.*
Disponível em: https://www.youtube.com/watch?v=oE_HcRBCfMY&gt. Acesso em: 25 dez. 2019.
</card>
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n")
                    .replaceAll('\n ', "\n"),
                unidadefk: 2,
                fonteImagem:
                    'https://www.galwan.com.br/dia-arquiteto-voce-sabe-importancia-dessa-profissao/')
            .toMap());
    await database.insert(
        'capitulo',
        CapituloModel(
                id: 12,
                nome: 'Compasso',
                conteudo: r"""
<paragrafo>
O compasso é o instrumento que é utilizado para traçar circunferências ou
arcos de circunferências e transportar medidas. O compasso não deve possuir
folga nas articulações, oferecendo um ajuste perfeito.
</paragrafo>
<paragrafo>
O compasso é usado fixando a ponta seca no centro da circunferência a traçar
e se segura firme o compasso pela parte superior. Ao abrirmos o compasso,
obtemos uma distância fixa entre uma ponta seca e a ponta com grafite. Esta
distância determina o raio da circunferência ou raio a ser traçado.
</paragrafo>
<img src="assets/images/capitulos/figura27.jpg" alt="Figura 2.7 | Compasso" fonte="https://www.ifmg.edu.br/ceadop3/apostilas/desenho-tecnico" />
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n")
                    .replaceAll('\n ', "\n"),
                unidadefk: 2,
                fonteImagem:
                    'https://br.freepik.com/fotos-gratis/crachas-de-dedos-de-negocios-cientificos-engenheiro-de-distancia_1235261.htm#query=compasso%20engenharia&position=49&from_view=search&track=ais')
            .toMap());
    await database.insert(
        'capitulo',
        CapituloModel(
                id: 13,
                nome: 'Papel',
                conteudo: r"""
<paragrafo>
Os papéis mais utilizados no desenho técnico são: papel canson, papel
manteiga e papel vegetal.
</paragrafo>
<paragrafo>
Para facilitar a execução de desenhos, o papel deve ser fixado nas quatro
bordas na prancheta de desenho, alinhado com a régua T ou a régua
paralela, conforme a Figura 2.8.
</paragrafo>
<img src="assets/images/capitulos/figura28.jpg" alt="Figura 2.8 | Fixação do papel na prancheta" fonte="https://www.ifmg.edu.br/ceadop3/apostilas/desenho-tecnico" />
<paragrafo>
A seguir, abordaremos sobre os formatos de papel.
</paragrafo>
<card label="Se liga">
Nesta seção, você estudou sobre os principais instrumentos utilizados em
Desenho Técnico, bem como sua utilização para elaboração dos desenhos.*
Então agora, treine para dominar a maneira correta de uso de todos os
instrumentos e se for preciso, repita as atividades. Não desanime, bom
trabalho!
</card>
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n")
                    .replaceAll('\n ', "\n"),
                unidadefk: 2,
                fonteImagem: 'https://conceitosdomundo.pt/desenho-tecnico/')
            .toMap());
    await database.insert(
        'capitulo',
        CapituloModel(
                id: 14,
                nome: 'Introdução',
                conteudo: r"""
<paragrafo>
Caro usuário,
**Nesta seção, você conhecerá os formatos de papel recomendados para
desenho técnico, que são da série 'A' normatizados pela ABNT, sendo
derivados a partir das bipartições do formato A0 (A zero). Além disso, você
conhecerá os principais requisitos para apresentação em folhas de desenho,
como, margem, legenda, localização e disposição do desenho, legenda
empregada, dobragem do formato, entre outras recomendações.
</paragrafo>
<paragrafo>
O objetivo desta seção é que você formate o papel para desenho.
</paragrafo>
<h2>Convite ao estudo</h2>
<h3>Por que eu preciso formatar o papel para desenho?</h3>
<paragrafo>
O papel é um dos componentes básicos do material de desenho. As
características dimensionais das folhas em branco e para impressão a serem
aplicadas em todos os desenhos técnicos, são padronizadas. Além disso, é
importante que você organize o espaço da folha para apresentação do
desenho e a maneira correta que o papel deve ser dobrado para arquivamento.
</paragrafo>
<paragrafo>
A seguir, são apresentadas as normas utilizadas para este estudo.
</paragrafo>
<h3>Normas:</h3>
<paragrafo>
• NBR 16752 - Desenho Técnico: Requisitos para apresentação em folhas de
desenho - normaliza o formato das folhas de desenho e os elementos gráficos,
a localização e a disposição do espaço para desenho, espaço para
informações complementares e legenda, o dobramento de cópias e o emprego
de escalas a serem empregadas em desenhos técnicos.
</paragrafo>
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n")
                    .replaceAll('\n ', "\n"),
                unidadefk: 3,
                fonteImagem:
                    'https://copiadora.flycopy.com.br/formatos-de-papel/')
            .toMap());
    await database.insert(
        'capitulo',
        CapituloModel(
                id: 15,
                nome: 'Formatos padronizados da série A',
                conteudo: r"""
<paragrafo>
O primeiro tamanho é o formato A0 com dimensões de 841 X 1189 mm,
equivalendo a um retângulo com 1 m² de área, e os demais formatos
originam-se da bipartição sucessiva deste, conforme mostra a Figura 3.1.
</paragrafo>
<img src="assets/images/capitulos/figura31.jpg" alt="Figura 3.1 | Formato/Dimensões" fonte="" />
<card label="Para refletir">
Precisamos refletir sobre o consumo de papel impresso que muitas vezes,
nem é necessário. Antes que o projeto seja impresso, certifique-se que ele
está de acordo com todas as especificações e se de fato, é preciso sua
impressão, pois, o melhor seria que o projeto fosse discutido virtualmente.
Certifique-se também se a representação do desenho está inserida em um
formato ideal, evitando desperdício de papel. Vamos pensar no meio
ambiente!
</card>
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n")
                    .replaceAll('\n ', "\n"),
                unidadefk: 3,
                fonteImagem:
                    'https://graficaluzane.com.br/ja-conhece-os-formatos-de-papel-e-quais-sao-recomendados-para-as-impressoes-leia-nosso-artigo-e-conheca-mais/')
            .toMap());
    await database.insert(
        'capitulo',
        CapituloModel(
                id: 16,
                nome: 'Margem e quadro',
                conteudo: r"""
<paragrafo>
As margens são limitadas pelo contorno externo da folha e o quadro. O
quadro limita o espaço para o desenho, de acordo mostra a figura a seguir.
</paragrafo>
<img src="assets/images/capitulos/figura32.jpg" alt="Figura 3.2 | Margem e quadro" fonte="" />
<card label="Se liga">
Para todos os formatos a margem da esquerda é de 20 mm de largura.
Este espaço é destinado para perfuração ou colocação de grampos para
arquivamento. Todas as demais margens devem ter 10 mm de largura,
conforme apresenta a Tabela 01.**
Então, tenha atenção ao traçar as margens!
</card>
<paragrafo>
Os formatos mais utilizados da Série A estão informados abaixo, na
Tabela 01, com suas respectivas dimensões, margens, espaço para desenho e
largura da linha do quadro.
</paragrafo>
<img src="assets/images/capitulos/tabela01.jpg" alt="Tabela 01: Especificações dos formatos da Série A em mm" fonte="" />
card label="Se liga">
Quanto à posição das folhas de desenhos, podem ser utilizadas tanto na
posição horizontal quanto na vertical. Recomenda-se que os formatos
superiores ao A4 sejam utilizados na posição horizontal.
</card>
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n")
                    .replaceAll('\n ', "\n"),
                unidadefk: 3,
                fonteImagem:
                    'https://suporte.promob.com/hc/pt-br/articles/360049798374-Mooble-Design-Imprimir')
            .toMap());
    await database.insert(
        'capitulo',
        CapituloModel(
                id: 17,
                nome: 'Marcas de centro',
                conteudo: r"""
<paragrafo>
Quatro marcas de centro devem ser inseridas na folha de desenho a fim
de auxiliar o posicionamento, quando reproduzido ou microfilmado. Estas
marcas devem ser situadas nas extremidades dos eixos de simetria e
horizontal e vertical da folha, conforme ilustrado na Figura 3.3. Cada marca
deve ser feita com uma linha contínua de 0,7 mm de largura, iniciando na
extremidade da malha de referência e indo até 10 mm além do quadro. Para os
formatos maiores que A0 devem ser feitas marcas de centro adicionais.
</paragrafo>
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n")
                    .replaceAll('\n ', "\n"),
                unidadefk: 3,
                fonteImagem:
                    'https://archiurban.wordpress.com/2015/03/13/nbr-10068-1987/')
            .toMap());
    await database.insert(
        'capitulo',
        CapituloModel(
                id: 18,
                nome: 'Sistema de referência por malhas',
                conteudo: r"""
<paragrafo>
Para facilitar a localização de detalhes, cortes, vistas, revisões e informações
no desenho, as folhas devem ser dividias em campos compreendidos na
margem e adjacentes ao quadro por meio de coordenadas alfanuméricas.
</paragrafo>
<paragrafo>
Segue as recomendações para construção das malhas:
</paragrafo>
<paragrafo>
- Cada campo individual deve possuir 5 mm de largura e 50 mm de
comprimento a partir dos eixos de simetria da folha de desenho (Ver Figura
3.3).
</paragrafo>
<paragrafo>
- O número total de campos varia de acordo o formato da folha de desenho, na
Tabela 02 está apresentado o numero de divisão das malhas.
</paragrafo>
<paragrafo>
- As diferenças resultantes das divisões devem ser adicionadas aos campos
das extremidades.
</paragrafo>
<paragrafo>
- As malhas devem ser executadas em linha contínua estreita com 0,35 mm de
largura.
</paragrafo>
<paragrafo>
- Para identificação das malhas serão utilizados letras e números nos dois
lados da folha, assim, os campos individuais serão referenciados de cima para
baixo com letras maiúsculas do alfabeto, exceto as letras I e O, e da esquerda
para a direita através de números (Ver Figura 3.3).
</paragrafo>
<paragrafo>
- No formato A4 será utilizado apena o lado superior e o lado direito para
inserção do sistema de malha.
</paragrafo>
<paragrafo>
- As letras e os números devem ser inseridos em escrita vertical e com
tamanho nominal de 3,5 mm.
</paragrafo>
<paragrafo>
- Se caso o numero de divisões ultrapassarem o número de letras do alfabeto,
utilizar as letras de referencia, AA, AB, AC, e assim por diante.
</paragrafo>
<paragrafo>
- O formato utilizado deve ser indicado no campo inferior direito da malha (Ver
Figura 3.3).
</paragrafo>
<img src="assets/images/capitulos/tabela02.jpg" alt="Tabela 02: Número de divisões das malhas" fonte="" />
<img src="assets/images/capitulos/figura33.jpg" alt="Figura 3.3 | Referência por malha no formato A3" fonte="" />
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n")
                    .replaceAll('\n ', "\n"),
                unidadefk: 3,
                fonteImagem:
                    'https://projetosmecanicos.wordpress.com/2011/09/30/nbr10068/')
            .toMap());
    await database.insert(
        'capitulo',
        CapituloModel(
                id: 19,
                nome: 'Marcas de corte',
                conteudo: r"""
<paragrafo>
As marcas de cortes devem ser feitas nas extremidades das margens em todos
os cantos da folha desenho, à fim de orientar o corte das mesmas de maneira
manual ou automática.
</paragrafo>
<paragrafo>
Estas marcas devem ser construídas em formato de dois retângulos
sobrepostos, medindo 10 mm x 5 mm, conforme apresentado na Figura 3.4.
</paragrafo>
<img src="assets/images/capitulos/figura34.jpg" alt="Figura 3.4 | Marcas de corte" fonte="" />
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n")
                    .replaceAll('\n ', "\n"),
                unidadefk: 3,
                fonteImagem:
                    'Com base na NBR 16752 – Desenho Técnico – Requisitos para apresentação em folhas de desenho')
            .toMap());
    await database.insert(
        'capitulo',
        CapituloModel(
                id: 20,
                nome: 'Legendas',
                conteudo: r"""
<paragrafo>
As legendas exibem as informações necessárias para identificar o desenho.
</paragrafo>
<paragrafo>
A legenda, também chamada de carimbo, selo, rótulo ou etiqueta é composta
por um quadro dividido em campos informando os principais dados sobre o
desenho, como: proprietário legal e/ou empresa, título do desenho, número de
identificação, responsáveis e registro profissional, endereço, escala, data,
número seqüencial da folha, entre outras informações.
</paragrafo>
<paragrafo>
A legenda deve se situar no canto inferior direito do quadro na posição
horizontal, tendo em todos os formatos, 180 mm de comprimento e altura
variável.
</paragrafo>
<img src="assets/images/capitulos/figura35.jpg" alt="Figura 3.5 | Conteúdo e disposição preferencial dos espaços na folha" fonte="" />
<card label="Saiba mais">
Além do espaço para e desenho e legenda, na folha também é destinado
uma espaço para informações complementares, quando necessário.*
Para saber mais, consulte a NBR 16752 - Desenho Técnico - Requisitos
para apresentação em folhas de desenho.
</card>
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n")
                    .replaceAll('\n ', "\n"),
                unidadefk: 3,
                fonteImagem:
                    'http://ftp.demec.ufpr.br/disciplinas/EngMec_NOTURNO/TM328/Apostilas/P2%20-%20Normas.pdf')
            .toMap());
    await database.insert(
        'capitulo',
        CapituloModel(
                id: 21,
                nome: 'Dobramento dos formatos da série A',
                conteudo: r"""
<paragrafo>
Quando o formato do papel é maior que o formato A4, é preciso que se faça o
dobramento da folha para que o tamanho final tenha aproximadamente as
dimensões do formato A4.
</paragrafo>
<paragrafo>
É importante que no formato final dobrado, a legenda fique visível na folha de
frente, dessa forma realiza o dobramento a partir do lado direito.
</paragrafo>
<paragrafo>
Para que não seja perfurada a parte superior esquerdo dos formatos A2, A1,
A0, faz-se uma dobra triangular, para dentro, a partir da marcação.
</paragrafo>
<paragrafo>
Deve-se dobrar o papel primeiramente na largura e depois na altura.
</paragrafo>
<paragrafo>
A seguir é apresentada a orientação do dobramento dos formatos da série A.
</paragrafo>
<img src="assets/images/capitulos/figura36.jpg" alt="Figura 3.6| Dobramento do formato A0" fonte="" />
<img src="assets/images/capitulos/figura37.jpg" alt="Figura 3.7| Dobramento do formato A1" fonte="" />
<img src="assets/images/capitulos/figura38.jpg" alt="Figura 3.8| Dobramento do formato A2" fonte="" />
<img src="assets/images/capitulos/figura39.jpg" alt="Figura 3.9| Dobramento do formato A3" fonte="" />
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n")
                    .replaceAll('\n ', "\n"),
                unidadefk: 3,
                fonteImagem:
                    'https://projetosmecanicos.wordpress.com/2011/10/04/nbr-13142-desenho-tecnico-%E2%80%93dobramento-de-copia/')
            .toMap());
    await database.insert(
        'capitulo',
        CapituloModel(
                id: 22,
                nome: 'Escalas',
                conteudo: r"""
<paragrafo>
A escala é a relação entre as medidas reais do objeto e do desenho. Nem
sempre será possível representar um objeto com suas dimensões reais, por ser
tratar de objetos ou detalhes com dimensões muito pequenas, necessitando de
sua representação ampliada, ou ao contrário, objetos maiores que precisam ser
representados com suas dimensões reduzidas.
</paragrafo>
<card label="Assimilando melhor">
O prédio de Taipei 101 em Taiwan é muito maior do que a Figura 3.8
representa, certo? Neste caso, precisou reduzir as dimensões da imagem
para sua representação.
</card>
<img src="assets/images/capitulos/figura310.jpg" alt="Figura 3.10| Prédio Taipei 101 em Taiwan" fonte="https://casavogue.globo.com/Arquitetura/Edificios/noticia/2019/10/conheca-os-10-predios-mais-altos-do-mundo.html" />
<paragrafo>
Assim, quando se tratar de um objeto grande, é preciso desenhá-lo em
tamanho reduzido, mantendo sua proporção, com igual redução em todas as
medidas. E se, ao contrário, o objeto for pequeno, é necessário desenhá-lo em
tamanho ampliado, mantendo suas proporções, com igual ampliação em todas
as dimensões.
</paragrafo>
<paragrafo>
As escalas podem ser indicadas de duas formas diferentes: através da
representação numérica - Escala Numérica, ou da representação gráfica -
Escala Gráfica. Para este estudo abrangeremos apenas a escala numérica.
</paragrafo>
<paragrafo>
Escala numérica: é estabelecida através de uma relação matemática
representada por uma fração onde o numerador (D) representa as dimensões
do desenho e o denominador (R) representa as dimensões reais do objeto.
</paragrafo>
<paragrafo>
Desta forma,
</paragrafo>
<formula>
E = D/R
</formula>
<paragrafo>
As escalas numéricas podem ser:
</paragrafo>
<paragrafo>
1) Escala Natural: o objeto é desenhado em tamanho real (original).
</paragrafo>
<formula>
E = D/R = 1/1
</formula>
<paragrafo>
Ex: Desenho de uma caneta.
</paragrafo>
<paragrafo>*
2) Escala de Ampliação: o objeto é desenhado em tamanho maior que o
real (original). Muito utilizada para desenhar peças mecânicas, objeto de
pequenas dimensões e detalhes.
</paragrafo>
<formula>
E = D/R = X/1
</formula>
<paragrafo>
Ex: Engrenagens de relógio.*
E = 10/1, significa que o objeto está desenhado 10 vezes maior que o
real (original).
</paragrafo>
<paragrafo>*
3) Escala de Redução: o objeto é desenhado em tamanho menor que o
real (original).
</paragrafo>
<formula>
E = D/R = 1/X
</formula>
<paragrafo>
Ex: Desenho de uma cadeira.*
E = 1/100, significa que o objeto está desenhado 100 vezes menor que o
real (original).
</paragrafo>
<card label="Se liga">
As escalas numéricas também podem aparecer representadas da seguinte
forma: E = 1:100.**
E a palavra ESCALA pode ser abreviada para na forma ESC.
</card>
<card label="Saiba mais">
Segundo a NBR 16752 que trata sobre os requisitos para apresentação em
folhas de desenho técnico, são consideradas escalas de redução ou
ampliação, os valores 2, 5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000 e
os seus múltiplos à razão 10.
</card>
<card label="Esclarecendo melhor">
Suponha que você tenha que representar um poste cuja altura é de 5 metros,
numa folha de papel através de uma linha de 5 cm. Qual é a escala utilizada?
**
E = 5cm/5m       E = 5cm/500cm    E = 1/100   ou seja, Escala 1:100
**
Nesse caso, temos que 1 unidade do desenho (linha gráfica) equivale a 100
unidades reais (linha natural).
***
Agora imagine, que você tenha que desenhar a caixa de um relógio de pulso
que possui um diâmetro de 2 cm. Nesse caso, para melhor representar os
detalhes, você precisará desenhar a caixa na folha de papel com 12 cm. Qual
escala utilizada?
**
E = 12cm/2cm       E = 6/1   ou seja, Escala 6:1
**
Nesse caso, temos que 6 unidade do desenho (linha gráfica) equivale a 1 unidade real (linha natural).
***
Agora você precisará representar uma borracha retangular simples, cujo
tamanho é 4,2 x 2,9 x 1,0 cm. Como a borracha não contém detalhes que
necessitam serem melhores visualizados, você poderá desenhá-la com suas
dimensões reais. Nesse caso, qual escala a ser utilizada?
**
E = 4,2cm/4,2cm       E = 1/1   ou seja, Escala 1:1*
E = 2,9cm/2,9cm       E = 1/1   ou seja, Escala 1:1*
E = 1,0cm/1,0cm       E = 1/1   ou seja, Escala 1:1*
*
Nesse caso, temos que 1 unidade do desenho (linha gráfica) equivale a 1
unidade real (linha natural).
</card>
<card label="Se liga">
O resultado final é adimensional (sem unidade), mas é fundamental que no
cálculo as dimensões estejam na mesma unidade, seja em metros, ou
centímetros ou milímetros, etc.
</card>
<card label="Se liga">
Não se esqueça que o escalímetro é o instrumento utilizado para desenhar
objetos, evitando a realização de cálculos de proporção e facilitar a leitura.*
Treine bastante com o escalímetro.
</card>
<card label="Para refletir">
Como foi apresentado, o estudo de escalas tem grande importância no
Desenho Técnico, pois possibilita representar no papel objetos e peças de
qualquer tamanho. Por isso, todo desenhista/projetista precisa ter esse
conhecimento muito bem definido, além das recomendações propostas nas
normas.
</card>
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n")
                    .replaceAll('\n ', "\n"),
                unidadefk: 3,
                fonteImagem:
                    'https://wiki.ifsc.edu.br/mediawiki/images/archive/a/aa/20080801141948!Aula_01_ARU_DEB_2008.pdf')
            .toMap());
    await database.insert(
        'capitulo',
        CapituloModel(
                id: 23,
                nome: 'Introdução',
                conteudo: r"""
<paragrafo>
Caro usuário,
**Nesta seção, você estudará a importância da caligrafia técnica e as
convenções da escrita técnica de acordo com as recomendações da NBR
8402. Também estudará os tipos de linhas empregadas no desenho técnico em
conformidade com a NBR 8403 e a inserção de cotas, isto é, o emprego das
medidas dos desenhos, segundo as orientações da NBR 10126. A caligrafia
usada no desenho necessita de ser legível, uniforme e apropriada para facilitar
sua compreensão, e para isso há a necessidade que as normatizações de
espaçamento, altura, forma e inclinação, sejam obedecidas. O mesmo
acontece com o emprego das linhas, que precisa estar de acordo com as
convenções, que dizem respeito ao tipo de traçado e largura padronizada. A
inscrição das cotas nos desenhos, também é orientada por regras e
convenções de acordo com os critérios de cotagem sobre os seus elementos:
linha auxiliar, linha de cota, cota e limite de cota.
</paragrafo>
<paragrafo>
O objetivo desta seção é que você aplique a padronização de escrita, linhas e
cotas empregadas em desenho técnico.
</paragrafo>
<h2>Convite ao estudo</h2>
<h3>Qual a finalidade das convenções em desenho?</h3>
<paragrafo>
Os desenhos técnicos possuem escrita padronizada, assim a caligrafia técnica
é um importante recurso para que haja clareza nos desenhos técnicos. Quanto
ao emprego da padronização dos tipos de linhas aplicadas em desenho
técnico, tem por intuito, evitar convenções próprias que dificultam a
interpretação universal do desenho. Os desenhos para construção ou
fabricação devem possuir as informações relacionadas à suas dimensões para
sua execução, assim, a cotagem é essencial para orientar as dimensões reais
do produto. O conteúdo apresentado nesta seção tanto é válido para os
desenhos elaborados à mão livre quanto os que utilizam CAD. Porém no CAD,
os estilos de textos e linhas já são padronizados pelo programa.
</paragrafo>
<paragrafo>
A seguir, são apresentadas as normas utilizadas para este estudo.
</paragrafo>
<h3>Normas:</h3>
<paragrafo>
• NBR 8402 - Execução de caracter para escrita em desenho técnico - objetiva
fixar as condições exigíveis para a escrita usada em desenhos técnicos e
documentos semelhantes.
</paragrafo>
<paragrafo>
• NBR 8403 - Aplicação de linhas em desenhos - Tipos de linhas: largura das
linhas - objetiva apresentar a padronização dos tipos de linhas e largura
empregada em desenho técnico.
</paragrafo>
<paragrafo>
• NBR 10126 - Emprego de cotas em desenho técnico.
</paragrafo>
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n")
                    .replaceAll('\n ', "\n"),
                unidadefk: 4,
                fonteImagem:
                    'https://www.vivadecora.com.br/pro/desenho-tecnico/')
            .toMap());
    await database.insert(
        'capitulo',
        CapituloModel(
                id: 24,
                nome: 'Caligrafia Técnica',
                conteudo: r"""
<paragrafo>
Assim como a escrita em geral requer uniformidade e legibilidade para sua
interpretação, em desenho técnico não é diferente. Qualquer informação escrita
no desenho, sejam letras, números ou caracteres, deve estar de acordo com as
recomendações da NBR 8402.
</paragrafo>
<card label="Para refletir">
Já pensou seu projeto ser recusado por uma empresa internacional por
eles não entenderem sua letra? Por esse motivo tem a caligrafia técnica,
favorecendo a interpretação universal do desenho.
</card>
<paragrafo>
Conforme a norma deve ser utilizada letras, algarismos e caracteres de traçado
simples, desenhados no sentido vertical ou inclinados a 15° com relação à linha
vertical ou 75º com a linha horizontal, conforme mostra a Figura 4.1.
<paragrafo>
<img src="assets/images/capitulos/figura41.jpg" alt="Figura 4.1 | Forma de escrita vertical e inclinada" fonte="" />
<paragrafo>
Algumas recomendações devem ser obedecidas:
</paragrafo>
<paragrafo>
- A altura da letra é baseada na altura das letras maiúsculas, representada pelo
“h” e que serve como referência para as demais letras e caracteres.
</paragrafo>
<paragrafo>
- A altura mínima para as letras maiúsculas (h) e minúsculas (c) não devem ser
menores que 2,5 mm. Caso haja letras e maiúsculas simultâneas, não podem
ser menores que 3,5 mm.
</paragrafo>
<paragrafo>
- As alturas das letras maiúsculas “h” (mm) recomendadas são: 2,5; 3,5; 5; 7;
10; 14 e 20.
</paragrafo>
<paragrafo>
- Para ajudar na execução da caligrafia técnica, devemos traçar linhas
auxiliares, após escolher uma altura padrão. Veja na Figura 4.2 uma
demonstração dessas linhas.
</paragrafo>
<img src="assets/images/capitulos/figura42.jpg" alt="Figura 4.2 | Execução de linhas auxiliares para escrita" fonte="https://docplayer.com.br/15031190-Normatizacao-desenho-tecnico-prof-solivan-altoe.html" />
<card label="Para refletir">
Afinal, qual altura das letras e algarismos, escolher?**
A altura das letras e algarismos é escolhida conforme a importância do
texto que será escrito. Assim tamanhos maiores (7 ou 10 mm) são
recomendados para títulos, e para observações e notas, recomenda-se
tamanhos menores (geralmente 3 mm).
</card>
<card label="Para saber mais">
A habilidade no traçado das letras só é conseguida através da prática
contínua. Exercite a execução do alfabeto e algarismos, e caso surjam
dúvidas, consulte a norma, NBR 8402.
</card>
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n")
                    .replaceAll('\n ', "\n"),
                unidadefk: 4,
                fonteImagem:
                    'https://docente.ifsc.edu.br/anderson.correia/MaterialDidatico/Eletromecanica/Modulo_1/Desenho_Tecnico/Cap%C3%ADtulo%201%20-%20Caligrafia%20T%C3%A9cnica.pdf')
            .toMap());
    await database.insert(
        'capitulo',
        CapituloModel(
                id: 25,
                nome: 'Tipos de Linhas',
                conteudo: r"""
<paragrafo>
Os tipos e espessuras de linhas utilizadas no Desenho Técnico dependem dos
seus usos e do que se deseja representar. Quando utilizado de forma incorreta
um tipo de linha ou espessura, pode levar a interpretação errada do desenho
representado. As linhas utilizadas na elaboração do desenho técnico devem
seguir a classificação da Tabela 4.1:
</paragrafo>
<img src="assets/images/capitulos/tabela41.jpg" alt="Tabela 4.1| Classificação das linhas" fonte="https://docplayer.com.br/15031190-Normatizacao-desenho-tecnico-prof-solivan-altoe.html" />
<card label="Esclarecendo melhor">
No desenho técnico, cada linha que você executa demonstra sua finalidade
no desenho, logo existe diferença no emprego de linhas. Por exemplo, as
arestas visíveis são representadas por linhas continuas e as arestas
invisíveis por linhas tracejadas.
</card>
<card label="Para saber mais">
Consulte a NBR 8403 que trata sobre os tipos de linhas utilizados em
desenho técnico para você saber mais sobre o assunto. E lembrem-se, os
projetistas e desenhistas devem ter domínio com os tipos de linhas para
sua correta aplicação.
</card>
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n")
                    .replaceAll('\n ', "\n"),
                unidadefk: 4,
                fonteImagem:
                    'https://www.qconcursos.com/questoes-de-concursos/questoes/bc9bb873-f4')
            .toMap());
    await database.insert(
        'capitulo',
        CapituloModel(
                id: 26,
                nome: 'Cotagem',
                conteudo: r"""
<paragrafo>
As cotas são os números que indicam as dimensões do que está sendo
representado pelo desenho. Independente da escala utilizada no desenho, as
cotas correspondem à verdadeira grandeza das dimensões.
</paragrafo>
<card label="Para refletir">
Um erro de cotagem no desenho traz grandes prejuízos para produto que
será construído ou fabricado, por isso é sempre bom ter muita atenção e
cuidado ao cotar um desenho.
</card>
<h3>Elementos de cotagem</h3>
<paragrafo>
Para correta leitura e interpretação da cotagem de um desenho é necessário
conhecer alguns de seus elementos, que são:
</paragrafo>
<img src="assets/images/capitulos/figura43.jpg" alt="Figura 4.3 | Elementos de cotagem" fonte="https://docplayer.com.br/15031190-Normatizacao-desenho-tecnico-prof-solivan-altoe.html" />
<paragrafo>
- Cota: valor numérico que corresponde à dimensão real do objeto. Deve ser
posicionado sobre a linha de cota.
</paragrafo>
<paragrafo>
- Limite da linha de cota: marcam o início e o fim da dimensão a ser cotada.
Deve ser feito por meio de seta ou traço oblíquo.
</paragrafo>
<paragrafo>
- Linhas de cota: traços contínuos paralelos ao desenho que contêm as cotas.
Deve ser utilizada linha estreita contínua.
</paragrafo>
<paragrafo>
- Linhas de chamada: traços contínuos perpendiculares às linhas de cotas.
Deve ser utilizada linha estreita contínua.
</paragrafo>
<h3>Regras básicas para cotagem</h3>
<paragrafo>
- A linha de chamada ou auxiliar deverá ultrapassar a linha de cota em ± 3 mm
e não deve tocar o desenho. Deixar uma distância de ± 2 mm;
</paragrafo>
<paragrafo>
- Quando a linha de cota estiver na horizontal, a cota deve ser posicionada
acima da mesma. Na vertical, a cota deve ser posicionada à sua esquerda;
</paragrafo>
<paragrafo>
- As cotas totais devem ser inseridas por fora das parciais, de forma a se evitar
que elas se cruzem;
</paragrafo>
<paragrafo>
- Deve-se evitar, sempre que possível, inserir cotas internas ao desenho;
</paragrafo>
<paragrafo>
- Não deve haver cruzamento das linhas de cotas;
</paragrafo>
<paragrafo>
- Deve-se evitar a duplicação das cotas.
</paragrafo>
<paragrafo>
- As cotas devem ser distribuídas em todas as vistas;
</paragrafo>
<paragrafo>
- A caligrafia a utilizada na cotagem deve seguir as normas técnicas;
</paragrafo>
<paragrafo>
- Cada detalhe deve ser cotado uma única vez, na vista que melhor representar
a sua forma;
</paragrafo>
<paragrafo>
- As cotas devem ser representadas na mesma unidade.
</paragrafo>
<card label="Para saber mais">
Para mais esclarecimento sobre os critérios de cotagem em desenhos
técnicos, consulte a NBR 10126 que trata sobre o emprego de cotas. E
fiquem atentos ao cotar um desenho, para evitar erros e interpretações
incorretas.
</card>
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n")
                    .replaceAll('\n ', "\n"),
                unidadefk: 4,
                fonteImagem:
                    'https://professornovais.com/cotas-em-desenho-tecnico/')
            .toMap());
    await database.insert(
        'capitulo',
        CapituloModel(
                id: 27,
                nome: 'Introdução',
                conteudo: r"""
<paragrafo>
Caro usuário,
**Nesta seção, você compreenderá sobre projeção ortogonal ou vistas
ortogonais, que corresponde à representação do desenho em duas dimensões
(2D). Também trataremos sobre os tipos de cortes, que consiste na
representação da peça seccionada (cortada) com o objetivo de mostrar os seus
detalhes.
</paragrafo>
<paragrafo>
O objetivo desta seção é que você interprete e represente as vistas ortogonais
e os cortes de um objeto, desenvolvendo a sua visão espacial.
</paragrafo>
<h2>Convite ao estudo</h2>
<h3>Qual a importância das vistas ortogonais para desenho técnico?</h3>
<paragrafo>
As vistas ortogonais é um tema de grande relevância para a disciplina de
desenho técnico. Consiste na representação gráfica do objeto espacial (objeto
em 3D) em um plano (2D), em que são indicadas as suas principais dimensões
que são, largura, altura e profundidade. Mas em cada vista principal de um
desenho, só é possível representar somente duas dessas dimensões, por se
tratar de um plano bidimensional. Assim, necessitamos de três vistas principais
para especificar a peça ou produto para sua fabricação (construção).
</paragrafo>
<paragrafo>
A seguir, são apresentadas as normas utilizadas para este estudo.
</paragrafo>
<h3>Normas:</h3>
<paragrafo>
• NBR 10067 - Princípios gerais de representação em Desenho técnico -
apresenta a padronização da representação aplicada em desenho técnico.
</paragrafo>
<paragrafo>
• NBR 12298 - Representação da área de corte por meio de hachuras em
desenho técnico - regulamenta a apresentação da área de corte em desenho.
</paragrafo>
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n")
                    .replaceAll('\n ', "\n"),
                unidadefk: 5,
                fonteImagem:
                    'http://eventoscopq.mackenzie.br/index.php/jornada/xvijornada/paper/download/2159/1295')
            .toMap());
    await database.insert(
        'capitulo',
        CapituloModel(
                id: 28,
                nome: 'Projeções Ortográficas',
                conteudo: r"""
<paragrafo>
Somente podemos desenhar aquilo que se vê ou se imagina e estes dependem
muito do ponto onde nos posicionamos (referencial). Se nos posicionamos de
frente ao carro, ao tentarmos representar o que vemos, teremos uma visão do
carro. Já se nos posicionamos ao lado do carro, sua representação será muito
diferente.
</paragrafo>
<paragrafo>
Para tal, existem as projeções ortográficas. São ortográficas, porque os planos
onde representaremos as peças são ortogonais entre si (formam ângulos
retos). Os desenhos ortográficos disponibilizam vistas separadas da face da
peça, que são agrupadas de maneira padrão para oferecer como uma
linguagem universal.
</paragrafo>
<paragrafo>
As projeções ortográficas são feitas em planos perpendiculares entre si. Dessa
forma, em cada plano desenhamos uma vista do objeto, com sua face paralela
ao plano em questão. Logo, teremos as faces projetadas no plano em
verdadeira dimensão.
</paragrafo>
<card label="Esclarecendo melhor">
É como imaginar um objeto envolvido por um cubo. O objeto é projetado em
cada uma das seis faces do cubo e, em seguida, o cubo é aberto obtendo-se
as seis vistas planificadas, como mostra as figuras a seguir:
</card>
<img src="assets/images/capitulos/figura51.jpg" alt="Figura 5.1 | Objeto envolvido pelo cubo" fonte="https://slideplayer.com.br/slide/378681/" />
<img src="assets/images/capitulos/figura52.jpg" alt="Figura 5.2 | Vistas planificadas do objeto" fonte="https://slideplayer.com.br/slide/378681/" />
<card label="Para refletir">
Assim é possível visualizar todas as vistas de uma determinada peça em uma
folha de papel, ou seja, o original que é tridimensional passa a ser
bidimensional.
</card>
<paragrafo>
São utilizados dois planos de projeção, vertical e horizontal, para que os
objetos fiquem mais bem definidos e cada espaço formado entre dois planos,
tem-se os diedros, conforme a Figura 5.3:
</paragrafo>
<img src="assets/images/capitulos/figura53.jpg" alt="Figura 5.3 | Vistas planificadas do objeto" fonte="https://slideplayer.com.br/slide/378681/" />
<paragrafo>
Os planos horizontal e vertical são
divididos em semi-planos:*
</paragrafo>
<paragrafo>
- PHA: Semi-plano horizontal
anterior
</paragrafo>
<paragrafo>
- PHP: Semi-plano horizontal
posterior
</paragrafo>
<paragrafo>
- PVS: Semi-plano vertical
superior
</paragrafo>
<paragrafo>
- PVI: Semi-plano vertical
inferior
</paragrafo>
<paragrafo>
- A intersecção dos planos
horizontal e vertical é chamada de
linha de terra.
</paragrafo>
<paragrafo>*
A projeção ortográfica pode ser feita de duas maneiras:
</paragrafo>
<paragrafo>
- 1° diedro: imagine você vendo o objeto a partir de um dos lados do cubo,
conforme a Figura 5.4. Assim, o desenho será representado do lado oposto ao
do observador.
</paragrafo>
<img src="assets/images/capitulos/figura54.jpg" alt="Figura 5.4 | Objeto no 1º diedro" fonte="https://slideplayer.com.br/slide/378681/" />
<paragrafo>
- 3° diedro: imagine você vendo o objeto de um dos lados do cubo, como
mostrado na Figura 5.5. Agora, o desenho será representado do mesmo lado
do observador.
</paragrafo>
<img src="assets/images/capitulos/figura55.jpg" alt="Figura 5.5 | Objeto no 3º diedro" fonte="https://slideplayer.com.br/slide/378681/" />
<card label="Se liga">
No Brasil a ABNT (NBR 10067) define o uso do 1° diedro para representar os
desenhos, já os americanos têm como padrão, o 3º diedro.
</card>
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n")
                    .replaceAll('\n ', "\n"),
                unidadefk: 5,
                fonteImagem:
                    'https://descritiva.blogspot.com/p/complementos-desenho-tecnico.html')
            .toMap());
    await database.insert(
        'capitulo',
        CapituloModel(
                id: 29,
                nome: 'Vistas principais',
                conteudo: r"""
<paragrafo>
Uma única projeção ortogonal de um objeto não é suficiente para expressar a
largura, altura e profundidade desse objeto. Como mostrado nas Figuras 5.1 e
5.2, um objeto apresenta seis vistas. Para a perfeita representação do objeto
são normalmente utilizadas três vistas ortográficas, que geralmente garantem a
representação do objeto, estas três vistas são denominadas:
</paragrafo>
<paragrafo>
VF - Vista frontal,*
VLE - vista lateral esquerda e*
VS - vista superior.*
</paragrafo>
<img src="assets/images/capitulos/figura56.jpg" alt="Figura 5.6 | Vistas principais" fonte="https://slideplayer.com.br/slide/378681/" />
<paragrafo>
Para tal, é necessário além do plano vertical e horizontal, mais um plano auxiliar (lateral), assim:
</paragrafo>
<paragrafo>
• A projeção do objeto no plano vertical dá origem à vista frontal;*
• A projeção do objeto no plano horizontal dá origem à vista superior;*
• A projeção do objeto no plano lateral dá origem à vista lateral esquerda.
</paragrafo>
<img src="assets/images/capitulos/figura57.jpg" alt="Figura 5.7 | Planos de projeções" fonte="https://slideplayer.com.br/slide/378681/" />
<paragrafo>
Para representação das vistas no papel, precisamos rebater os planos de
projeção, como se fossemos planificá-los.
</paragrafo>
<img src="assets/images/capitulos/figura58.jpg" alt="Figura 5.8 | Rebatimento dos planos de projeções" fonte="https://slideplayer.com.br/slide/378681/" />
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n")
                    .replaceAll('\n ', "\n"),
                unidadefk: 5,
                fonteImagem:
                    'https://descritiva.blogspot.com/p/complementos-desenho-tecnico.html')
            .toMap());
    await database.insert(
        'capitulo',
        CapituloModel(
                id: 30,
                nome: 'Cortes',
                conteudo: r"""
<paragrafo>
Agora que você aprendeu a representar as superfícies de um objeto,
trataremos dos tipos de cortes. O corte é um meio imaginário para representar
o interior de uma peça, facilitando a visualização e interpretação de detalhes,
difíceis de serem mostrados com as vistas ortogonais.
</paragrafo>
<card label="Para refletir">
Nos cortes na construção civil são utilizados para representar o interior de
uma edificação ou peça, para melhor serem detalhados para o responsável
que irá construir, especificando as espessuras da parede, detalhes do
telhado, por exemplo.
</card>
<paragrafo>
Os cortes podem ser dos tipos:
</paragrafo>
<paragrafo>
- Corte total: é aquele que atinge a peça em toda sua extensão, realizado
por um único plano de corte.
</paragrafo>
<img src="assets/images/capitulos/figura59.jpg" alt="Figura 5.9 | Corte Total" fonte="https://slideplayer.com.br/slide/378681/" />
<paragrafo>
- Meio corte: é aquele que mostra determinados detalhes internos da
peça, realizado por dois planos de corte.
</paragrafo>
<img src="assets/images/capitulos/figura510.jpg" alt="Figura 5.10 | Meio Corte" fonte="https://slideplayer.com.br/slide/378681/" />
<paragrafo>
- Corte em desvio: é aquele utilizado para representar detalhes em
diferentes planos de corte.
</paragrafo>
<img src="assets/images/capitulos/figura511.jpg" alt="Figura 5.11 | Corte em desvio" fonte="https://slideplayer.com.br/slide/378681/" />
<card label="Se liga">
Deve-se hachurar toda a área seccionada do corte, seguindo as regras para a
execução da hachura, como: o tipo de material.*
A hachura deve ser feita sempre no mesmo sentido, e seu traçado deve ser
feito preferencialmente a 45° em relação aos eixos de simetria.
</card>
<card label="Para saber mais">
A NBR 12298 - Representação da área de corte por meio de hachuras em
desenho técnico - define o tipo de hachura para cada material. Consulte a
norma para saber mais e resolva as atividades do aplicativo para melhor
compreensão do conteúdo.
</card>

"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n")
                    .replaceAll('\n ', "\n"),
                unidadefk: 5,
                fonteImagem:
                    'https://www.vivadecora.com.br/pro/normas-de-desenho-tecnico/')
            .toMap());
    await database.insert(
        'capitulo',
        CapituloModel(
                id: 31,
                nome: 'Introdução',
                conteudo: r"""
<paragrafo>
Caro usuário,
**Nesta seção, apresentaremos a você a perspectiva de sólidos em desenho
técnico. A perspectiva compreende a representação de objetos tridimensionais,
sendo essencial para as áreas da construção civil. Trataremos das
perspectivas isométricas e cavaleiras. Assim, após concluído os estudos desta
seção, você estará familiarizado com este assunto, que é tão importante para
sua formação.
</paragrafo>
<paragrafo>
O objetivo desta seção é que você interprete e represente os tipos de
perspectivas apresentados, desenvolvendo a sua visão espacial.
</paragrafo>
<h2>Convite ao estudo</h2>
<h3>Qual a importância do estudo das perspectivas para desenho técnico?</h3>
<paragrafo>
O estudo de perspectivas é essencial para representação de objetos
tridimensionais, demonstrando a habilidade espacial do projetista. A partir,
dessa ferramenta você terá condições de desenhar o edifício finalizado,
apresentando a proposta para seu cliente aprovar, por exemplo.
</paragrafo>
<paragrafo>
A seguir, são apresentadas as normas utilizadas para este estudo.
</paragrafo>
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n")
                    .replaceAll('\n ', "\n"),
                unidadefk: 6,
                fonteImagem:
                    'https://www.vivadecora.com.br/pro/desenhos-de-arquitetura/')
            .toMap());
    await database.insert(
        'capitulo',
        CapituloModel(
                id: 32,
                nome: 'Tipos de Perspectivas',
                conteudo: r"""
<paragrafo>
Antes de iniciarmos o assunto é importante que você compreenda o conceito
de perspectiva, que corresponde à representação gráfica das três dimensões
principais de um objeto (largura, altura e comprimento) em um único plano, de
forma a transmitir a idéia de profundidade e relevo, ou seja, e um modo
tridimensional (em 3D) de representação.
</paragrafo>
<paragrafo>
As perspectivas são classificadas em cônicas e axonométricas, conforme
mostra a Figura 6.1. Mas para este estudo apresentaremos em detalhes
apenas a perspectiva isométrica e a perspectiva cavaleira, por serem as mais
empregadas na representação de desenho técnico (MICELI e FERREIRA,
2003).
</paragrafo>
<img src="assets/images/capitulos/figura61.jpg" alt="Figura 6.1 | Tipos de perspectivas" fonte="https://slideplayer.com.br/slide/378681/" />
<h3>Perspectiva isométrica</h3>
<paragrafo>
As perspectivas axonométricas são utilizadas para representar formas
tridimensionais, estando relacionados aos três eixos ortogonais (x, y e z), que
equivalem à largura, comprimento e altura, respectivamente.
</paragrafo>
<paragrafo>
Para sua representação as três faces (vistas) principais são ligadas entre si,
num só desenho, montadas sobre eixos, perpendiculares entre si, que servem
de suportes às três dimensões e são colocadas obliquamente em relação ao
plano de projeção.
</paragrafo>
<paragrafo>
A perspectiva isométrica se caracteriza por manter as mesmas proporções do
comprimento, da largura e da altura do objeto representado. Nela os três eixos
no espaço estão inclinados em relação ao plano do espaço, de forma que os
ângulos formados pelos eixos projetados são equivalentes a 120º, conforme a
Figura 6.2:
</paragrafo>
<img src="assets/images/capitulos/figura62.jpg" alt="Figura 6.2 | Eixo isométrico" fonte="http://www2.ucg.br/design/da2/perspectiva.pdf" />
<paragrafo>
Para obtenção da perspectiva isométrica é traçada uma linha auxiliar horizontal
na folha de papel, coincidindo com o vértice inferior da peça, como indicado na
Figura 6.2 (b). Dois ângulos originam-se e equivalem ambos a 30º.
</paragrafo>
<paragrafo>
Para te auxiliar no traçado das linhas, utilize o esquadro de 30º e 60º.
</paragrafo>
<img src="assets/images/capitulos/figura63.jpg" alt="Figura 6.3 | Utilização do compasso" fonte="http://www2.ucg.br/design/da2/perspectiva.pdf" />
<paragrafo>
Cada eixo corresponde a uma dimensão do objeto:
</paragrafo>
<img src="assets/images/capitulos/figura64.jpg" alt="Figura 6.4 | Dimensões dos objetos sobre os eixos" fonte="http://www2.ucg.br/design/da2/perspectiva.pdf" />
<paragrafo>
A construção da perspectiva isométrica de um objeto é realizada a partir de um
sólido envolvente, cujas dimensões (altura, comprimento e largura) são
medidas e marcadas sobre os três eixos. Sobre este sólido, são marcados os
detalhes do objeto, traçando-se retas paralelas aos três eixos. A seguir as
Figuras 6.5 apresentam o processo de construção:
</paragrafo>
<paragrafo>
1º passo) Traçar os eixos isométricos com o uso
dos instrumentos, como na Figura 6.5.1.
</paragrafo>
<img src="assets/images/capitulos/figura651.jpg" alt="Figura 6.5.1 | Construção da perspectiva isométrica a partir de um sólido envolvente - 1º passo" fonte="http://www2.ucg.br/design/da2/perspectiva.pdf" />
<paragrafo>
2º passo) Marcar sobre os eixos isométricos as
dimensões do objeto (largura, altura e
comprimento), como na Figura 6.5.2.
</paragrafo>
<img src="assets/images/capitulos/figura652.jpg" alt="Figura 6.5.2 | Construção da perspectiva isométrica a partir de um sólido envolvente - 2º passo" fonte="http://www2.ucg.br/design/da2/perspectiva.pdf" />
<paragrafo>
3º passo) Traçar retas paralelas ao eixo com
auxilio do esquadro fechando o volume do
objeto, formando o sólido envolvente, como na Figura 6.5.3
</paragrafo>
<img src="assets/images/capitulos/figura653.jpg" alt="Figura 6.5.3 | Construção da perspectiva isométrica a partir de um sólido envolvente - 3º passo" fonte="http://www2.ucg.br/design/da2/perspectiva.pdf" />
<paragrafo>
4º passo) Fazer as demais marcações sobre os
eixos isométricos das dimensões parciais do
objeto, como na Figura 6.5.4.
</paragrafo>
<img src="assets/images/capitulos/figura654.jpg" alt="Figura 6.5.4 | Construção da perspectiva isométrica a partir de um sólido envolvente - 4º passo" fonte="http://www2.ucg.br/design/da2/perspectiva.pdf" />
<paragrafo>
5º passo) Com auxílio das restas paralelas aos
eixos deve completar o volume do objeto, como na Figura 6.5.5.
</paragrafo>
<img src="assets/images/capitulos/figura655.jpg" alt="Figura 6.5.5 | Construção da perspectiva isométrica a partir de um sólido envolvente - 5º passo" fonte="http://www2.ucg.br/design/da2/perspectiva.pdf" />
<paragrafo>
6º passo) Reforçar os traços que formam as
arestas do objeto, como na Figura 6.5.6.
</paragrafo>
<img src="assets/images/capitulos/figura656.jpg" alt="Figura 6.5.6 | Construção da perspectiva isométrica a partir de um sólido envolvente - 6º passo" fonte="http://www2.ucg.br/design/da2/perspectiva.pdf" />
<paragrafo>
Objeto utilizado no exemplo na Figura 6.5.1.
</paragrafo>
<img src="assets/images/capitulos/figura657.jpg" alt="Figura 6.5.7 | Construção da perspectiva isométrica a partir de um sólido envolvente - Objeto utilizado no exemplo." fonte="http://www2.ucg.br/design/da2/perspectiva.pdf" />
<paragrafo>
*Qualquer reta paralela a um
eixo isométrico é chamada
linha isométrica (Figura 6.6).
</paragrafo>
<img src="assets/images/capitulos/figura66.jpg" alt="Figura 6.6 | Linhas isométricas" fonte="http://www2.ucg.br/design/da2/perspectiva.pdf" />
<paragrafo>
*As linhas não paralelas aos
eixos isométricos são linhas
não isométricas (Figura 6.7).
</paragrafo>
<img src="assets/images/capitulos/figura67.jpg" alt="Figura 6.7 | Linhas não isométricas" fonte="http://www2.ucg.br/design/da2/perspectiva.pdf" />
<card label="Para saber mais">
Quanto mais você pesquisar e aprofundar sobre o assunto, maior será seu
entendimento. Por isso, acesse o vídeo que trata sobre o desenho da
perspectiva isométrica de um prisma quando estiver conectado.*
Link: https://www.youtube.com/watch?v=71sEI9X_hp0.
</card>
<h3>**Perspectiva cavaleira</h3>
<paragrafo>
Na perspectiva cavaleira, as três faces do objeto também são montadas sobre
três eixos que partem de um vértice comum. Ela se caracteriza por ter a face
do objeto paralela à face do papel, ou seja, uma das faces da peça é
desenhada como se estivesse exatamente na frente do observador em
verdadeira grandeza.
</paragrafo>
<paragrafo>
As linhas que representam profundidade podem estar inclinadas à 30º, 45º ou
60º e sofrem redução de suas dimensões.
</paragrafo>
<paragrafo>
As medidas no eixo da largura são reduzidas de acordo com o coeficiente de
alteração ou redução (k) para propiciar uma forma de representação agradável
do objeto. Esse coeficiente de redução varia conforme o ângulo de inclinação,
conforme ilustra a Figura 6.8.
</paragrafo>
<img src="assets/images/capitulos/figura68.jpg" alt="Figura 6.8 | Coeficiente de redução (k)" fonte="" />
<card label="Para refletir">
A principal vantagem da utilização da perspectiva cavaleira consiste na
representação de objetos cuja face frontal contém detalhes circulares ou
irregulares que aparecerão em verdadeira grandeza.
</card>
<paragrafo>
Para traçar um objeto utilizando a perspectiva cavaleira, primeiro você deve
definir qual ângulo será utilizado (30º; 45º e 60º). Qualquer que seja o ângulo
escolhido, o procedimento é o descrito a seguir, variando apenas a proporção
da redução nas faces laterais do objeto em função da angulação escolhida.
</paragrafo>
<paragrafo>
1- No plano formado pelos eixos yz, traçar a forma frontal que define o objeto a
ser desenhado, no nosso exemplo um quadrado.
</paragrafo>
<paragrafo>
2- Definir o ângulo das projetantes (no nosso exemplo utilizamos 45º) e traçar o
eixo x. (OBS: O ângulo do eixo x pode estar com a inclinação tanto para a
esquerda como para a direita, dependendo de qual face você quer destacar).
</paragrafo>
<paragrafo>
3- Traçar em cada vértice do quadrado uma linha paralela ao eixo x, com a
medida igual a 1/2 do lado do quadrado (nesse caso utilizamos o ângulo de
45º, caso o ângulo seja outro, esse valor deverá ser alterado).
</paragrafo>
<paragrafo>
4- Traçar o quadrado da face posterior do cubo.
</paragrafo>
<img src="assets/images/capitulos/figura69.jpg" alt="Figura 6.9 | Construção da perspectiva cavaleira" fonte="" />
<card label="Para saber mais">
Em caso de dúvidas e para aprofundar sobre o assunto, assista ao vídeo que
está no link abaixo, quando estiver conectado com a internet.
Link: https://www.youtube.com/watch?v=7fdZX-Hc5y0
</card>
<paragrafo>
Quando o desenho está em perspectiva, é possível passá-lo para projeção
ortogonal, assim como o contrário, o desenho em projeção ortogonal pode ser
passado para a perspectiva.
</paragrafo>
<paragrafo>
Para isso, além do aprimoramento técnico, o projetista deve saber fazer a
leitura e interpretação do desenho em projeção ortogonal, pois as três vistas
ortográficas é que vão auxiliar a compreensão para execução do desenho em
perspectiva. Abaixo segue um exemplo:
</paragrafo>
<img src="assets/images/capitulos/figura610.jpg" alt="Figura 6.10| Desenho projetivo" fonte="http://tecnologiascsc.blogspot.com/2017/11/perspectiva-isometrica-partir-de-vistas.html" />
<card label="Para refletir">
Finalizamos a seção de conteúdo do aplicativo. Para que você assimile mais
ainda o conteúdo apresentado é importante que você acesse a seção de
atividades do aplicativo.
Lembre-se que o autoestudo é importante na sua formação.
</card>
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n")
                    .replaceAll('\n ', "\n"),
                unidadefk: 6,
                fonteImagem:
                    'http://www.essentialvermeer.com/technique/perspective/history.html')
            .toMap());
  }

  Future<void> _createDefaultAtividades(Database database) async {
    await database.insert(
        'atividade',
        AtividadeModel(
                id: 1,
                nome: 'Atividade 1',
                enunciado: r"""
<paragrafo>
Seu supervisor chefe solicitou que você fizesse a revisão do projeto
arquitetônico do banheiro abaixo, antes que fosse encaminhado para o setor de
projeto estrutural. Durante sua revisão, surgiu uma indagação quanto ao tipo de
desenho da representação, conforme seus conhecimentos, responda:
</paragrafo>
<img src="assets/images/atividades/figura1.jpg" alt="Figura 1 | Projeto de um banheiro" fonte="https://br.pinterest.com/pin/785385622491685156" />
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n"),
                respostaCerta: '2',
                respostaAluno: '',
                tipo: 'multipla-escolha',
                unidadefk: 1)
            .toMap());
    await database.insert(
        'atividade',
        AtividadeModel(
                id: 2,
                nome: 'Atividade 2',
                enunciado: r"""
<paragrafo>
Durante a execução de uma edificação, foi percebido que uma das
tubulações do projeto hidrossanitário cruzaria com uma viga, sendo necessária
a execução de um furo na viga, fato este que não estava previsto no projeto
estrutural. O supervisor responsável pela obra fez o seguinte questionamento a
você: mesmo com o aperfeiçoamento dos desenhos técnicos por que
problemas como estes acontecem? Esta questão é para você refletir, depois de
feito clique na opção 'resposta' que fizemos algumas considerações.
</paragrafo>
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n"),
                respostaCerta: r"""
<paragrafo>
É fato que os desenhos evoluíram e o desenvolvimento da
informática beneficiou sua execução. Porém, se um projeto for mal
compatibilizado ou não haver compatibilização ocasionará problemas como
estes na sua execução. Dentre as principais conseqüências da falta
compatibilização estão:
</paragrafo>
<paragrafo>
- Custos adicionais não previstos na construção
</paragrafo>
<paragrafo>
- Atraso no cronograma de entrega do empreendimento
</paragrafo>
<paragrafo>
- Redução da qualidade do empreendimento (improvisos em obra)
</paragrafo>
<paragrafo>
Na situação descrita, para passagem da tubulação na viga demanda um custo
adicional que engloba mão-de-obra, materiais e ferramentas específicas para
executar a abertura, além de causar um atraso no cronograma da obra.
<paragrafo>
</paragrafo>
Seria necessário fazer uma consultoria com os projetistas responsáveis pelo
projeto hidrossanitário e estrutural para verificar uma solução para a situação,
seja ela a necessidade de realizar um esforço estrutural nas proximidades da
abertura na viga ou uma mudança no posicionamento da tubulação, o que
consumiria um tempo significativo.
</paragrafo>
<paragrafo>
Em alguns casos, os responsáveis pela execução do empreendimento definem
soluções sem realizar a consulta aos projetistas responsáveis, o que ocasiona
improvisos na obra e, consequentemente, perda da qualidade e até mesmo da
segurança da edificação.
</paragrafo>
<paragrafo>
Você acha o caso descrito improvável? Então veja o exemplo abaixo:
</paragrafo>
<img src="assets/images/atividades/figura2.jpg" alt="Figura 2 | Incompatibilidade entre projetos hidráulico e
estrutural" fonte="" />
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n"),
                respostaAluno: '',
                tipo: 'reflexao',
                unidadefk: 1)
            .toMap());

    await database.insert(
        'atividade',
        AtividadeModel(
                id: 3,
                nome: 'Atividade 3',
                enunciado: r"""
<paragrafo>
Os computadores da Edifica sofreram uma pane e perderam as
configurações normas técnicas da ABNT aplicadas ao Desenho Técnico, que
estavam salvas nos programas. Seu supervisor pediu que você realizasse um
levantamento sobre as normas técnicas existentes na área de desenho técnico.
Sendo assim, é correto afirmar que:
</paragrafo>
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n"),
                respostaCerta: '8',
                respostaAluno: '',
                tipo: 'multipla-escolha',
                unidadefk: 1)
            .toMap());
    await database.insert(
        'atividade',
        AtividadeModel(
                id: 4,
                nome: 'Atividade 4',
                enunciado: r"""
<paragrafo>
É fundamental que um bom profissional projetista saiba os principais
fundamentos de Desenho Técnico no processo de desenvolvimento de projetos
à fim de evitar erros pertinentes. Assim sendo, julgue os itens a seguir:
</paragrafo>
<paragrafo>
I - O desenho técnico promove a comunicação entre a equipe de criação e a
de construção.
</paragrafo>
<paragrafo>
II - As normas técnicas são regras que devem ser aplicadas durante todo o
processo de desenvolvimento de um projeto.
</paragrafo>
<paragrafo>
III - O desenho técnico, ao contrário do artístico, deve transmitir com exatidão
todas as características do objeto representado.
</paragrafo>
<paragrafo>
É CORRETO o que se afirma em:
</paragrafo>
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n"),
                respostaCerta: '15',
                respostaAluno: '',
                tipo: 'multipla-escolha',
                unidadefk: 1)
            .toMap());

    await database.insert(
        'atividade',
        AtividadeModel(
                id: 5,
                nome: 'Atividade 5',
                enunciado: r"""
<paragrafo>
Está cada vez mais comum as pessoas interessarem em adaptar o local de
moradia ao próprio perfil e estilo de vida. Isso pode ser feito facilmente através
de projetos de ambientes planejados. A proposta possibilita melhorar o aspecto
da residência, otimizar o espaço e ao mesmo tempo, imprimir personalidade
aos cômodos. A combinação desses benefícios impacta positivamente na
rotina dos moradores, propiciando conforto e bem-estar.
</paragrafo>
<paragrafo>
Você foi solicitado pelo seu supervisor para apresentar a proposta de um
escritório planejado a um cliente. Mas surgiu uma dúvida, a imagem representa
um desenho técnico ou um desenho artístico?
</paragrafo>
<img src="assets/images/atividades/figura2.jpg" alt="Figura 2 | Incompatibilidade entre projetos hidráulico e
estrutural" fonte="" />
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n"),
                respostaCerta: '16',
                respostaAluno: '',
                tipo: 'multipla-escolha',
                unidadefk: 1)
            .toMap());


await database.insert(
        'atividade',
        AtividadeModel(
                id: 6,
                nome: 'Instrução para prosseguir',
                enunciado: r"""
<paragrafo>
Instruções para o exercício 6:
</paragrafo>
<paragrafo>
Uma boa comunicação é instrumento essencial para qualquer profissional,
independente da área que atua. Seu supervisor-chefe irá fazer uma reunião na
sala de reuniões da empresa com o seu grupo e pediu que você gravasse para
cada questão a seguir, um vídeo curto para ser apresentado durante a reunião.
</paragrafo>
<paragrafo>
Os vídeos serão uma boa oportunidade para você desenvolver a comunicação
e refletir sobre os assuntos abordados.
</paragrafo>
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n"),
                respostaCerta: ''
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n"),
                respostaAluno: '',
                tipo: 'instrucao',
                unidadefk: 1)
            .toMap());



            await database.insert(
        'atividade',
        AtividadeModel(
                id: 7,
                nome: 'Atividade 6',
                enunciado: r"""
<paragrafo>
Os projetistas enfrentam inúmeros desafios, dentre eles as alterações
solicitadas pelo cliente ao longo desenvolvimento do projeto. Após ler o
exemplo abaixo, reflita e grave um vídeo retratando sobre as vantagens e
desvantagens das alterações feitas no projeto.
</paragrafo>
<paragrafo>
A construtora Edifica foi contratada para elaboração do projeto de um
empreendimento, as especificações foram passadas pelo cliente. Porém, em
menos de um mês, houve por três vezes, alterações solicitadas pelo cliente no
projeto.
</paragrafo>
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n"),
                respostaCerta: r"""
<paragrafo>
Os projetistas devem ter ciência de que o projeto pode ser alterado
há qualquer momento, para tanto, deve-se garantir a flexibilidade de
modificações durante o processo de elaboração para melhoria do produto
(empreendimento) que será desenvolvido. É importante salientar, que essas
alterações influenciam no contrato. Dentre as vantagens que essas alterações
promovem, está o grau de exigência do cliente que ocasiona maior
conhecimento e segurança da aplicabilidade das especificações e
normatizações relacionadas ao desenho técnico, além da satisfação do cliente.
E como desvantagem, se tem modificações no prazo e planejamento, aumento
de custo, entre outros.
</paragrafo>
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n"),
                respostaAluno: '',
                tipo: 'reflexao',
                unidadefk: 1)
            .toMap());
  }

  Future<void> _createDefaultOpcoesAtividade(Database database) async {
    await database.insert(
        'opcoesatividade',
        OpcaoAtividadeModel(
                id: 1,
                enunciado: r"""
a) A representação é considerada um desenho é técnico, pois estimula a
imaginação e a criatividade do observador.
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n"),
                atividadefk: 1)
            .toMap());
    await database.insert(
        'opcoesatividade',
        OpcaoAtividadeModel(
                id: 2,
                enunciado: r"""
b) A representação é considerada um desenho técnico, pois descreve com
exatidão a edificação para sua construção.
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n"),
                atividadefk: 1)
            .toMap());
    await database.insert(
        'opcoesatividade',
        OpcaoAtividadeModel(
                id: 3,
                enunciado: r"""
c) A representação é considerada um desenho artístico, pois sugere várias
interpretações expressando estilo pessoal do artista.
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n"),
                atividadefk: 1)
            .toMap());
    await database.insert(
        'opcoesatividade',
        OpcaoAtividadeModel(
                id: 4,
                enunciado: r"""
d) A representação é considerada um desenho artístico, pois não é possível
reproduzi-lo.
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n"),
                atividadefk: 1)
            .toMap());
    await database.insert(
        'opcoesatividade',
        OpcaoAtividadeModel(
                id: 5,
                enunciado: r"""
e) A representação é considerada um desenho artístico e técnico ao mesmo
tempo.
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n"),
                atividadefk: 1)
            .toMap());

    await database.insert(
        'opcoesatividade',
        OpcaoAtividadeModel(
                id: 6,
                enunciado: r"""
a) A norma que trata dobre o dobramento de folhas objetiva reduzir o formato
ao A0.
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n"),
                atividadefk: 3)
            .toMap());
    await database.insert(
        'opcoesatividade',
        OpcaoAtividadeModel(
                id: 7,
                enunciado: r"""
b) A norma que se refere à folha de desenho, layout e dimensões, padroniza as
dimensões das folhas da Série A, porém é utilizada a mesma margem para
todos os formatos.
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n"),
                atividadefk: 3)
            .toMap());
    await database.insert(
        'opcoesatividade',
        OpcaoAtividadeModel(
                id: 8,
                enunciado: r"""
c) A norma de caligrafia técnica sempre deve ser consultada para elaboração
de legendas e cotagem dos desenhos.
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n"),
                atividadefk: 3)
            .toMap());
    await database.insert(
        'opcoesatividade',
        OpcaoAtividadeModel(
                id: 9,
                enunciado: r"""
d) A norma geral de desenho técnico objetiva definir as escalas empregadas
em desenho técnico.
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n"),
                atividadefk: 3)
            .toMap());





        await database.insert(
        'opcoesatividade',
        OpcaoAtividadeModel(
                id: 11,
                enunciado: r"""
a) I, apenas.
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n"),
                atividadefk: 4)
            .toMap());

            await database.insert(
        'opcoesatividade',
        OpcaoAtividadeModel(
                id: 12,
                enunciado: r"""
b) I e II, apenas.
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n"),
                atividadefk: 4)
            .toMap());


            await database.insert(
        'opcoesatividade',
        OpcaoAtividadeModel(
                id: 13,
                enunciado: r"""
c) I e III, apenas.
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n"),
                atividadefk: 4)
            .toMap());


            await database.insert(
        'opcoesatividade',
        OpcaoAtividadeModel(
                id: 14,
                enunciado: r"""
d) II e III, apenas.
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n"),
                atividadefk: 4)
            .toMap());


            await database.insert(
        'opcoesatividade',
        OpcaoAtividadeModel(
                id: 15,
                enunciado: r"""
e) I, II e III.
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n"),
                atividadefk: 4)
            .toMap());



                    await database.insert(
        'opcoesatividade',
        OpcaoAtividadeModel( 
                id: 16,
                enunciado: r"""
a) O desenho é artístico, pois permite múltiplas interpretações.
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n"),
                atividadefk: 5)
            .toMap());

            await database.insert(
        'opcoesatividade',
        OpcaoAtividadeModel(
                id: 17,
                enunciado: r"""
b) O desenho é técnico, pois retrata o ambiente de forma precisa para sua
construção.
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n"),
                atividadefk: 5)
            .toMap());


            await database.insert(
        'opcoesatividade',
        OpcaoAtividadeModel(
                id: 18,
                enunciado: r"""
c) O desenho é técnico, pois exprime o lado pessoal do desenhista.
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n"),
                atividadefk: 5)
            .toMap());


            await database.insert(
        'opcoesatividade',
        OpcaoAtividadeModel(
                id: 19,
                enunciado: r"""
d) O desenho é técnico pelas medidas dadas ao ambiente.
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n"),
                atividadefk: 5)
            .toMap());


            await database.insert(
        'opcoesatividade',
        OpcaoAtividadeModel(
                id: 20,
                enunciado: r"""
e) O desenho é artístico e técnico ao mesmo tempo.
"""
                    .replaceAll(RegExp(r'\n'), ' ')
                    .replaceAll('> ', ">")
                    .replaceAll('*', "\n"),
                atividadefk: 5)
            .toMap());

            
  }

  Future<List<UnidadeModel>> fetchUnidades() async {
    //returns the memos as a list (array)

    final db = await init();
    final maps = await db
        .query("unidade"); //query all the rows in a table as an array of maps

    return List.generate(maps.length, (i) {
      //create a list of memos
      return UnidadeModel(
        id: maps[i]['id'],
        nome: maps[i]['nome'],
      );
    });
  }

  Future<int> countUnidades() async {
    final db = await init();
    var results = await db.rawQuery('SELECT * FROM unidade;');
    return results.length;
  }

  Future<List<CapituloModel>> fetchCapitulosByUnidadeId(id) async {
    //returns the memos as a list (array)

    final db = await init();
    final maps = await db.rawQuery(
        'SELECT id, nome FROM capitulo WHERE unidadefk = ' +
            id.toString() +
            ';'); //query all the rows in a table as an array of maps

    return List.generate(maps.length, (i) {
      //create a list of memos
      return CapituloModel(
        id: maps[i]['id'],
        nome: maps[i]['nome'],
      );
    });
  }

  Future<List<CapituloModel>> getCapituloById(id) async {
    //returns the memos as a list (array)

    final db = await init();
    final maps = await db.rawQuery(
        'SELECT capitulo.id, capitulo.nome, capitulo.conteudo, capitulo.fonteImagem, unidade.nome as unidadeNome'
                ' FROM capitulo'
                ' LEFT OUTER JOIN unidade'
                ' ON capitulo.unidadefk = unidade.id'
                ' WHERE capitulo.id = ' +
            id.toString() +
            ' limit 1;'); //query all the rows in a table as an array of maps
    return List.generate(maps.length, (i) {
      //create a list of memos
      return CapituloModel(
          id: maps[i]['id'],
          nome: maps[i]['nome'],
          conteudo: maps[i]['conteudo'],
          unidadefk: maps[i]['unidadefk'],
          fonteImagem: maps[i]['fonteImagem'],
          unidadeNome: maps[i]['unidadeNome']);
    });
  }

  Future<int> countCapitulosByUnidadeId(id) async {
    final db = await init();
    var results = await db
        .rawQuery('SELECT * FROM capitulo WHERE unidadefk = ' + id + ';');
    return results.length;
  }

  Future<List<AtividadeModel>> fetchAtividadesByUnidadeId(id) async {
    //returns the memos as a list (array)

    final db = await init();
    final maps = await db.rawQuery(
        'SELECT * FROM atividade WHERE unidadefk = ' +
            id.toString() +
            ';'); //query all the rows in a table as an array of maps

    return List.generate(maps.length, (i) {
      //create a list of memos
      return AtividadeModel(
        id: maps[i]['id'],
        nome: maps[i]['nome'],
        enunciado: maps[i]['enunciado'],
        unidadefk: maps[i]['unidadefk'],
        unidadeNome: maps[i]['unidadeNome'],
        respostaAluno: maps[i]['respostaAluno'],
        respostaCerta: maps[i]['respostaCerta'],
        tipo: maps[i]['tipo'],
      );
    });
  }

  Future<List<AtividadeModel>> getAtividadeById(id) async {
    //returns the memos as a list (array)

    final db = await init();
    final maps =
        await db.rawQuery('SELECT atividade.*, unidade.nome as unidadeNome'
                ' FROM atividade'
                ' LEFT OUTER JOIN unidade'
                ' ON atividade.unidadefk = unidade.id'
                ' WHERE atividade.id = ' +
            id.toString() +
            ' limit 1;'); //query all the rows in a table as an array of maps
    return List.generate(maps.length, (i) {
      //create a list of memos
      return AtividadeModel(
        id: maps[i]['id'],
        nome: maps[i]['nome'],
        enunciado: maps[i]['enunciado'],
        unidadefk: maps[i]['unidadefk'],
        unidadeNome: maps[i]['unidadeNome'],
        respostaAluno: maps[i]['respostaAluno'],
        respostaCerta: maps[i]['respostaCerta'],
        tipo: maps[i]['tipo'],
      );
    });
  }

  Future<List<OpcaoAtividadeModel>> getOpcoesByAtividadeId(id) async {
    final db = await init();
    var maps = await db.rawQuery(
        'SELECT * FROM opcoesatividade WHERE atividadefk = ' +
            id.toString() +
            ';');
    return List.generate(maps.length, (i) {
      //create a list of memos
      return OpcaoAtividadeModel(
        id: maps[i]['id'],
        enunciado: maps[i]['enunciado'],
      );
    });
  }

  Future<void> registraResposta(atividade, resposta) async {
    final db = await init();
    await db.rawQuery('UPDATE atividade'
            ' SET respostaAluno = ' +
        resposta.toString() +
        ' WHERE id = ' +
        atividade.toString() +
        ';');
  }
}
