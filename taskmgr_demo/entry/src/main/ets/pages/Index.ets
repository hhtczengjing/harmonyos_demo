import { Header } from '../common/components/Header';
import AddTaskDialog from '../components/AddTaskDialog';
import TaskList from '../components/TaskList';
import TaskOverview from '../components/TaskOverview';

@Entry
@Component
struct Index {

  // 新建任务弹框
  dialogController = new CustomDialogController({
    builder: AddTaskDialog({
      onConfirm: (value): void => this.saveTask(value)
    }),
    alignment: DialogAlignment.Bottom,
    offset: { dx: 0, dy: -20 },
    customStyle: true,
    autoCancel: false
  })

  saveTask(value: string) {

  }

  build() {
    Column() {
      // 标题
      Header('任务')

      // 进度概览
      TaskOverview()

      // 任务列表
      TaskList()
    }
    .height('100%')
    .width('100%')
  }
}