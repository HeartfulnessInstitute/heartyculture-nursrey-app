// flutter run lib/main.dart --dart-define=SUPABASE_URL=url
abstract class Constants {
  static const String baseURL = 'https://erp.heartyculturenursery.com';
  static const db = "hc-nursery";
  static const login = "vignesh.manickam@volunteer.heartfulness.org";
  static const password = "hcnVignesh";
  static const imageBaseURL = 'https://erp.heartyculturenursery.com/web/image?model=product.template&id=';
  static const String ONBOARD_PREFERENCE_KEY = "ONBOARD_PREFERENCE_KEY";

  static const String fertilizer_notification_desc = "Fertilizer is added to the plants to promote growth and productivity. These fertilisers contain essential nutrients required by the plants, including nitrogen, potassium, and phosphorus. They also enhance the water retention capacity of the soil and increase its fertility.";
  static const String fertilizer_notification_title = "Need Fertilizers - i am Hungry!";
  static const String fertilizer_notification_type = "Fertilizers Reminder";
  static const int fertilizer_notification_id = 999999999;
  static const int fertilizer_notification_interval = 60*60*24*30;

  static const String water_notification_desc ="Your Plant needs water. Kindly  water it, before it dies!";
  static const String water_notification_type = "Water";


}