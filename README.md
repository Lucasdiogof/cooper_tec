# cooper_tec

Projeto para a empresa CooperTec

Optei pela utilização de clean arch (apesar do projeto ser pequeno, já estou ambientado com os conceitos, então achei mais fácil) e pra gerência do estado de tela optei pelo cubit (subgerência do bloc), que basicamente simplifica a maneira de gerenciar os estados.

Não sobrou muito tempo para "caprichar" nas telas, porém tentei ao máximo deixar os componentes agradáveis para o usuário e também tive uma atenção para separar alguns widgets pro código ficar mais limpo.

O fluxo do app é: 
* Tela de Login com algumas validações simples (quantidade de caracteres).
* Tela principal do aplicativo com o estado inicial em carregamento e a listagem dos heróis da Marvel em caso da API retornar sucesso.
  - Nos casos de erro ao conectar na API estou apenas exibindo uma tela vermelha.
* Ao selecionar um herói estou mostrando o ID e as séries que esse herói participou.

Utilizei a API da Marvel (https://developer.marvel.com).
