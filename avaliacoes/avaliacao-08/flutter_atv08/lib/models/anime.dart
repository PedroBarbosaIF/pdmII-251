class Anime {
  final String titulo;
  final String imagemUrl;
  final double? nota;
  final String? sinopse;

  Anime({
    required this.titulo,
    required this.imagemUrl,
    this.nota,
    this.sinopse,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      titulo: json['title'] ?? 'Sem título',
      imagemUrl: json['images']?['jpg']?['image_url'] ?? '',
      nota: (json['score'] != null) ? (json['score'] as num).toDouble() : null,
      sinopse: json['synopsis'],
    );
  }
}
