import 'dart:convert';
import 'dart:io';
import 'dart:math';

class Contato {
  int id;
  String nome;
  String telefone;
  String email;
  Contato({
    required this.id,
    required this.nome,
    required this.telefone,
    required this.email,
  });
  Map<String, dynamic> toJson() {
    return {"id": id, "nome": nome, "telefone": telefone, "email": email};
  }

  factory Contato.fromJson(Map<String, dynamic> json) {
    return Contato(
      id: json["id"],
      nome: json["nome"],
      telefone: json["telefone"],
      email: json["email"],
    );
  }
}

class Agenda {
  final List<Contato> contatos = [];
  Future<void> iniciar() async {
    await carregarContatos();
    bool sair = false;
    while (!sair) {
      print("""
1 - Cadastrar contato
2 - Buscar contato
3 - Deletar contato
4 - Editar contato
5 - Listar contatos
0 - Sair
""");

      String? opcao = stdin.readLineSync();

      switch (opcao) {
        case "1":
          cadastrarContato();
          break;

        case "2":
          buscarContato();
          break;

        case "3":
          deletarContato();
          break;

        case "4":
          editarContato();
          break;

        case "5":
          listarContatos();
          break;

        case "0":
          sair = true;
          await salvarContatos();
          print("Programa encerrado.");
          break;

        default:
          print("Opção inválida.");
      }
    }
  }

  int gerarId() {
    int id;

    do {
      id = Random().nextInt(100000);
    } while (contatos.any((c) => c.id == id));

    return id;
  }

  bool nomeExiste(String nome, {int? ignorarId}) {
    return contatos.any((c) {
      if (ignorarId != null && c.id == ignorarId) {
        return false;
      }
      return c.nome.toLowerCase() == nome.toLowerCase();
    });
  }

  bool validarNome(String nome) {
    return RegExp(r'^[A-Za-zÀ-ÿ ]+$').hasMatch(nome);
  }

  bool validarTelefone(String telefone) {
    return RegExp(r'^\d{10,11}$').hasMatch(telefone);
  }

  bool validarEmail(String email) {
    return RegExp(
      r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
    ).hasMatch(email);
  }

  String lerNome({int? ignorarId}) {
    while (true) {
      print("Nome:");
      String nome = stdin.readLineSync()!.trim();
      if (nome.isEmpty) {
        print("Nome não pode estar vazio.");
        continue;
      }
      if (!validarNome(nome)) {
        print("Digite apenas letras.");
        continue;
      }
      if (nomeExiste(nome, ignorarId: ignorarId)) {
        print("Já existe um contato com esse nome.");
        continue;
      }
      return nome;
    }
  }

  String lerTelefone() {
    while (true) {
      print("Telefone:");

      String telefone = stdin.readLineSync()!.trim();

      if (!validarTelefone(telefone)) {
        print(
          "Telefone deve possuir apenas números e conter 10 ou 11 dígitos.",
        );
        continue;
      }

      return telefone;
    }
  }

  String lerEmail() {
    while (true) {
      print("Email:");

      String email = stdin.readLineSync()!.trim();

      if (!validarEmail(email)) {
        print("Email inválido.");
        continue;
      }

      return email;
    }
  }

  void cadastrarContato() {
    Contato contato = Contato(
      id: gerarId(),
      nome: lerNome(),
      telefone: lerTelefone(),
      email: lerEmail(),
    );
    contatos.add(contato);
    print("\nContato cadastrado com sucesso!");
    print("ID: ${contato.id}");

    salvarContatos();
  }

  void listarContatos() {
    if (contatos.isEmpty) {
      print("Nenhum contato cadastrado.");
      return;
    }

    print("");

    for (Contato contato in contatos) {
      print("-------------------------");
      print("ID: ${contato.id}");
      print("Nome: ${contato.nome}");
      print("Telefone: ${contato.telefone}");
      print("Email: ${contato.email}");
    }

    print("-------------------------");
  }

  void buscarContato() {
    if (contatos.isEmpty) {
      print("Nenhum contato cadastrado.");
      return;
    }

    print("Digite o nome:");

    String busca = stdin.readLineSync()!.trim().toLowerCase();

    List<Contato> encontrados = contatos
        .where((c) => c.nome.toLowerCase().contains(busca))
        .toList();

    if (encontrados.isEmpty) {
      print("Contato não encontrado.");
      return;
    }

    print("");

    for (Contato contato in encontrados) {
      print("-------------------------");
      print("ID: ${contato.id}");
      print("Nome: ${contato.nome}");
      print("Telefone: ${contato.telefone}");
      print("Email: ${contato.email}");
    }

    print("-------------------------");
  }

  Contato? buscarContatoPorId(int id) {
    try {
      return contatos.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  int? lerIdContato() {
    if (contatos.isEmpty) {
      print("Nenhum contato cadastrado.");
      return null;
    }

    listarContatos();

    print("\nDigite o ID:");

    int? id = int.tryParse(stdin.readLineSync() ?? "");

    if (id == null) {
      print("ID inválido.");
      return null;
    }

    Contato? contato = buscarContatoPorId(id);

    if (contato == null) {
      print("Contato inexistente.");
      return null;
    }

    return id;
  }

  void deletarContato() {
    int? id = lerIdContato();

    if (id == null) {
      return;
    }

    Contato contato = buscarContatoPorId(id)!;

    print("Deseja realmente excluir ${contato.nome}? (S/N)");

    String resposta = stdin.readLineSync()!.trim().toUpperCase();

    if (resposta != "S") {
      print("Operação cancelada.");
      return;
    }

    contatos.remove(contato);

    print("Contato removido com sucesso.");

    salvarContatos();
  }

  void editarContato() {
    int? id = lerIdContato();

    if (id == null) {
      return;
    }
    Contato contato = buscarContatoPorId(id)!;
    bool voltar = false;
    while (!voltar) {
      print("""
1 - Nome
2 - Telefone
3 - Email
0 - Voltar

""");
      String? opcao = stdin.readLineSync();
      switch (opcao) {
        case "1":
          contato.nome = lerNome(ignorarId: contato.id);
          print("Nome atualizado.");
          break;
        case "2":
          contato.telefone = lerTelefone();
          print("Telefone atualizado.");
          break;
        case "3":
          contato.email = lerEmail();
          print("Email atualizado.");
          break;
        case "0":
          voltar = true;
          continue;
        default:
          print("Opção inválida.");
          continue;
      }
      salvarContatos();
    }
  }

  Future<void> carregarContatos() async {
    try {
      final arquivo = File("contatos.json");
      if (!await arquivo.exists()) {
        return;
      }
      String conteudo = await arquivo.readAsString();

      if (conteudo.trim().isEmpty) {
        return;
      }
      List<dynamic> dados = jsonDecode(conteudo);
      contatos.clear();
      for (var item in dados) {
        contatos.add(Contato.fromJson(Map<String, dynamic>.from(item)));
      }
    } catch (e) {
      print("Erro ao carregar contatos.");
    }
  }

  Future<void> salvarContatos() async {
    final arquivo = File("contatos.json");

    List<Map<String, dynamic>> dados = contatos
        .map((contato) => contato.toJson())
        .toList();

    String jsonFormatado = const JsonEncoder.withIndent("  ").convert(dados);

    await arquivo.writeAsString(jsonFormatado);
  }
}

Future<void> main() async {
  Agenda agenda = Agenda();
  await agenda.iniciar();
}
