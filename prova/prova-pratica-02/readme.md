

# 📱 Sistema de Cadastro Flutter - Avaliação Prática 02

### Aluno: Pedro Henrique Alves Barbosa

### Turma: P5 de Informática

## 📋 Descrição do Projeto

[Visualizar PDF da Prova '/pdm2-provaPratica.pdf'](pdm2-provaPratica.pdf) 
[Acessar Screenshots /'prints_imagens/'](prints_imagens/)

**OBS**: imagens também estão mais abaixo neste arquivo 

Este projeto Flutter é uma aplicação de gerenciamento de cadastros desenvolvida como parte da avaliação prática de PDM II. O sistema permite o gerenciamento completo de **Clientes**, **Produtos**, **Fornecedores** e **Pedidos** através de uma interface moderna e intuitiva.

## 📝 Observações Importantes

- A aplicação utiliza armazenamento em memória (dados não persistem após fechar o app)
- Sistema de login simples para fins acadêmicos
- Interface otimizada para diferentes tamanhos de tela
- Código totalmente em português para melhor compreensão

## 🚀 Como Executar

### Pré-requisitos

- Flutter SDK 3.8.1 ou superior
- Dart SDK
- IDE (VS Code, Android Studio, etc.)

### Passos para Execução

1. **Clone o repositório:**

```bash
git clone [URL_DO_REPOSITORIO]
cd flutter_av2_pratica
```

2. **Instale as dependências:**

```bash
flutter pub get
```

3. **Execute a aplicação:**

```bash
flutter run
```

## 🚀 Funcionalidades Principais

### 🔐 Sistema de Autenticação

- Login seguro com validação de credenciais
- Interface com campo de senha com opção de visualização
- Controle de estado de autenticação usando Provider

**Credenciais de Acesso:**

- **Usuário:** `pedro`
- **Senha:** `1234`

### 🏠 Menu Principal

Interface centralizada com acesso direto a todos os módulos de cadastro:

- Cadastro de Clientes
- Cadastro de Produtos
- Cadastro de Fornecedores
- Cadastro de Pedidos

### 📊 Módulos de Cadastro

#### 👥 Clientes

- **Campos:** Nome, Email, Telefone
- Visualização em cards organizados
- Ícone personalizado para identificação

#### 🛍️ Produtos

- **Campos:** Nome do Produto, Preço, Descrição
- Formatação monetária automática
- Validação de campos numéricos

#### 🚚 Fornecedores

- **Campos:** Nome, Contato, CNPJ
- Interface especializada para dados empresariais
- Ícone de caminhão para identificação visual

#### 📋 Pedidos

- **Campos:** Descrição do Pedido, Data, Valor Total
- Controle de valores monetários
- Histórico completo de pedidos

## 📸 Screenshots da Aplicação

### Tela de Login

![Tela de Login](prints_imagens/IMG-20250728-WA0003.jpg)
_Interface de autenticação com campos de usuário e senha, incluindo opção de visualizar senha_

### Menu Principal

![Menu Principal](prints_imagens/IMG-20250728-WA0004.jpg)
_Tela inicial com botões de acesso aos módulos de cadastro e logo da aplicação_

### Cadastro de Clientes

![Cadastro de Clientes - Formulário](prints_imagens/IMG-20250728-WA0005.jpg)
_Formulário para cadastro de novos clientes com campos Nome, Email e Telefone_

![Cadastro de Clientes - Lista](prints_imagens/IMG-20250728-WA0006.jpg)
_Visualização dos clientes cadastrados em formato de cards com navegação por swipe_

### Cadastro de Produtos

![Cadastro de Produtos - Formulário](prints_imagens/IMG-20250728-WA0007.jpg)
_Interface para cadastro de produtos com campos Nome, Preço e Descrição_

![Cadastro de Produtos - Lista](prints_imagens/IMG-20250728-WA0008.jpg)
_Lista de produtos cadastrados com informações de preço formatado_

### Cadastro de Fornecedores

