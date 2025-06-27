import 'dart:convert';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class Disciplina {
  late int _id;
  late String _descricao;
  late int _qtdAulas;

  // Construtor
  Disciplina({
    required int id,
    required String descricao,
    required int qtdAulas,
  })  : _id = id,
        _descricao = descricao,
        _qtdAulas = qtdAulas;

  Map toJson() => {
    'id' : _id,
    'descricao' : _descricao,
    'qtdAulas' : _qtdAulas
  };
}

class Aluno{
  late int _id;
  late String _nome;
  late String _matricula;

  Aluno({
    required int id,
    required String nome,
    required String matricula,
  }) : _id = id,
        _nome = nome,
        _matricula = matricula;

  Map toJson() => {
    'id' : _id,
    'nome' : _nome,
    'matricula' : _matricula
  };
}

class Professor {
  late int _id;
  late String _codigo;
  late String _nome;

  Professor({
    required int id,
    required String codigo,
    required String nome
  }) : _id = id,
        _codigo = codigo,
        _nome = nome;

  Map toJson() => {
    'id' : _id,
    'codigo' : _codigo,
    'nome' : _nome
  };
}


class Curso {
  late int _id;
  late String _descricao;
  late List<Professor> _professores;
  late List<Disciplina> _disciplinas;
  late List<Aluno> _alunos;

  Curso({
    required int id,
    required String descricao,
    List<Professor>? professores,
    List<Disciplina>? disciplinas,
    List<Aluno>? alunos,
  })  : _id = id,
        _descricao = descricao,
        _professores = professores ?? [],
        _disciplinas = disciplinas ?? [],
        _alunos = alunos ?? [];

  void adicionarProfessor({required Professor professor}){
    _professores.add(professor);
    print(professor);
  }

  void adicionarDisciplina({required Disciplina disciplina}){

  }

  Map toJson () => {
    'id' : _id,
    'descricao' : _descricao,
    'professores' : _professores,
    'disciplinas' : _disciplinas,
    'alunos' : _alunos
  };

}




main() async {
  // Criando um objeto da classe Disciplina
  Disciplina d1 = Disciplina(
    id: 101,
    descricao: 'Matemática',
    qtdAulas: 60,
  );

  Disciplina d2 = Disciplina(
    id: 102,
    descricao: 'Português',
    qtdAulas: 60,
  );

  Aluno a1 = Aluno(id: 1, nome: 'João Silva', matricula: '2023001');
  Aluno a2 = Aluno(id: 2, nome: 'Maria Oliveira', matricula: '2023002');

  Professor p1 = Professor(id: 1, codigo: 'P001', nome: 'Dr. João Silva');
  Professor p2 = Professor(id: 2, codigo: 'P002', nome: 'Profa. Maria Oliveira');
  Professor p3 = Professor(id: 3, codigo: 'P003', nome: 'Dr. Carlos Pereira');

  Curso curso = Curso(
    id: 1,
    descricao: 'Curso de Programação',
    professores: [p1, p2],
    disciplinas: [d1, d2],
    alunos: [a1, a2],
  );

  String cursoJson = jsonEncode(curso);
  print(cursoJson);

  final smtpServer = gmail('pedro.barbosa40@aluno.ifce.edu.br', 'lael ltqw wfuc xjpb');

  // Cria uma mensagem de e-mail
  final message = Message()
    ..from = Address('pedro.barbosa40@aluno.ifce.edu.br', 'Pedro')
    ..recipients.add('pedro.barbosa.phab@gmail.com')
    ..subject = 'Boa tarde'
    ..text = cursoJson;

  try {
    // Envia o e-mail usando o servidor SMTP do Gmail
    final sendReport = await send(message, smtpServer);

    // Exibe o resultado do envio do e-mail
    print('E-mail enviado: $sendReport');
  } on MailerException catch (e) {
    // Exibe informações sobre erros de envio de e-mail
    print('Erro ao enviar e-mail: ${e.toString()}');
  }
}