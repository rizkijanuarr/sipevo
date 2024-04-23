import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/register_view.dart';

class RegisterController extends GetxController {
  RegisterView? view;

  var controllerName = TextEditingController();
  var controllerNohp = TextEditingController();
  var controllerEmail = TextEditingController();
  var controllerPass = TextEditingController();
  var controllerAddress = TextEditingController();

  var formKey = GlobalKey<FormState>();
}
