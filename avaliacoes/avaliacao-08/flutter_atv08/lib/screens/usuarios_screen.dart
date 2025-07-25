import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/usuario.dart';

class UsuariosScreen extends StatefulWidget {
  @override
  _UsuariosScreenState createState() => _UsuariosScreenState();
}

class _UsuariosScreenState extends State<UsuariosScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Usuario>> _futureUsuarios;

  @override
  void initState() {
    super.initState();
    _futureUsuarios = _apiService.fetchUsuarios();
  }

  Future<void> _recarregarUsuarios() async {
    setState(() {
      _futureUsuarios = _apiService.fetchUsuarios();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Usuários'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _recarregarUsuarios,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _recarregarUsuarios,
        child: FutureBuilder<List<Usuario>>(
          future: _futureUsuarios,
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
                      onPressed: _recarregarUsuarios,
                      child: Text('Tentar novamente'),
                    ),
                  ],
                ),
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Nenhum usuário encontrado'));
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final usuario = snapshot.data![index];
                return _buildItemUsuario(usuario);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildItemUsuario(Usuario usuario) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: usuario.imagemUrl != null
              ? NetworkImage(usuario.imagemUrl!)
              : AssetImage('assets/default_user.png') as ImageProvider,
        ),
        title: Text(
          usuario.nome,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(usuario.email),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        contentPadding: EdgeInsets.all(12),
        onTap: () {
          // Navegar para tela de detalhes
        },
      ),
    );
  }
}