class Constants {
  // app info
  static final String APP_VERSION = "0.0.1";
  static final String APP_NAME = "TicketStore";

  // addresses
  static final String ADDRESS_STORE_SERVER = "localhost:9090";
  static final String ADDRESS_AUTHENTICATION_SERVER = "localhost:8080";

  // authentication
  static final String REALM = "ticketstore-flutter";
  static final String CLIENT_ID = "ticketstore-flutter";
  static final String CLIENT_SECRET = "ld5PGgxa4X4KJok1dJEC8OtP8Jjm4Rif";
  static final String REQUEST_LOGIN = "/auth/realms/" + REALM + "/protocol/openid-connect/token";
  static final String REQUEST_LOGOUT = "/auth/realms/" + REALM + "/protocol/openid-connect/logout";

  // requests
  static final String REQUEST_SEARCH_EVENTS = "/eventi/byName";
  static final String REQUEST_ADD_USER = "/users";

  // states
  static final String STATE_CLUB = "club";

  // responses
  static final String RESPONSE_ERROR_MAIL_USER_ALREADY_EXISTS = "ERROR_MAIL_USER_ALREADY_EXISTS";

  // messages
  static final String MESSAGE_CONNECTION_ERROR = "connection_error";


}