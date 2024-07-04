import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ExportSuccessPage extends StatefulWidget {
  ExportSuccessPage(this.type);
  String type;

  @override
  State<ExportSuccessPage> createState() => _ExportSuccessPageState(this.type);
}

class _ExportSuccessPageState extends State<ExportSuccessPage> {
  String type;
  _ExportSuccessPageState(this.type);

  late Widget isi;

  @override
  void initState() {
    super.initState();
    isi = isi = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('lib/assets/success.png', height: 130,),
          SizedBox(height: 20,),
          Text(
            'Data has been exported',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 17, 80, 156)),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Kembali', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          ),
        ],
      );
    exporting();
  }

  bool isLoading = true;

  void exporting () async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 3), () {
      
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 17, 80, 156),
        title: Text('Export Data', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back, color: Colors.white,),)
      ),
      body: Center(
        child: isLoading ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CircularProgressIndicator(color: Colors.deepPurple), SizedBox(height: 20,), Text("Exporting data to ${type}....")],
          )
        ) : isi
      ),
    );
  }
}