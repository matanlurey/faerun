/// TODO: Document.
enum Condition implements Comparable<Condition> {
  blinded,
  charmed,
  deafened,
  exhaustion,
  frightened,
  grappled,
  incapacitated,
  invisible,
  paralyzed,
  petrified,
  poisoned,
  prone,
  restrained,
  stunned,
  unconscious;

  @override
  int compareTo(Condition other) => index.compareTo(other.index);
}
