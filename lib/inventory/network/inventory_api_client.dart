import 'package:dio/dio.dart';
import 'package:hcn_flutter/modules/session_module.dart';
import 'package:retrofit/retrofit.dart';
import '../modules/plant_variants_module.dart';
part 'inventory_api_client.g.dart';

@RestApi()
abstract class RestClient {
 factory RestClient(Dio dio) = _RestClient;

  @POST("/web/session/authenticate")
  Future<HttpResponse<dynamic>> getSessionCookie(
      @Body() SessionModule sessionModule);

  @GET("/api/product.template")
  Future<PlantVariantsResponseModule> getInventoryPlants(
      @Header("Cookie")String cookie,
      @Query("query") String query,
      @Query("filter") String filter,
      @Query("page_size") int pageSize,
      @Query("page") int page,
      );

  @GET("/api/product.template/{id}")
  Future<HttpResponse<PlantVariants>> getInventorySpecificPlant(
      @Header("Cookie")String cookie,
      @Query("query") String query,
      @Path("id") String plantId);
}
