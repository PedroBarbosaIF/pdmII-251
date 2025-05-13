// Agregação e Composição
import 'dart:convert';

class Dependente {
  late String _nome;

  Dependente(String nome) {
    this._nome = nome;
  }

  Map toJson() => {
    'nome': _nome
  };
}

class Funcionario {
  late String _nome;
  late List<Dependente> _dependentes;

  Funcionario(String nome, List<Dependente> dependentes) {
    this._nome = nome;
    this._dependentes = dependentes;
  }

  Map toJson() => {
    'nome': _nome,
    'dependentes': _dependentes
  };
}

class EquipeProjeto {
  late String _nomeProjeto;
  late List<Funcionario> _funcionarios;

  EquipeProjeto(String nomeprojeto, List<Funcionario> funcionarios) {
    _nomeProjeto = nomeprojeto;
    _funcionarios = funcionarios;
  }

  Map toJson() => {
    'nome': _nomeProjeto,
    'funcionarios': _funcionarios
  };
}

void main() {
  // 1. Criar varios objetos Dependentes
  Dependente carlos = Dependente("Dependente 1 Carlos");
  Dependente chico = Dependente("Dependente 2 Chico");
  Dependente marcos = Dependente("Dependente 3 Marcos");
  Dependente lazaro = Dependente("Dependente 4 Lázaro");
  Dependente homero = Dependente("Dependente 5 Homero");
  Dependente iago = Dependente("Dependente 6 Iago");

  // 2. Criar varios objetos Funcionario
  // 3. Associar os Dependentes criados aos respectivos
  //    funcionarios
  Funcionario luiz = Funcionario("Funcionário 1 Luiz", [carlos, chico]);
  Funcionario gustavo = Funcionario("Funcionário 2 Gustavo", [marcos, lazaro]);
  Funcionario pedro = Funcionario("Funcionário 3 Pedro", [homero, iago]);

  // 4. Criar uma lista de Funcionarios
  List<Funcionario> funcionarios = [luiz, gustavo, pedro]; 

  // 5. criar um objeto Equipe Projeto chamando o metodo
  //    contrutor que da nome ao projeto e insere uma
  //    coleção de funcionario
  EquipeProjeto poggersTeam = EquipeProjeto("Equipe PoggersTeam", funcionarios);

  // 6. Printar no formato JSON o objeto Equipe Projeto.
  String poggersTeamJson = jsonEncode(poggersTeam);
  print('oi');
  print(poggersTeamJson);

}
