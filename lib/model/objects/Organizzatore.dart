class Organizzatore {
  late int id;
  late String nome;


  Organizzatore({required this.id, required this.nome});


  factory Organizzatore.fromJson(Map<String, dynamic> json) {
    return Organizzatore(
      id: json['id'],
      nome: json['nome'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
  };

  @override
  String toString() {
    return nome;
  }


}