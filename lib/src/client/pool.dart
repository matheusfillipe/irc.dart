part of irc.client;

/// Control Multiple Clients
class ClientPool {
  /// All Clients
  List<Client> clients = [];

  /// Adds a Client using the [config].
  int addClient(Configuration config, {bool connect = false}) {
    var client = Client(config);
    clients.add(client);
    if (connect) {
      client.connect();
    }
    return clients.indexOf(client);
  }

  Client clientAt(int position) => clients[position];

  int idOf(Client client) => clients.indexOf(client);

  Client operator [](int id) => clientAt(id);

  void connectAll() => forEach((client) => client.connect());
  void disconnectAll([String reason = '']) =>
      forEach((client) => client.disconnect(reason: reason));
  void sendMessage(String target, String message) =>
      forEach((client) => client.sendMessage(target, message));
  void register<T>(Type type, Function(T event) handler) =>
      forEach((client) => client.register(type, handler));
  void forEach(void Function(Client client) action) => clients.forEach(action);
}
