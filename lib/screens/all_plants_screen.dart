import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../modules/plant_module.dart';
import 'plant_screen.dart';
import '../network/api_service_singelton.dart';
import '../preference_storage/storage_notifier.dart';

class AllPlantsScreen extends StatefulWidget {
  const AllPlantsScreen({super.key});

  @override
  State<AllPlantsScreen> createState() => _AllPlantsScreenState();
}

class _AllPlantsScreenState extends State<AllPlantsScreen> {
  List<Plants> plantsList = [];
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  int currentPage=1;
  int totalPages = 10;

  Future<void> callAllPlantsAPI() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      var query = "{id, price, list_price, standard_price, name, description, image_256}";
      var filter = '[["categ_id", "=", "Aug-2023 / Incomplete"]]';
      var pageSize = 50;
      var cookie = await SessionTokenPreference.getSessionToken();
      var response = await ApiServiceSingleton.instance.getPlants(
          cookie, query, filter, pageSize, currentPage);
      if (response.result != null) {
        setState(() {
          plantsList.addAll(response.result as Iterable<Plants>);
          totalPages = response.totalPages!;
          currentPage++;
          isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    callAllPlantsAPI();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if(currentPage<totalPages){
        callAllPlantsAPI();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("All Plants",
            style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w400))),
        actions: [
          IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Search',
              onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.sort),
              tooltip: 'Search',
              onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.notifications),
              tooltip: 'Search',
              onPressed: () {})
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            ListView.builder(
                controller: _scrollController,
                itemCount: plantsList.length,
                itemBuilder: (context, index) {
                  return listChild(index);
                }),
            Visibility(
              visible: isLoading,
              child: Container(
                color: Colors.black.withOpacity(.75),
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget listChild(int index) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>const PlantScreen())
        );
      },
      child: Card(
        elevation: 2,
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(12),
              child: CircleAvatar(
                  radius: 26, // Image radius
                  backgroundColor: Theme.of(context).primaryColor,
                  backgroundImage: const NetworkImage(
                      'https://www.ugaoo.com/cdn/shop/products/ajwain-plant-32220864446596.jpg')),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              Text(
                plantsList[index].name.toString(),
                style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                )),
              ),
              Text(
                "Acrocarpus Fraxinifolius",
                style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                  fontSize: 12,
                  color: Color(0xff757575),
                  fontWeight: FontWeight.w400,
                )),
              )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
