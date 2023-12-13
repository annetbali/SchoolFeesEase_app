import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:school_fees_ease/utils/helpers.dart';
import '../Controllers/Students_controller.dart';
import '../core/state.dart';
import '../models/Student_model.dart';
import '../utils/colors.dart';
import 'widgets/app_button_widget.dart';
import 'widgets/text_field_widget.dart';

class StudentListPage extends ConsumerWidget {
  const StudentListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allStudentsState = ref.watch(allStudentsProvider);
    final studentCRUDState = ref.watch(studentCRUDProvider);
    ref.listen(studentCRUDProvider, (previous, next) async {
      if (next.status == Status.loaded) {
        ref.invalidate(allStudentsProvider);
      }
      if (next.status == Status.error) {
        Fluttertoast.cancel();
        Fluttertoast.showToast(
            msg: next.message ?? 'An error occurred !', timeInSecForIosWeb: 6);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
        actions: [
          allStudentsState.status == Status.loading ||
                  studentCRUDState.status == Status.loading
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
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: primaryColor,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AddStudentPage()));
          },
          label: const Text('Add Student', style: TextStyle(color: whiteColor)),
          icon: const Icon(Icons.add, color: whiteColor)),
      body: ListView.builder(
        itemCount: allStudentsState.data!.length,
        itemBuilder: (context, index) {
          final student = allStudentsState.data![index];
          return ListTile(
            trailing: IconButton(
                onPressed: () {
                  ref
                      .read(studentCRUDProvider.notifier)
                      .deleteStudent(id: student.id);
                },
                icon: const Icon(Icons.delete, color: Colors.red)),
            title: Text(student.name),
            subtitle: Text(student.address, maxLines: 1),
            onTap: () {
              // Navigate to a new page showing account details
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudentDetailsPage(student: student),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class StudentDetailsPage extends StatelessWidget {
  final StudentModel student;

  const StudentDetailsPage({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(student.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Level: ${student.level}'),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: Text('Student Number ${student.id}')),
                // const Spacer(),
                InkWell(
                    onTap: () => Helpers.copyToClipboard(context, student.id),
                    child: const Icon(Icons.copy))
              ],
            ),
            const SizedBox(height: 10),
            Text('Address: ${student.address}'),
          ],
        ),
      ),
    );
  }
}

class AddStudentPage extends ConsumerStatefulWidget {
  const AddStudentPage({super.key});

  @override
  ConsumerState<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends ConsumerState<AddStudentPage> {
  final TextEditingController classController = TextEditingController();

  final TextEditingController bankAccountNumberController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  bool showPassword = true;
  @override
  void dispose() {
    // TODO: implement dispose
    classController.dispose();
    bankAccountNumberController.dispose();
    nameController.dispose();
    addressController.dispose();

    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final studentCRUDState = ref.watch(studentCRUDProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
        actions: [
          studentCRUDState.status == Status.loading
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
                    label: 'Student Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Student name';
                      }
                      return null;
                    },
                    prefixIcon: const Icon(Icons.school),
                  ),
                  const SizedBox(height: 16.0),
                  TextFieldWidget(
                    controller: addressController,
                    label: 'Student Address',
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
                    controller: classController,
                    label: 'Student Class',
                    prefixIcon: const Icon(Icons.account_balance_sharp),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter student class';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  AppButtonWidget(
                      borderRadius: 15,
                      onTap: studentCRUDState.status == Status.loading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                ref
                                    .read(studentCRUDProvider.notifier)
                                    .addStudent(
                                        name: nameController.text,
                                        address: addressController.text,
                                        level: classController.text,);
                              }
                            },
                      child: const Text('Add Student',
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
