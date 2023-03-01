import 'package:flutter/material.dart';

import '../../models/globals.dart';
import '../../models/helpers/api_helper.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "COVID CASES",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff00337C),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://img.freepik.com/free-vector/cure-new-virus-concept-illustrated_23-2148492991.jpg?w=740&t=st=1677663762~exp=1677664362~hmac=62f22dc4d4ef7ddd44fa81a5b8efe025234dcad81f8a3d80b70490543d4f7671"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (val) {
                        setState(() {
                          Globals.Country = val;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Search",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: FutureBuilder(
                      future: ApiHelper.apiHelper
                          .CovidApi(Country: Globals.Country),
                      builder: (context, snapShot) {
                        if (snapShot.hasError) {
                          return Text("${snapShot.error}");
                        } else if (snapShot.hasData) {
                          Map? P = snapShot.data;
                          return Padding(
                            padding: const EdgeInsets.only(
                              top: 40,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: 90,
                                  width: 320,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.black,
                                    ),
                                    color: Colors.blue.shade50,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    "${P!['data']['location']}",
                                    style: const TextStyle(
                                      fontSize: 22,
                                      color: Color(0xff00337C),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 30,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: 200,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.black,
                                          ),
                                          color: Colors.green.shade50,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            const Text(
                                              "TOTAL",
                                              style: TextStyle(
                                                fontSize: 22,
                                                color: Color(0xff609966),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              "${P['data']['confirmed']}",
                                              style: const TextStyle(
                                                fontSize: 20,
                                                color: Color(0xff609966),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 200,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.black,
                                          ),
                                          color: Colors.red.shade50,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            const Text(
                                              "DEATH",
                                              style: TextStyle(
                                                fontSize: 22,
                                                color: Color(0xffEB455F),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              "${P['data']['deaths']}",
                                              style: const TextStyle(
                                                fontSize: 20,
                                                color: Color(0xffEB455F),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
