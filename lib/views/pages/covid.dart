import 'package:covid_19/views/pages/info.dart';
import 'package:flutter/material.dart';

import '../../models/globals.dart';
import '../../models/helpers/api_helper.dart';

class Covid extends StatefulWidget {
  const Covid({Key? key}) : super(key: key);

  @override
  State<Covid> createState() => _CovidState();
}

class _CovidState extends State<Covid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "COVID CASES",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff13005A),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Expanded(
            child: FutureBuilder(
              future: ApiHelper.apiHelper.CovidAllApi(),
              builder: (context, snapShot) {
                if (snapShot.hasError) {
                  return Text("${snapShot.error}");
                } else if (snapShot.hasData) {
                  Map? P = snapShot.data;
                  return ListView.builder(
                    itemCount: 189,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            Globals.Country = "${P['response'][i]}";
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const Info(),
                              ),
                            );
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                          ),
                          child: Container(
                            height: 70,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color(0xffD6E4E5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${i + 1}",
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff3B3486),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Text(
                                      P!['response'][i],
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff3B3486),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ),
    );
  }
}
