class Model {
  Model({
    required this.id,
    required this.name,
    required this.isSelected,
  });

  final String id;
  final String name;
  final bool isSelected;

  @override
  String toString() {
    return "$isSelected";
  }

  Model copyWith({
    String? id,
    String? name,
    bool? isSelected,
  }) {
    return Model(
      id: id ?? this.id,
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
