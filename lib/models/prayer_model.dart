class Prayer {
  final String name;
  final String time;

  Prayer({required this.name, required this.time});

  factory Prayer.fromJson(Map<String, dynamic> json) {
    return Prayer(
      name: json['name'],
      time: json['time'],
    );
  }
}
