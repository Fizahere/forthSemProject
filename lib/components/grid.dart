import 'package:baby_shop/ClientSite/product_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Grid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Products').snapshots(),
            builder: (BuildContext context,snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              if(snapshot.hasData){
                var docsLength= snapshot.data?.docs.length;
                return docsLength !=0 ? ListView.builder(
                    itemCount: docsLength,
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                      String productName=snapshot.data?.docs[index]['Name'];
                      String productDescription=snapshot.data?.docs[index]['Description'];
                      String productCategory=snapshot.data?.docs[index]['Category'];
                      String productPrice=snapshot.data?.docs[index]['Price'];
                      String productImage=snapshot.data?.docs[index]['Image'];
                      return       GridView.count(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        crossAxisCount: 2,
                        children: List.generate(9, (index) {
                          return GestureDetector(
                            onTap:(){
                              Navigator.push(context,MaterialPageRoute(builder:(context)=>ProductDetailScreen()));
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 140,
                                  width: 140,
                                  margin: EdgeInsets.all(4),

                                  child: Image.network(productImage),
                                  decoration: BoxDecoration(
                                      color: Colors.deepPurpleAccent.shade100,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(productName,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                    Text(productPrice,style: TextStyle(fontSize: 14,color: Colors.green),),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                      );
                    })
                    : Center(child: Text('no products found'),);
              };
              if(snapshot.hasError){
                return Center(child: Icon(Icons.error,color: Colors.red,),);
              }
              return Container();
            }
        ),

      ],
    );


  }
}