import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VariantsLocationScreen extends StatefulWidget {
   VariantsLocationScreen({super.key,  this.plantVariantName, this.plantName});

  final String? plantVariantName;
  final String? plantName;

  @override
  State<VariantsLocationScreen> createState() => _VariantsLocationScreenState();
}

class _VariantsLocationScreenState extends State<VariantsLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        leadingWidth: 30,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text('Locations'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 25),
            child: Text(
              // 'Netpot 0-1 Feet',
              widget.plantVariantName!,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                    fontSize: 25,
                    color: Color(0xff212121),
                    fontWeight: FontWeight.w500,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 25),
            child: Text(
              '( ${widget.plantName!.split('|')[0].trim()} | ${widget.plantName!.split('|')[1].trim()})',
              // plantVariants!.name.toString().split('|')[0].trim()
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * .015,
                    color: Color(0xff757575),
                    fontWeight: FontWeight.w500,
                  )),
            ),
          ),

          Expanded(
            child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return listChild3(index);
                }),
          ),


        ],
      ),
    );
  }

  Widget listChild3(int index) {
    double radius = MediaQuery.of(context).size.height * .04;
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 15),
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Heartyculture Natural Product LLP - New Warehouse: Supply Product from kanha Nursery Retail',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                            fontSize: 20,
                            color: Color(0xff757575),
                            fontWeight: FontWeight.w700,
                          )),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Divider(thickness: 1, color: Color(0xffdcb3b3), indent: 20, endIndent: 20,),
                  ListTile(
                    leading: Icon(Icons.location_on, size: 40,),
                    title: Text(
                      'Go to Location',
                      style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                            fontSize: 20,
                            color: Color(0xff757575),
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                  ),
                  ListTile(
                    onTap: (){
                      showDialog(context: context,
                          builder: (context){
                            return  Dialog(
                              insetPadding: EdgeInsets.symmetric(horizontal: 20),
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),),
                              elevation: 4,
                              child: Wrap(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xfff3f0f0),
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 10,top: 10, bottom: 10),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Location',
                                                    style: GoogleFonts.nunito(
                                                        textStyle: TextStyle(
                                                          fontSize: 16,
                                                          color: Color(0xffbd1616),
                                                          fontWeight: FontWeight.w700,
                                                        )),
                                                  ),
                                                  SizedBox(height: 10,),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                                    child: Text(
                                                      'Heartyculture Natural Product LLP - New Warehouse: Supply Product from kanha Nursery Retail',
                                                      style: GoogleFonts.nunito(
                                                          textStyle: TextStyle(
                                                            fontSize: 16,
                                                            color: Color(0xff212121),
                                                            fontWeight: FontWeight.w500,
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xfff3f0f0),
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Units Count',
                                                    style: GoogleFonts.nunito(
                                                        textStyle: TextStyle(
                                                          fontSize: 16,
                                                          color: Color(0xffbd1616),
                                                          fontWeight: FontWeight.w700,
                                                        )),
                                                  ),
                                                  const SizedBox(height: 10,),
                                                  TextFormField(
                                                    initialValue: '40',
                                                    keyboardType: TextInputType.number,
                                                    autofocus: true,
                                                    showCursor: true,

                                                  ),
                                                  // SizedBox(height: 10,)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20,),

                                        // Row(
                                        //   children: [
                                        //     Container(
                                        //       width: 100,
                                        //       margin: const EdgeInsets.only(left: 25, right: 25),
                                        //       child: ElevatedButton(
                                        //           onPressed: () {
                                        //           },
                                        //           style: ButtonStyle(
                                        //               backgroundColor: MaterialStateProperty.all(
                                        //                 Theme.of(context).primaryColor,
                                        //               ),
                                        //               padding: MaterialStateProperty.all(
                                        //                   const EdgeInsets.all(20)),
                                        //               shape: MaterialStateProperty.all<
                                        //                   RoundedRectangleBorder>(
                                        //                   RoundedRectangleBorder(
                                        //                       borderRadius:
                                        //                       BorderRadius.circular(50.0)))),
                                        //           child: Text(
                                        //             "Cancel",
                                        //             style: GoogleFonts.nunito(
                                        //                 textStyle: const TextStyle(
                                        //                   fontSize: 18,
                                        //                   color: Colors.white,
                                        //                   fontWeight: FontWeight.w700,
                                        //                 )),
                                        //           )),
                                        //     ),
                                        //
                                        //   ],
                                        // )

                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            );

                          }
                      );
                    },
                    leading: Icon(Icons.edit_note, size: 40,),
                    title: Text(
                      'Edit Units Count',
                      style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                            fontSize: 20,
                            color: Color(0xff757575),
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Card(
        elevation: 3,
        margin: EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 5),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 260,
                  child: Text(
                    'Heartyculture Natural Product LLP - New Warehouse: Supply Product from kanha Nursery Retail',
                    style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                ),
                VerticalDivider(color: Color(0xffeacfcf,), thickness: 1.5, indent: 1, endIndent: 1,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '40',
                        style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        'Units',
                        style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

  }

}
