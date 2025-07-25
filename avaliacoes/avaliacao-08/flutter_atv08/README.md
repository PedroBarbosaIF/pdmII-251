## Flutter Anime & Usuários App

Este projeto é uma aplicação Flutter desenvolvida para a disciplina de PDM II, Avaliação 08. O app permite visualizar uma lista de animes e usuários, utilizando arquitetura organizada e boas práticas de desenvolvimento.

---

### Funcionalidades

- Listagem de animes
- Listagem de usuários
- Consumo de API (serviço simulado)
- Interface responsiva

---

### Estrutura de Pastas

```
lib/
  main.dart                # Ponto de entrada do app
  models/                  # Modelos de dados (Anime, Usuário)
  screens/                 # Telas principais (Animes, Usuários)
  services/                # Serviços para API e lógica de negócio
assets/                    # Imagens e recursos estáticos
test/                      # Testes automatizados
```

---

### Como executar o projeto

1. **Pré-requisitos:**
   - Flutter instalado ([Guia oficial](https://docs.flutter.dev/get-started/install))
   - Dart SDK
2. **Instale as dependências:**
   ```sh
   flutter pub get
   ```
3. **Execute o app:**
   ```sh
   flutter run
   ```
   Você pode escolher o dispositivo (emulador ou físico) para rodar o app.

---

### Testes

Para rodar os testes automatizados:

```sh
flutter test
```

---

### Personalização

- Adicione novos animes ou usuários editando os arquivos em `lib/models/`.
- Modifique a interface nas telas em `lib/screens/`.

---

### Contato

- **Autor:** Pedro
- **Disciplina:** PDM II
- **E-mail:** seuemail@exemplo.com

---

### Licença

Este projeto é apenas para fins educacionais.
