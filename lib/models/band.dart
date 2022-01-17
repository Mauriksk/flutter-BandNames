class Band {
  late String id;
  late String name;
  late int votes;

  Band({required this.id, required this.name, required this.votes});

  factory Band.fromMap(Map<String, dynamic> obj) {
    return Band(id: obj['id'], name: obj['name'], votes: obj['votes']);
  }
}

/*
El objetivo del fatory es regresar una nueva instancia de la clase, pero gracias a el 
lo puedo crear a trabes de un Map y con el tipado que nosotros queremos.
 */