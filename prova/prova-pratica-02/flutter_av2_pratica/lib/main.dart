import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CadastroProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Colors.deepPurple;
    final Color accentColor = Colors.amber;
    return MaterialApp(
      title: 'Cadastro App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        scaffoldBackgroundColor: Colors.deepPurple[50],
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 4,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: accentColor, width: 2),
          ),
          labelStyle: TextStyle(color: primaryColor),
        ),
      ),
      home: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          return auth.isLoggedIn ? const MenuScreen() : const LoginScreen();
        },
      ),
    );
  }
}

// Provider para autenticação simples
class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  void login(String user, String pass) {
    if (user == 'pedro' && pass == '1234') {
      _isLoggedIn = true;
      notifyListeners();
    }
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}

// Provider para gerenciar os cadastros
class CadastroProvider extends ChangeNotifier {
  final List<Cliente> clientes = [];
  final List<Produto> produtos = [];
  final List<Fornecedor> fornecedores = [];
  final List<Pedido> pedidos = [];

  void addCliente(Cliente c) {
    clientes.add(c);
    notifyListeners();
  }

  void addProduto(Produto p) {
    produtos.add(p);
    notifyListeners();
  }

  void addFornecedor(Fornecedor f) {
    fornecedores.add(f);
    notifyListeners();
  }

  void addPedido(Pedido p) {
    pedidos.add(p);
    notifyListeners();
  }
}

// Modelos simples
class Cliente {
  final String nome;
  final String email;
  final String telefone;
  Cliente(this.nome, this.email, this.telefone);
}

class Produto {
  final String nome;
  final double preco;
  final String descricao;
  Produto(this.nome, this.preco, this.descricao);
}

class Fornecedor {
  final String nome;
  final String contato;
  final String cnpj;
  Fornecedor(this.nome, this.contato, this.cnpj);
}

class Pedido {
  final String descricao;
  final String data;
  final double valorTotal;
  Pedido(this.descricao, this.data, this.valorTotal);
}

