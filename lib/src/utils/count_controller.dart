class CountService {
  static final CountService _instance = CountService._internal();

  // passes the instantiation to the _instance object
  factory CountService() => _instance;

  int _valor = 1;

  int get valor => _valor;

  set valor(int value) => _valor = value;

  incrementValor() => _valor++;

  decreaseValor() => _valor--;

  CountService._internal() {
    _valor = 1;
  }
}
