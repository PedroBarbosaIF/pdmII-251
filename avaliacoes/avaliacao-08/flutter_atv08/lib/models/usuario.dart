class Usuario {
  final String nome;
  final String email;
  final String imagemUrl;

  Usuario({required this.nome, required this.email, required this.imagemUrl});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    final name = json['name'];
    return Usuario(
      nome: name != null ? "${name['first']} ${name['last']}" : 'Sem nome',
      email: json['email'] ?? '',
      imagemUrl: json['picture'] != null ? json['picture']['large'] : '',
    );
  }
}
