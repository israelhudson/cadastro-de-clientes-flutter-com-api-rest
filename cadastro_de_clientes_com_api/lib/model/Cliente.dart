class Cliente{

  int id;
  String nome;
  String endereco;
  String contato;

  Cliente(int id, String nome, String endereco, String contato){
    this.id = id;
    this.nome = nome;
    this.endereco = endereco;
    this.contato = contato;
  }

  String getId(){
    this.id;
  }

  String getNome(){
    this.nome;
  }

  String getEndereco(){
    this.endereco;
  }

  String getContato(){
    this.contato;
  }

  @override
  String toString() {
    return 'Cliente{id: $id, nome: $nome, endereco: $endereco, contato: $contato}';
  }

}