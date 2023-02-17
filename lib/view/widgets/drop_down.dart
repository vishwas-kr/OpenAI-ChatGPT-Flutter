import 'package:chat_gpt/models/openApiModel_model.dart';
import 'package:chat_gpt/provider/models_provider.dart';
import 'package:chat_gpt/utils/app_colors.dart';
import 'package:chat_gpt/view/widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDropDownButton extends StatefulWidget {
  const CustomDropDownButton({super.key});

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ModelProvider>(context, listen: false);
    String? currentModel = provider.currentModel;
    return FutureBuilder<List<OpenApiModel>>(
        future: provider.getAllModels(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return SizedBox(
              child: Text(snapshot.error.toString()),
            );
          }
          return snapshot.data == null || snapshot.data!.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : FittedBox(
                  child: DropdownButton(
                    dropdownColor: AppColors.backgroundColor,
                    iconEnabledColor: Colors.white,
                    items: List<DropdownMenuItem<String>>.generate(
                      snapshot.data!.length,
                      (index) => DropdownMenuItem(
                        value: snapshot.data![index].id,
                        child: CustomTextWidget(
                          label: snapshot.data![index].id,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    value: currentModel,
                    onChanged: (value) {
                      setState(() {
                        currentModel = value.toString();
                      });
                      provider.setCurrentModel(value.toString());
                    },
                  ),
                );
        });
  }
}
