
import 'package:flutter/material.dart';
import 'package:tasks/model/task_model.dart';
import 'package:tasks/services/my_services_firestore.dart';
import 'package:tasks/ui/general/colors.dart';
import 'package:tasks/ui/widgets/buttoon_normal_widget.dart';
import 'package:tasks/ui/widgets/general_widget.dart';
import 'package:tasks/ui/widgets/textfield_normal_widget.dart';

class TaskFormWidget extends StatefulWidget {
  const TaskFormWidget({super.key});
  
  @override
  State<TaskFormWidget> createState() => _TaskFormWidgetState();
  }

  class _TaskFormWidgetState extends State<TaskFormWidget>{

    final formkey = GlobalKey<FormState>();
    MyServicesFireStore taskService = MyServicesFireStore(collection: "tasks");
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _descriptionController = TextEditingController();
    final TextEditingController _dateController = TextEditingController();

    String categorySelect = "Personal";

    showSelectDate() async {
      DateTime? dateTime = await showDatePicker(
        context: context, 
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2030),
        cancelText: "Cancelar",
        confirmText: "Aceptar",
        helpText: "Seleccionar Fecha",
        builder: (BuildContext context, Widget? widget){
          return Theme(
            data: ThemeData.dark().copyWith(
              dialogBackgroundColor: Colors.white,
              dialogTheme: DialogTheme(
                elevation: 0,
                backgroundColor: kBrandSecondColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.0),
                ),
              ),
              colorScheme: ColorScheme.light(
                primary: kBrandPrimaryColor,
              ),
            ), 
            child: widget!,
            );
          },
        );

        if(DateTime != null){
          _dateController.text = dateTime.toString().substring(0, 10);
          setState(() {});
        }
    }

    registerTask(){
    if(formkey.currentState!.validate()){

      TaskModel taskModel = TaskModel(
        title: _titleController.text, 
        description: _descriptionController.text, 
        date: _dateController.text, 
        category: categorySelect, 
        status: true,
        );
        taskService.addTask(taskModel).then((value){
          if(value.isNotEmpty){
            
            Navigator.pop(context);
            showSnackBarSuccess(context, "La tarea fue registrada con exito");
          }
        }).catchError((error){
            showSnackBarError(context, "Hubo un error, Intente de nuevo");
            Navigator.pop(context);
        });                
      }
    }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(14.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(22.0),
            topRight: Radius.circular(22.0),
            ),
        ),
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Agregar tarea",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0,
                    ),
                  ),
                  divider10(),
                  TextFieldNormalWidget(
                    hintText: "Titulo",
                    icon: Icons.text_fields,
                    controller: _titleController,
                  ),
                  divider10(),
                  TextFieldNormalWidget(
                    hintText: "Descripcioon", 
                    icon: Icons.description,
                    controller: _descriptionController,
                  ),
        
                  divider10(),
                  const Text("Categoria: "),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    runAlignment: WrapAlignment.start,
                    spacing: 10.0,
                    children: [
                    FilterChip(
                    selected: categorySelect == "Personal",
                    backgroundColor: kBrandSecondColor,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    selectedColor: categoryColor[categorySelect],
                    checkmarkColor: Colors.white,
                    labelStyle: TextStyle(
                      color: categorySelect == "Personal"? Colors.white : kBrandPrimaryColor,
                    ),
                    label: Text("Personal"), 
                    onSelected: (bool value){
                      categorySelect = "Personal";
                      setState(() {});
                    },
                     ),
        
                    FilterChip(
                    selected: categorySelect == "Trabajo",
                    backgroundColor: kBrandSecondColor,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    selectedColor: categoryColor["Trabajo"],
                    checkmarkColor: Colors.white,
                    labelStyle: TextStyle(
                      color: categorySelect == "Trabajo"? Colors.white : kBrandPrimaryColor,
                    ),
                    label: Text("Trabajo"), 
                    onSelected: (bool value){
                      categorySelect = "Trabajo";
                      setState(() {});
                    },
                     ),
        
                    FilterChip(
                    selected: categorySelect == "Otro",
                    backgroundColor: kBrandSecondColor,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    selectedColor: categoryColor["Otro"],
                    checkmarkColor: Colors.white,
                    labelStyle: TextStyle(
                      color: categorySelect == "Otro"? Colors.white : kBrandPrimaryColor,
                    ),
                    label: Text("Otro"), 
                    onSelected: (bool value){
                      categorySelect = "Otro";
                      setState(() {});
                    },
                     ),
                     
                    ],
                  ),
                  divider10(),
                  TextFieldNormalWidget(
                    hintText: "Fecha", 
                    icon: Icons.date_range,
                    onTap: (){
                      showSelectDate();
                      },
                    controller: _dateController,
                    ),
                    divider20(),
                  ButtonNormalWidget(
                    onPressed: (){
                      registerTask();
                    },
                  ),
              ],
            ),
        ),
        );
  }
}