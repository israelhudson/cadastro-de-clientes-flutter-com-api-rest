class Cliente{

  String nome;
  String endereco;
  String contato;

  Cliente(String nome, String endereco, String contato){
    this.nome = nome;
    this.endereco = endereco;
    this.contato = contato;
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
    return 'Cliente{nome: $nome, endereco: $endereco, contato: $contato}';
  }


}