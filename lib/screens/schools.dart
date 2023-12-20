import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:school_fees_ease/utils/colors.dart';

import '../Controllers/schools_controller.dart';
import '../Controllers/user_controller.dart';
import '../core/state.dart';
import '../models/school_model.dart';
import '../models/user_model.dart';
import 'widgets/app_button_widget.dart';
import 'widgets/text_field_widget.dart';

class SchoolListPage extends ConsumerWidget {
  const SchoolListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allSchoolsState = ref.watch(allSchoolsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Schools in Uganda'),
        actions: [
          allSchoolsState.status == Status.loading
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
                )
              : Container()
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //     backgroundColor: primaryColor,
      //     onPressed: () {
      //       Navigator.of(context).push(
      //           MaterialPageRoute(builder: (context) => const AddSchoolPage()));
      //     },
      //     label: const Text('Add School', style: TextStyle(color: whiteColor)),
      //     icon: const Icon(Icons.add, color: whiteColor)),
      body: ListView.builder(
        itemCount: allSchoolsState.data!.length,
        itemBuilder: (context, index) {
          final school = allSchoolsState.data![index];
          return ListTile(
            trailing: (ref.watch(userProvider).data!.userRole !=
                    UserRole.parent) ?IconButton(
                onPressed: () {
                  ref
                      .read(schoolCRUDProvider.notifier)
                      .deleteSchool(id: school.id);
                },
                icon: const Icon(Icons.delete, color: Colors.red)):null,
            title: Text(school.name),
            subtitle: Text(school.address, maxLines: 1),
            onTap: () {
              // Navigate to a new page showing account details
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SchoolDetailsPage(school: school),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class SchoolDetailsPage extends StatelessWidget {
  final SchoolModel school;

  const SchoolDetailsPage({super.key, required this.school});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(school.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bank: ${school.bankName}'),
            const SizedBox(height: 10),
            Text('Account Number: ${school.accountNumber}'),
            const SizedBox(height: 10),
            Text('Address: ${school.address}'),
          ],
        ),
      ),
    );
  }
}

class AddSchoolPage extends ConsumerStatefulWidget {
  const AddSchoolPage({super.key});

  @override
  ConsumerState<AddSchoolPage> createState() => _AddSchoolPageState();
}

class _AddSchoolPageState extends ConsumerState<AddSchoolPage> {
  final TextEditingController bankNameController = TextEditingController();

  final TextEditingController bankAccountNumberController =
      TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  bool showPassword = true;
  @override
  void dispose() {
    // TODO: implement dispose
    bankNameController.dispose();
    bankAccountNumberController.dispose();
    nameController.dispose();
    addressController.dispose();

    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final schoolCRUDState = ref.watch(schoolCRUDProvider);
    ref.listen(schoolCRUDProvider, (previous, next) async {
      if (next.status == Status.loaded) {
        ref.invalidate(allSchoolsProvider);
        Navigator.of(context).pop();
      }
      if (next.status == Status.error) {
        Fluttertoast.cancel();
        Fluttertoast.showToast(
            msg: next.message ?? 'An error occurred !', timeInSecForIosWeb: 6);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add School'),
        actions: [
          schoolCRUDState.status == Status.loading
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
                )
              : Container()
        ],
      ),
      body: Container(
        // decoration: BoxDecoration(
        //   color: Color.fromRGBO(8, 8, 0,
        //       0.5), // Transparent white (adjust the alpha value as needed)
        // ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFieldWidget(
                    controller: nameController,
                    label: 'Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please school name';
                      }
                      return null;
                    },
                    prefixIcon: const Icon(Icons.school),
                  ),
                  const SizedBox(height: 16.0),
                  TextFieldWidget(
                    controller: addressController,
                    label: 'Address',
                    prefixIcon: const Icon(Icons.location_city),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFieldWidget(
                    controller: bankNameController,
                    label: 'Bank Name',
                    prefixIcon: const Icon(Icons.account_balance_sharp),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter bank name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFieldWidget(
                    controller: bankAccountNumberController,
                    label: 'bank Account Number',
                    prefixIcon: const Icon(Icons.money_rounded),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter back account name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  AppButtonWidget(
                      borderRadius: 15,
                      onTap: schoolCRUDState.status == Status.loading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                // signUp(
                                //   bankNameController.text,
                                //   bankAccountNumberController.text,
                                //   nameController.text,
                                //   addressController.text,
                                // );
                                ref.read(schoolCRUDProvider.notifier).addSchool(
                                    name: nameController.text,
                                    address: addressController.text,
                                    bankName: bankNameController.text,
                                    accountNumber:
                                        bankAccountNumberController.text);
                              }
                            },
                      child: const Text('Add School',
                          style: TextStyle(color: whiteColor))),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
