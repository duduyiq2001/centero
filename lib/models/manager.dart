class Manager {
  final String name;
  final String id;

  Manager({
    required this.name,
    required this.id,
  });
}

// the id value should match with the auto-generated one on firebase

List<Manager> dummyManagers = [
  Manager(
    name: "Steve",
    id: "IdVEYJwM8YD1HrkHDtXygUhdgvoD",
  ),
  Manager(
    name: "Bob Jones",
    id: "9hiAh54hJzsnEiqrE2tZ9VhaZ9YL",
  ),
];
