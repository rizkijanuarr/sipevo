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
                onPressed: () async {
                  await SharedPrefsHelper.removeToken();
                  Get.offAll(() => LoginView());
                },
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
              : ListView.builder(
                  itemCount: controller.pengaduanList.length,
                  itemBuilder: (context, index) {
                    var pengaduan = controller.pengaduanList[index];
                    return Card(
                      margin: EdgeInsets.all(10.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(pengaduan.image),
                        ),
                        title: Text(pengaduan.title),
                        subtitle: Text(pengaduan.description),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(pengaduan.title),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.network(pengaduan.image),
                                    Text('Title: ${pengaduan.title}'),
                                    Text(
                                        'Description: ${pengaduan.description}'),
                                    Text('Location: ${pengaduan.location}'),
                                    Text(
                                        'Status: ${pengaduan.pengaduanStatus.name}'),
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
