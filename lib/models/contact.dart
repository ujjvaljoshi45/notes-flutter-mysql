class Contact {
  String name;
  String phno;

  Contact({required this.name, required this.phno});

  Map<String, Object?> toMap() {
    return {'name': name, 'phno': phno};
  }

  Contact.fromMap(Map<String, dynamic> item)
      : name = item['name'] as String,
        phno = item['phno'] as String;
}