// Tela de Login
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();
  String? _error;
  bool _showPassword = false;

  void _login() {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    auth.login(_userController.text, _passController.text);
    if (!auth.isLoggedIn) {
      setState(() => _error = 'Usuário ou senha inválidos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.lock, size: 60, color: Colors.deepPurple),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _userController,
                      decoration: const InputDecoration(labelText: 'Usuário'),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _passController,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _showPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                        ),
                      ),
                      obscureText: !_showPassword,
                    ),
                    if (_error != null) ...[
                      const SizedBox(height: 8),
                      Text(_error!, style: const TextStyle(color: Colors.red)),
                    ],
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _login,
                        child: const Text('Entrar'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Tela Menu Principal
class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Principal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              auth.logout();
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/icon.png', height: 100),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CadastroScreen(tipo: 'cliente'),
                  ),
                ),
                child: const Text('Cadastro de Clientes'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CadastroScreen(tipo: 'produto'),
                  ),
                ),
                child: const Text('Cadastro de Produtos'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CadastroScreen(tipo: 'fornecedor'),
                  ),
                ),
                child: const Text('Cadastro de Fornecedores'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CadastroScreen(tipo: 'pedido'),
                  ),
                ),
                child: const Text('Cadastro de Pedidos'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Tela de Cadastro genérica
class CadastroScreen extends StatefulWidget {
  final String tipo;
  const CadastroScreen({super.key, required this.tipo});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _campo1 = TextEditingController();
  final _campo2 = TextEditingController();
  final _campo3 = TextEditingController();

  @override
  void dispose() {
    _campo1.dispose();
    _campo2.dispose();
    _campo3.dispose();
    super.dispose();
  }

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      final cadastro = Provider.of<CadastroProvider>(context, listen: false);
      switch (widget.tipo) {
        case 'cliente':
          cadastro.addCliente(
            Cliente(_campo1.text, _campo2.text, _campo3.text),
          );
          break;
        case 'produto':
          cadastro.addProduto(
            Produto(
              _campo1.text,
              double.tryParse(_campo2.text) ?? 0,
              _campo3.text,
            ),
          );
          break;
        case 'fornecedor':
          cadastro.addFornecedor(
            Fornecedor(_campo1.text, _campo2.text, _campo3.text),
          );
          break;
        case 'pedido':
          cadastro.addPedido(
            Pedido(
              _campo1.text,
              _campo2.text,
              double.tryParse(_campo3.text) ?? 0,
            ),
          );
          break;
      }
      _campo1.clear();
      _campo2.clear();
      _campo3.clear();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final cadastro = Provider.of<CadastroProvider>(context);
    List<Widget> pageViews = [];
    switch (widget.tipo) {
      case 'cliente':
        pageViews = cadastro.clientes
            .map(
              (c) => Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: ListTile(
                  leading: const Icon(Icons.person, color: Colors.deepPurple),
                  title: Text(
                    c.nome,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Email: ${c.email}\nTelefone: ${c.telefone}'),
                ),
              ),
            )
            .toList();
        break;
      case 'produto':
        pageViews = cadastro.produtos
            .map(
              (p) => Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.shopping_bag,
                    color: Colors.deepPurple,
                  ),
                  title: Text(
                    p.nome,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Preço: R\$ ${p.preco.toStringAsFixed(2)}\nDescrição: ${p.descricao}',
                  ),
                ),
              ),
            )
            .toList();
        break;
      case 'fornecedor':
        pageViews = cadastro.fornecedores
            .map(
              (f) => Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.local_shipping,
                    color: Colors.deepPurple,
                  ),
                  title: Text(
                    f.nome,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Contato: ${f.contato}\nCNPJ: ${f.cnpj}'),
                ),
              ),
            )
            .toList();
        break;
      case 'pedido':
        pageViews = cadastro.pedidos
            .map(
              (p) => Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.receipt_long,
                    color: Colors.deepPurple,
                  ),
                  title: Text(
                    p.descricao,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Data: ${p.data}\nValor Total: R\$ ${p.valorTotal.toStringAsFixed(2)}',
                  ),
                ),
              ),
            )
            .toList();
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadastro de ${widget.tipo[0].toUpperCase()}${widget.tipo.substring(1)}s',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _campo1,
                      decoration: InputDecoration(
                        labelText: () {
                          switch (widget.tipo) {
                            case 'produto':
                              return 'Nome do Produto';
                            case 'pedido':
                              return 'Descrição do Pedido';
                            default:
                              return 'Nome';
                          }
                        }(),
                      ),
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Campo obrigatório' : null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _campo2,
                      decoration: InputDecoration(
                        labelText: () {
                          switch (widget.tipo) {
                            case 'cliente':
                              return 'Email';
                            case 'produto':
                              return 'Preço';
                            case 'fornecedor':
                              return 'Contato';
                            case 'pedido':
                              return 'Data';
                            default:
                              return '';
                          }
                        }(),
                      ),
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Campo obrigatório' : null,
                      keyboardType: widget.tipo == 'produto'
                          ? TextInputType.number
                          : TextInputType.text,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _campo3,
                      decoration: InputDecoration(
                        labelText: () {
                          switch (widget.tipo) {
                            case 'cliente':
                              return 'Telefone';
                            case 'produto':
                              return 'Descrição';
                            case 'fornecedor':
                              return 'CNPJ';
                            case 'pedido':
                              return 'Valor Total';
                            default:
                              return '';
                          }
                        }(),
                      ),
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Campo obrigatório' : null,
                      keyboardType:
                          (widget.tipo == 'produto' ||
                                  widget.tipo == 'pedido') &&
                              (widget.tipo != 'fornecedor')
                          ? TextInputType.number
                          : TextInputType.text,
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _salvar,
                    child: const Text('Salvar'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: pageViews.isNotEmpty
                  ? PageView(children: pageViews)
                  : const Center(child: Text('Nenhum registro.')),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
