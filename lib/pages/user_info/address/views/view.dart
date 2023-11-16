import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyskart/core/constants/colors.dart';
import 'package:toyskart/global/app_back_button.dart';
import 'package:toyskart/pages/user_info/address/controller.dart';

class ModifyAddress extends GetView<AddressListController> {
  const ModifyAddress({super.key});

  @override
  Widget build(BuildContext context) {
    var body = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Form(
          key: controller.formkey,
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: controller.fullName,

                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: ColorConst.black),
                    //autofocus: true,
                    validator: (input) =>
                        input!.isEmpty ? 'Please Enter Your Full Name' : null,

                    decoration: InputDecoration(
                        isDense: true,
                        prefix: const SizedBox(
                          width: 15,
                        ),
                        contentPadding: const EdgeInsets.only(
                            top: 14, right: 14, bottom: 14),
                        hintText: 'Full Name',
                        helperStyle: TextStyle(
                          color: ColorConst.black.withOpacity(0.8),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        hintStyle: TextStyle(
                          color: ColorConst.black.withOpacity(0.8),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: ColorConst.black),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: ColorConst.black),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: ColorConst.black),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        fillColor: Colors.transparent,
                        filled: true),
                  )),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: controller.address1,
                    maxLength: 100,
                    maxLines: 3,
                    minLines: 1,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: ColorConst.black),
                    //autofocus: true,
                    validator: (input) =>
                        input!.isEmpty ? 'Please Enter Address Line 1' : null,

                    decoration: InputDecoration(
                        isDense: true,
                        prefix: const SizedBox(
                          width: 15,
                        ),
                        contentPadding: const EdgeInsets.only(
                            top: 14, right: 14, bottom: 14),
                        hintText: 'Address Line 1',
                        helperStyle: TextStyle(
                          color: ColorConst.black.withOpacity(0.8),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        hintStyle: TextStyle(
                          color: ColorConst.black.withOpacity(0.8),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: ColorConst.black),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: ColorConst.black),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: ColorConst.black),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        fillColor: Colors.transparent,
                        filled: true),
                  )),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: controller.address2,
                    maxLength: 50,
                    maxLines: 3,
                    minLines: 1,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    style: const TextStyle(color: ColorConst.black),
                    validator: (input) =>
                        input!.isEmpty ? 'Address Line 2' : null,
                    decoration: InputDecoration(
                        isDense: true,
                        prefix: const SizedBox(
                          width: 15,
                        ),
                        contentPadding: const EdgeInsets.only(
                            top: 14, right: 14, bottom: 14),
                        hintText: 'Address Line 2',
                        helperStyle: TextStyle(
                          color: ColorConst.black.withOpacity(0.8),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        hintStyle: TextStyle(
                          color: ColorConst.black.withOpacity(0.8),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: ColorConst.black),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: ColorConst.black),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: ColorConst.black),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        fillColor: Colors.transparent,
                        filled: true),
                  )),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: controller.landMark,
                    maxLength: 100,
                    maxLines: 3,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: ColorConst.black),
                    decoration: InputDecoration(
                        isDense: true,
                        prefix: const SizedBox(
                          width: 15,
                        ),
                        contentPadding: const EdgeInsets.only(
                            top: 14, right: 14, bottom: 14),
                        hintText: 'Directions to reach / Landmark (optional)',
                        helperStyle: TextStyle(
                          color: ColorConst.black.withOpacity(0.8),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        hintStyle: TextStyle(
                          color: ColorConst.black.withOpacity(0.8),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        //alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: ColorConst.black),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: ColorConst.black),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: ColorConst.black),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        fillColor: Colors.transparent,
                        filled: true),
                  )),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: controller.city,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    style: const TextStyle(color: ColorConst.black),
                    validator: (input) =>
                        input!.isEmpty ? 'Please Enter The City Name' : null,
                    decoration: InputDecoration(
                        isDense: true,
                        prefix: const SizedBox(
                          width: 15,
                        ),
                        contentPadding: const EdgeInsets.only(
                            top: 14, right: 14, bottom: 14),
                        hintText: 'City',
                        helperStyle: TextStyle(
                          color: ColorConst.black.withOpacity(0.8),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        hintStyle: TextStyle(
                          color: ColorConst.black.withOpacity(0.8),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        //alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: ColorConst.black),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: ColorConst.black),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: ColorConst.black),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        fillColor: Colors.transparent,
                        filled: true),
                  )),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: controller.state,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: ColorConst.black),
                    textCapitalization: TextCapitalization.words,
                    validator: (input) =>
                        input!.isEmpty ? 'Please Enter The State Name' : null,
                    decoration: InputDecoration(
                        isDense: true,
                        prefix: const SizedBox(
                          width: 15,
                        ),
                        contentPadding: const EdgeInsets.only(
                            top: 14, right: 14, bottom: 14),
                        hintText: 'State',
                        helperStyle: TextStyle(
                          color: ColorConst.black.withOpacity(0.8),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        hintStyle: TextStyle(
                          color: ColorConst.black.withOpacity(0.8),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        //alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: ColorConst.black),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: ColorConst.black),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: ColorConst.black),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        fillColor: Colors.transparent,
                        filled: true),
                  )),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: controller.pinCode,
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: ColorConst.black),
                    validator: (input) =>
                        input!.isEmpty ? 'Please Enter The Pincode' : null,
                    decoration: InputDecoration(
                        isDense: true,
                        prefix: const SizedBox(
                          width: 15,
                        ),
                        contentPadding: const EdgeInsets.only(
                            top: 14, right: 14, bottom: 14),
                        hintText: 'Pincode',
                        helperStyle: TextStyle(
                          color: ColorConst.black.withOpacity(0.8),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        hintStyle: TextStyle(
                          color: ColorConst.black.withOpacity(0.8),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        //alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: ColorConst.black),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: ColorConst.black),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: ColorConst.black),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        fillColor: Colors.transparent,
                        filled: true),
                  )),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: controller.mobile,
                    maxLength: 10,

                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: ColorConst.black),
                    //autofocus: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (s) {
                      s = s ?? '';
                      if (s.trim().isEmpty) {
                        return 'Please Enter Mobile Number';
                      }
                      if (!s.contains(RegExp(r'^\+*[0-9]+$'))) {
                        return 'Please Vaild Enter Mobile Number';
                      }
                      return null;
                    },

                    decoration: InputDecoration(
                        isDense: true,
                        prefix: const SizedBox(
                          width: 15,
                        ),
                        contentPadding: const EdgeInsets.only(
                            top: 14, right: 14, bottom: 14),
                        hintText: 'Mobile Number',
                        helperStyle: TextStyle(
                          color: ColorConst.black.withOpacity(0.8),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        hintStyle: TextStyle(
                          color: ColorConst.black.withOpacity(0.8),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: ColorConst.black),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: ColorConst.black),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: ColorConst.black),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        fillColor: Colors.transparent,
                        filled: true),
                  )),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: controller.alternateMobile,
                    maxLength: 10,

                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: ColorConst.black),
                    //autofocus: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (s) {
                      s = s ?? '';
                      if (s.trim().isEmpty) {
                        return 'Please Enter Alternate Mobile Number';
                      }
                      if (!s.contains(RegExp(r'^\+*[0-9]+$'))) {
                        return 'Please Vaild Enter Alternate Mobile Number';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        isDense: true,
                        prefix: const SizedBox(
                          width: 15,
                        ),
                        contentPadding: const EdgeInsets.only(
                            top: 14, right: 14, bottom: 14),
                        hintText: 'Alternate Mobile Number',
                        helperStyle: TextStyle(
                          color: ColorConst.black.withOpacity(0.8),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        hintStyle: TextStyle(
                          color: ColorConst.black.withOpacity(0.8),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: ColorConst.black),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: ColorConst.black),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: ColorConst.black),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        fillColor: Colors.transparent,
                        filled: true),
                  )),
              Obx(
                () => Row(
                  children: [
                    Checkbox(
                      checkColor: ColorConst.white,
                      fillColor: MaterialStateProperty.all(
                        ColorConst.primary.withOpacity(1),
                      ),
                      value: controller.isSelected.value,
                      onChanged: (v) {
                        controller.isSelected.value = v ?? false;
                        controller.update();
                      },
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Wrap(
                        children: [
                          Text(
                            "Default address",
                            style: TextStyle(
                              color: ColorConst.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, top: 10.0, right: 10.0, bottom: 5.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConst.primary,
                      elevation: 0,
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0)),
                    ),
                    child: Text(
                      controller.isEditToogle
                          ? 'Update Address'
                          : 'Add Address',
                      style: const TextStyle(
                        fontSize: 16,
                        color: ColorConst.white,
                      ),
                    ),
                    onPressed: () async {
                      controller.isEditToogle
                          ? controller.updateAddress()
                          : controller.addAddress();
                    }),
              ),
            ],
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: ColorConst.background,
      appBar: AppBar(
        backgroundColor: ColorConst.primary,
        centerTitle: true,
        leading: const AppBackButton(),
        title: Text(controller.isEditToogle ? 'Edit Address' : 'Add Address'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          decoration: const BoxDecoration(
              // image: DecorationImage(
              //   image: AssetImage(AssetConst.loginBgtop),
              //   fit: BoxFit.cover,
              // ),
              ),
          child: SafeArea(
            child: body,
          ),
        ),
      ),
    );
  }
}