![Cadastro de Fornecedores - Formulário](prints_imagens/IMG-20250728-WA0009.jpg)
_Formulário especializado para fornecedores com campos Nome, Contato e CNPJ_

![Cadastro de Fornecedores - Lista](prints_imagens/IMG-20250728-WA0010.jpg)
_Visualização dos fornecedores com ícone de caminhão e dados empresariais_

### Cadastro de Pedidos

![Cadastro de Pedidos - Formulário](prints_imagens/IMG-20250728-WA0011.jpg)
_Interface para registro de pedidos com Descrição, Data e Valor Total_

![Cadastro de Pedidos - Lista](prints_imagens/IMG-20250728-WA0012.jpg)
_Lista de pedidos cadastrados com valores monetários formatados_

![Demonstração de Navegação](prints_imagens/IMG-20250728-WA0013.jpg)
_Demonstração da navegação fluida entre diferentes módulos da aplicação_

## 🏗️ Estrutura do Projeto

```
flutter_av2_pratica/
├── lib/
│   └── main.dart              # Arquivo principal com toda a lógica
├── images/
│   └── icon.png              # Ícone da aplicação
├── android/                  # Configurações Android
├── ios/                      # Configurações iOS
├── windows/                  # Configurações Windows
├── pubspec.yaml             # Dependências e configurações
└── README.md               # Documentação
```

## 📱 Funcionalidades Técnicas

### Gerenciamento de Estado

- **AuthProvider:** Controla o estado de autenticação
- **CadastroProvider:** Gerencia todas as listas de cadastros
- **ChangeNotifier:** Notifica a UI sobre mudanças de estado

### Modelos de Dados

```dart
// Classes modelo para estruturação dos dados
- Cliente: nome, email, telefone
- Produto: nome, preço, descrição
- Fornecedor: nome, contato, cnpj
- Pedido: descrição, data, valorTotal
```

### Navegação

- **Navigator.push()** para navegação entre telas
- **AppBar** personalizada com botões de retorno
- **Logout** direto do menu principal

### Validação

- Campos obrigatórios em todos os formulários
- Validação de tipos numéricos para preços
- Feedback visual para erros de login

## 🛠️ Tecnologias Utilizadas

### Framework e Linguagem

- **Flutter 3.8.1+** - Framework de desenvolvimento multiplataforma
- **Dart** - Linguagem de programação

### Dependências Principais

- **Provider 6.1.5** - Gerenciamento de estado reativo
- **Flutter Launcher Icons 0.14.4** - Personalização de ícones
- **Cupertino Icons 1.0.8** - Ícones iOS

### Arquitetura

- **Provider Pattern** - Para gerenciamento de estado
- **MVC (Model-View-Controller)** - Organização do código
- **Responsive Design** - Interface adaptável

## 🎨 Design e Interface

### Tema Visual

- **Cor Primária:** Deep Purple (`Colors.deepPurple`)
- **Cor de Destaque:** Amber (`Colors.amber`)
- **Background:** Purple 50 para suavidade visual

### Componentes UI

- **Cards elevados** com bordas arredondadas
- **Botões estilizados** com feedback visual
- **Campos de entrada** com foco destacado
- **Ícones temáticos** para cada módulo

### Dispositivos Suportados

- 📱 **Android** (API 21+)
- 🍎 **iOS** (11.0+)
- 💻 **Windows** (Windows 10+)
- 🐧 **Linux**
- 🌐 **Web**

## 🎯 Objetivos Acadêmicos Alcançados

## 👨‍💻 Desenvolvedor

**Pedro** - Desenvolvimento "completo" da aplicação Flutter

---

## 🔄 Possíveis Melhorias Futuras

- 💾 Implementação de banco de dados local (SQLite)
- 🌐 Integração com APIs REST
- 📊 Relatórios e dashboards
- 🔔 Sistema de notificações
- 📤 Exportação de dados
- 🎨 Modo escuro/claro

---

_Projeto desenvolvido como parte da avaliação prática de Programação para Dispositivos Móveis II_
