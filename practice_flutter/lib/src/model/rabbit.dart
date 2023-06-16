class Rabbit {
  String name;
  RabbitState state;

  Rabbit({required this.name, required this.state});

  updateState(RabbitState state) {
    this.state = state;
  }
}

enum RabbitState { SLEEP, RUN, WALK, EAT }
