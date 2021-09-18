class Grade {
  final String name;
  final int value;

  Grade(this.name, this.value);

  int compareTo(Grade grade) {
    return value - grade.value;
  }
}
