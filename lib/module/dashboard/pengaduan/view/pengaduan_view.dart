import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/pengaduan_controller.dart';
import 'package:sipevo/core.dart';

class PengaduanView extends StatelessWidget {
  const PengaduanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PengaduanController>(
      init: PengaduanController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Pengaduan"),
            actions: [
              IconButton(
                onPressed: () => controller.logout(),
                icon: const Icon(
                  Icons.logout,
                  size: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () => controller.refreshPengaduan(),
                  icon: const Icon(Icons.refresh),
                ),
              ),
            ],
          ),
          body: controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : controller.pengaduanList.isEmpty
                  ? Center(
                      child: Text('Data tidak tersedia!'),
                    )
                  : ListView.builder(
                      itemCount: controller.pengaduanList.length,
                      itemBuilder: (context, index) {
                        var pengaduan = controller.pengaduanList[index];
                        Color backgroundColor;

                        switch (pengaduan.pengaduanStatus.name) {
                          case 'Pending':
                            backgroundColor = Colors.red;
                            break;
                          case 'Sedang diproses':
                            backgroundColor = Colors.yellow;
                            break;
                          case 'Terselesaikan':
                            backgroundColor = Colors.green;
                            break;
                          default:
                            backgroundColor = Colors.grey;
                        }

                        return Card(
                          margin: EdgeInsets.all(10.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(pengaduan.image),
                            ),
                            title: Text(pengaduan.title),
                            subtitle: RichText(
                              text: TextSpan(
                                text: pengaduan.pengaduanStatus.name,
                                style: TextStyle(
                                  color: Colors.black,
                                  backgroundColor: backgroundColor,
                                ),
                              ),
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(pengaduan.title),
                                    content: SingleChildScrollView(
                                      controller: ScrollController(),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.network(pengaduan.image),
                                          Text('Title: ${pengaduan.title}'),
                                          Text(
                                              'Description: ${pengaduan.description}'),
                                          Text(
                                              'Location: ${pengaduan.location}'),
                                          RichText(
                                            text: TextSpan(
                                              text: pengaduan
                                                  .pengaduanStatus.name,
                                              style: TextStyle(
                                                color: Colors.black,
                                                backgroundColor:
                                                    backgroundColor,
                                              ),
                                            ),
                                          ),
                                          pengaduan.tanggapanImage != null
                                              ? Image.network(
                                                  pengaduan.tanggapanImage!)
                                              : SizedBox(),
                                          pengaduan.tanggapanDescription != null
                                              ? Text(
                                                  'Description: ${pengaduan.tanggapanDescription}')
                                              : SizedBox(),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Close'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
        );
      },
    );
  }
}
