# Cooper Tec · Heróis Marvel

[English](README.md) · **Português** · [Español](README.es.md)

[![CI](https://github.com/Lucasdiogof/cooper_tec/actions/workflows/ci.yml/badge.svg)](https://github.com/Lucasdiogof/cooper_tec/actions/workflows/ci.yml)

App Flutter feito como case técnico para uma entrevista de emprego na CooperTec. Login, lista de heróis da Marvel e tela de detalhes, usando a [API da Marvel](https://developer.marvel.com).

## Funcionalidades

- Login com validação de formulário (sem backend)
- Grade de heróis com scroll infinito, puxar para atualizar e busca por nome
- Detalhes com imagem, descrição, contagem de aparições e séries
- Estados de carregamento, vazio e erro com opção de tentar novamente
- Tema claro e escuro, interface em inglês, português e espanhol

## Estrutura

```
lib/
├── app/          # MaterialApp, tela de configuração ausente
├── core/         # config, DI, erros, Result, tema, widgets compartilhados
├── features/
│   ├── auth/         # login
│   └── characters/   # data / domain / presentation
└── l10n/         # arquivos .arb e código gerado
```

`Page → Cubit → UseCase → Repository → DataSource → API da Marvel`

- O data source lança exceções, o repositório transforma em uma `Failure` tipada e devolve um `Result` (`Ok` | `Err`).
- O cubit só faz `switch` no `Result`. A UI escolhe a mensagem de cada failure.
- Buscas substituídas durante o carregamento são ignoradas, e se a próxima página falhar a lista atual continua na tela.
- Cubit, get_it, http, equatable. Sem dartz, um `Result` selado resolve.

## Como rodar

```bash
cp env.example.json env.json   # coloque suas chaves do developer.marvel.com
flutter pub get
flutter run --dart-define-from-file=env.json
```

## Testes

```bash
flutter test
```

Testes unitários de todas as camadas e testes de widget de cada tela. O CI confere formatação, analyzer e testes.

> As primeiras versões tinham as chaves da Marvel fixas em `lib/core/key.dart`. Elas continuam no histórico do git, considere revogadas.
