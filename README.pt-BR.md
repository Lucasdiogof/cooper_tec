# Cooper Tec

Leia em: [English](README.md) | **Português**

Um pequeno projeto Flutter feito como teste técnico para uma entrevista de emprego na CooperTec. O app faz login, busca uma lista de heróis da [API da Marvel](https://developer.marvel.com) e permite abrir um herói para ver seu id e as séries em que ele aparece.

## Por que essas escolhas

- **Clean Architecture** — o projeto é pequeno, mas separar as camadas `data` / `domain` / `presentation` mantém a API da Marvel, as regras de negócio e a UI independentes entre si, e deixa cada parte fácil de testar isoladamente.
- **Cubit** (uma subgerência do `flutter_bloc`) — uma alternativa mais leve ao Bloc completo, adequada à máquina de estados simples deste projeto (`initial → loading → success/error`).
- **GetIt** para injeção de dependência, conectando datasource, repositório, use case e cubit em [`lib/core/injection.dart`](lib/core/injection.dart).
- **`Either` do dartz** para deixar as falhas explícitas na camada de domínio, em vez de depender de exceções lançadas.

## Fluxo do app

1. **Login** — validação simples no cliente (formato de email válido e senha com 6+ caracteres). Não há backend real por trás; é apenas uma porta de entrada para o fluxo principal.
2. **Lista de heróis** — começa em estado de carregamento e depois exibe os heróis retornados pela API da Marvel. Uma falha na requisição mostra uma mensagem com um botão de tentar novamente, em vez de simplesmente falhar em silêncio.
3. **Detalhes do herói** — mostra o id do herói e as séries em que ele já apareceu.

## Estrutura do projeto

```
lib/
├── core/                    # configuração de ambiente, DI, geração da URL/hash da Marvel
└── features/
    ├── data/                # datasource remoto, implementação do repositório, DTOs
    ├── domain/               # entidades, contrato do repositório, use case
    └── presentation/         # cubit, páginas e widgets
```

## Como rodar

### 1. Obtenha uma chave da API da Marvel

Cadastre-se em [developer.marvel.com](https://developer.marvel.com) e pegue suas chaves pública e privada.

### 2. Configure o ambiente

Este projeto lê as chaves da API em tempo de compilação via `--dart-define-from-file`, então nenhuma chave é commitada no repositório.

```bash
cp env.example.json env.json
```

Preencha o `env.json` com suas próprias chaves:

```json
{
  "MARVEL_PUBLIC_API_KEY": "sua-chave-publica-da-marvel",
  "MARVEL_PRIVATE_API_KEY": "sua-chave-privada-da-marvel"
}
```

### 3. Instale as dependências

```bash
flutter pub get
```

### 4. Rode o app

```bash
flutter run --dart-define-from-file=env.json
```

## Testes

O projeto tem testes unitários (models, repositório, use case, cubit, gerador de URL) e testes de widget (validação do login, estados da lista de heróis, tela de detalhes do herói).

```bash
flutter test
```

## Nota de segurança

Versões anteriores deste repositório tinham as chaves da API da Marvel commitadas em texto puro em `lib/core/key.dart`. Agora as chaves são lidas do `env.json` em tempo de compilação (veja [`env.example.json`](env.example.json) e [`lib/core/env_config.dart`](lib/core/env_config.dart)) e nunca são commitadas. Como as chaves antigas ficaram expostas no histórico do git de um repositório público, elas devem ser tratadas como comprometidas — gere novas chaves na sua conta do [developer.marvel.com](https://developer.marvel.com) antes de voltar a usar este projeto.
