# Cooper Tec · Heróis Marvel

[English](README.md) · **Português** · [Español](README.es.md)

[![CI](https://github.com/Lucasdiogof/cooper_tec/actions/workflows/ci.yml/badge.svg)](https://github.com/Lucasdiogof/cooper_tec/actions/workflows/ci.yml)

Um app Flutter que lista os personagens da Marvel usando a [API oficial da Marvel](https://developer.marvel.com). Fiz a primeira versão em 2023, como case técnico para uma entrevista de emprego na CooperTec, quando eu ainda estava começando com Flutter. Depois voltei nele e reescrevi boa parte com o que aprendi desde então, mantendo o escopo original: uma tela de login, uma lista de heróis e uma tela de detalhes.

A ideia do repositório é mostrar como eu organizo um projeto Flutter, então aqui o código importa mais do que a quantidade de funcionalidades.

## O que o app faz

- **Login** com validação de formulário. Não existe backend por trás, o case pedia só a tela.
- **Grade de heróis** com scroll infinito, puxar para atualizar e busca por nome (com debounce enquanto você digita).
- **Detalhes** com a imagem, descrição, quantidade de quadrinhos, séries, histórias e eventos, e as séries em que o herói aparece.
- Estados de carregamento, vazio e erro, com opção de tentar novamente tanto na primeira página quanto nas seguintes.
- Tema claro e escuro, seguindo o sistema.
- Interface em inglês, português e espanhol, escolhida pelo idioma do aparelho.

## Arquitetura

O código é separado por feature, e cada feature segue Clean Architecture com três camadas:

```
lib/
├── app/                      # MaterialApp, tema e configuração de idiomas
├── core/                     # o que é compartilhado entre as features
│   ├── config/               # chaves lidas com --dart-define
│   ├── di/                   # registros do get_it
│   ├── error/                # exceptions (data) e failures (domain)
│   ├── network/              # URLs assinadas da API da Marvel
│   ├── result/               # Result<T> = Ok | Err
│   ├── theme/
│   ├── validation/
│   └── widgets/
├── features/
│   ├── auth/presentation/    # tela de login
│   └── characters/
│       ├── data/             # data source remoto, models do JSON, implementação do repositório
│       ├── domain/           # entidades, contrato do repositório, use case GetCharacters
│       └── presentation/     # cubit, páginas e widgets
└── l10n/                     # arquivos .arb (en, pt, es) e código gerado
```

Uma requisição passa pelas camadas assim:

```
CharactersPage → CharactersCubit → GetCharacters → CharactersRepository → MarvelCharactersRemoteDataSource → API da Marvel
```

- O **data source** só conversa com HTTP: monta a URL assinada, decodifica o JSON e lança exceções quando algo dá errado.
- O **repositório** transforma essas exceções em uma `Failure` (sem conexão, chaves inválidas, limite de requisições, erro no servidor, resposta ilegível) e devolve um `Result`.
- O **cubit** nunca vê uma exceção. Ele faz um `switch` no `Result` e emite um novo estado.
- A **UI** decide como cada `Failure` aparece escrita, assim as mensagens podem ser traduzidas e o domínio não sabe nada de texto.

### Decisões que valem explicar

- **Cubit em vez de Bloc.** A tela tem poucas interações (carregar, buscar, carregar mais, atualizar), e métodos simples ficam mais legíveis que eventos para isso.
- **Um `Result` selado e pequeno em vez do `dartz`.** Com as sealed classes e o pattern matching do Dart 3, o `Either` acrescenta pouco e traz uma dependência inteira junto.
- **A paginação não mexe no status principal.** Se a segunda página falhar, os heróis que já estão na tela continuam lá e aparece um botão de tentar novamente no fim da lista.
- **Respostas fora de ordem são descartadas.** Cada busca incrementa um contador no cubit; uma resposta que chega depois de uma busca mais nova ter começado é ignorada, então digitar rápido nunca mostra resultado de uma busca antiga.
- **As chaves não ficam no código.** Elas vêm do `env.json` via `--dart-define-from-file`, e o arquivo está no `.gitignore`. Se o app for iniciado sem elas, aparece uma tela explicando o que fazer em vez de quebrar.
- **Placeholder para imagens que faltam.** Muitos personagens usam a imagem de "image not available" da Marvel. O model trata isso como ausência de imagem e a UI desenha as iniciais sobre uma cor derivada do nome.

## Como rodar

Você precisa de um Flutter stable recente (estou usando o 3.47) e de um par de chaves da API da Marvel.

1. Crie uma conta em [developer.marvel.com](https://developer.marvel.com) e copie suas chaves pública e privada.
2. Crie o seu arquivo de ambiente:

   ```bash
   cp env.example.json env.json
   ```

3. Preencha o `env.json`:

   ```json
   {
     "MARVEL_PUBLIC_API_KEY": "sua chave pública",
     "MARVEL_PRIVATE_API_KEY": "sua chave privada"
   }
   ```

4. Instale as dependências e rode:

   ```bash
   flutter pub get
   flutter run --dart-define-from-file=env.json
   ```

No VS Code, a configuração em `.vscode/launch.json` já passa o arquivo de ambiente, então é só apertar F5.

## Testes

```bash
flutter test
```

Tem testes unitários da assinatura das URLs, dos validadores, dos models do JSON, do data source (com o `MockClient` do `http`), do repositório (cada exceção mapeada para a sua failure), do use case e do cubit (`bloc_test`), além de testes de widget do login, dos estados da lista, da tela de detalhes e dos idiomas. O CI no GitHub Actions confere a formatação, roda o analyzer e os testes a cada push.

## Próximos passos

- Guardar as páginas em cache para a lista abrir offline.
- Golden tests dos cards e da tela de detalhes.
- Um teste de integração passando pelo fluxo todo contra um servidor fake.
- Um fluxo de autenticação de verdade, se o app um dia tiver backend.

## Observações

- Dados fornecidos pela Marvel. © Marvel. O app mostra essa atribuição, como os termos da API pedem.
- As primeiras versões deste repositório tinham as chaves da Marvel fixas em `lib/core/key.dart`. Elas continuam no histórico do git, então considere essas chaves revogadas.
- A fonte dos títulos é a [Bebas Neue](https://fonts.google.com/specimen/Bebas+Neue), sob a SIL Open Font License (`assets/fonts/OFL.txt`).
