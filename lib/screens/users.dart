import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:school_fees_ease/utils/colors.dart';

import '../Controllers/schools_controller.dart';
import '../Controllers/user_controller.dart';
import '../core/state.dart';
import '../models/user_model.dart';
import 'widgets/app_button_widget.dart';
import 'widgets/text_field_widget.dart';

class UserListPage extends ConsumerWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allUsersState = ref.watch(allUsersProvider);
    final updateUserState = ref.watch(updateUserProvider);
    ref.listen(updateUserProvider, (previous, next) async {
      if (next.status == Status.loaded) {
        Navigator.of(context).pop();
        ref.invalidate(allUsersProvider);
        Fluttertoast.cancel();
        Fluttertoast.showToast(
            msg: next.data ?? 'User updated', timeInSecForIosWeb: 6);
      }
      if (next.status == Status.error) {
        Fluttertoast.cancel();
        Fluttertoast.showToast(
            msg: next.message ?? 'An error occurred !', timeInSecForIosWeb: 6);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          allUsersState.status == Status.loading ||
                  updateUserState.status == Status.loading
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
      body: ListView.builder(
        itemCount: allUsersState.data!.length,
        itemBuilder: (context, index) {
          final user = allUsersState.data![index];
          return ListTile(
            // trailing: IconButton(
            //     onPressed: () {
            //       ref
            //           .read(schoolCRUDProvider.notifier)
            //           .deleteSchool(id: user.id);
            //     },
            //     icon: const Icon(Icons.delete, color: Colors.red)),
            isThreeLine: true,
            title: Text(user.name),
            subtitle:
                Text('${user.email} (${user.userRole.name})', maxLines: 1),
            onTap: () {
              // Navigate to a new page showing account details
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDetailsPage(user: user),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class UserDetailsPage extends ConsumerWidget {
  final UserModel user;

  const UserDetailsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${user.id}'),
            const SizedBox(height: 10),
            Text('Email: ${user.email}'),
            const SizedBox(height: 10),
            Text('Phone: ${user.contact}'),
            const SizedBox(height: 20),
            DropDownWidget(
              onChanged: (value) {
                ref
                    .read(updateUserProvider.notifier)
                    .updateUser(user.copyWith(userRole: value));
              },
              value: user.userRole,
              items: UserRole.values
                  .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                  .toList(),
              // prefixIcon: const Icon(Icons.money_rounded),
            ),
            // Text('Role: ${user.userRole.name}'),
          ],
        ),
      ),
    );
  }
}

class UpdateUserPage extends ConsumerStatefulWidget {
  const UpdateUserPage({super.key});

  @override
  ConsumerState<UpdateUserPage> createState() => _AddSchoolPageState();
}

class _AddSchoolPageState extends ConsumerState<UpdateUserPage> {
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
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
                        return 'Please user name';
                      }
                      return null;
                    },
                    prefixIcon: const Icon(Icons.person),
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
                      child: const Text('Add User',
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
