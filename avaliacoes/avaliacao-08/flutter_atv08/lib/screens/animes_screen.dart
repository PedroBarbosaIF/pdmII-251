import 'package:flutter/material.dart';
import '../services/anime_service.dart';
import '../models/anime.dart';

class AnimesScreen extends StatefulWidget {
  @override
  _AnimesScreenState createState() => _AnimesScreenState();
}

class _AnimesScreenState extends State<AnimesScreen> {
  final AnimeService _animeService = AnimeService();
  late Future<List<Anime>> _futureAnimes;

  @override
  void initState() {
    super.initState();
    _futureAnimes = _animeService.fetchAnimes();
  }

  Future<void> _recarregarAnimes() async {
    setState(() {
      _futureAnimes = _animeService.fetchAnimes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Animes'),
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: _recarregarAnimes),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _recarregarAnimes,
        child: FutureBuilder<List<Anime>>(
          future: _futureAnimes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, size: 50, color: Colors.red),
                    SizedBox(height: 20),
                    Text(
                      'Erro ao carregar dados',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _recarregarAnimes,
                      child: Text('Tentar novamente'),
                    ),
                  ],
                ),
              );
            }
            final animes = snapshot.data ?? [];
            if (animes.isEmpty) {
              return Center(child: Text('Nenhum anime encontrado.'));
            }
            return ListView.builder(
              itemCount: animes.length,
              itemBuilder: (context, index) {
                final anime = animes[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: ListTile(
                    leading: anime.imagemUrl.isNotEmpty
                        ? Image.network(
                            anime.imagemUrl,
                            width: 50,
                            height: 70,
                            fit: BoxFit.cover,
                          )
                        : Container(width: 50, height: 70, color: Colors.grey),
                    title: Text(anime.titulo),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (anime.nota != null)
                          Text('Nota: ${anime.nota!.toStringAsFixed(2)}'),
                        if (anime.sinopse != null && anime.sinopse!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              anime.sinopse!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
