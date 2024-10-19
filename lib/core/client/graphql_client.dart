import 'package:graphql_flutter/graphql_flutter.dart';

class GraphqlAPIClient {
  static HttpLink httpLink = HttpLink("https://graphql.anilist.co");
  GraphQLClient client = GraphQLClient(cache: GraphQLCache(), link: httpLink);
}
