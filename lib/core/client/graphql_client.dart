import 'package:graphql_flutter/graphql_flutter.dart';

class GraphqlAPIClient {
  static HttpLink httpLink = HttpLink("https://shikimori.one/api/graphql");
  GraphQLClient client = GraphQLClient(cache: GraphQLCache(), link: httpLink);
}
