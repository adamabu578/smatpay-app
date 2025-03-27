import 'package:firebase_analytics/firebase_analytics.dart';

class TAnalyticsEngine {
  static final _instance = FirebaseAnalytics.instance;

  static void userLogsIn(String loginMethod) async {
    FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

    return _instance.logLogin(loginMethod: loginMethod);
  }

  static void addsItemToCart(String itemId, int cost) async {
    return _instance
        .logAddToCart(items: [AnalyticsEventItem(itemId: itemId, price: cost)]);
  }
}
