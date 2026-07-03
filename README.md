Agenda de Contatos em Dart
Sobre o projeto

Este projeto consiste em uma aplicação de CRUD (Create, Read, Update e Delete) desenvolvida em Dart para execução no terminal.

A aplicação permite cadastrar, buscar, editar, remover e listar contatos, além de realizar a persistência dos dados em um arquivo JSON, garantindo que as informações permaneçam salvas entre as execuções do programa.

Funcionalidades
Cadastro de contatos
Busca de contatos por nome
Listagem de todos os contatos
Edição de contatos
Exclusão de contatos
Persistência de dados em arquivo JSON
Geração automática de um arquivo README com o resumo dos contatos
Validação de nome, telefone e e-mail
Geração automática de identificadores únicos para os contatos
Tecnologias utilizadas
Dart
dart:io
dart:convert
dart:math
Estrutura do projeto
.
├── main.dart
├── contatos.json
└── README.md
Como executar
Certifique-se de que o Dart esteja instalado em seu computador.
Clone ou faça o download deste repositório.
Abra o terminal na pasta do projeto.
Execute o comando:
dart run main.dart
Menu da aplicação
AGENDA DE CONTATOS

1 - Cadastrar contato
2 - Buscar contato
3 - Deletar contato
4 - Editar contato
5 - Listar contatos
0 - Sair
Persistência dos dados

Os contatos são armazenados no arquivo contatos.json.

Sempre que um contato é cadastrado, editado ou removido, o arquivo é atualizado automaticamente. Ao iniciar a aplicação, os dados são carregados do arquivo, preservando todas as informações previamente salvas.

Validações
Nome
Não pode estar vazio;
Aceita apenas letras e espaços;
Não permite nomes duplicados.
Telefone
Deve conter apenas números;
Deve possuir 10 ou 11 dígitos.
E-mail
Deve seguir um formato válido de endereço eletrônico.
Objetivos do projeto

Este projeto foi desenvolvido com o objetivo de praticar os principais conceitos da linguagem Dart, incluindo:

Manipulação de arquivos;
Serialização e desserialização de dados em JSON;
Estruturas condicionais e de repetição;
Funções;
Expressões regulares (Regex);
Manipulação de coleções (Map e List);
Organização de código;
Operações de CRUD.
Possíveis melhorias
Implementação de interface gráfica com Flutter;
Ordenação automática dos contatos;
Busca por telefone e e-mail;
Exportação dos contatos para CSV;
Importação de contatos;
Implementação de testes automatizados;
Refatoração para programação orientada a objetos com separação em múltiplos arquivos.
Autor

Projeto desenvolvido como atividade prática para aplicação dos conceitos fundamentais da linguagem Dart, com foco em manipulação de arquivos, persistência de dados e implementação de operações de CRUD em ambiente de terminal.
