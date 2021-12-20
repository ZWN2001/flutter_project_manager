import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'folding_cell.dart';

class AllMyDemands extends StatelessWidget {
  final List<Map> demandsData;
  const AllMyDemands({
    Key? key,
    required this.demandsData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Set<int> openedIndices = {};
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "所有需求",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          if(demandsData.isEmpty)
            Center(
              child: Text(
                '暂无需求'
              ),
            ),
          if (demandsData.isNotEmpty)
            SizedBox(
              width: double.infinity,
              // height: double.infinity,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: demandsData.length,
                itemBuilder: (BuildContext context, int index) {
                  return FoldingCell(
                    key: ValueKey(index),
                    id: demandsData[index]['demand_id']??'',
                    taskStatus: demandsData[index]['status']??'',
                    taskPriority: demandsData[index]['priority']??'',
                    taskTitle: demandsData[index]['title']??'',
                    taskProject: demandsData[index]['project']??'',
                    taskCreater: demandsData[index]['cer']??'',
                    taskCreateTime: demandsData[index]['ctime']??'',
                    taskManager: demandsData[index]['doer']??'',
                    taskDeadLine: demandsData[index]['ddl']??'',
                    address: demandsData[index]['address']??'',
                    foldingState: openedIndices.contains(index)
                        ? FoldingState.open
                        : FoldingState.close,
                    onChanged: (foldState) {
                      if (foldState == FoldingState.open) {
                        // print('打开了 cell -- $index');
                        openedIndices.add(index);
                      } else {
                        // print('关闭了 cell -- $index');
                        openedIndices.remove(index);
                      }
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }


}