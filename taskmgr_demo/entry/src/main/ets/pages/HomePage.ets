import { Header } from '../common/components/Header';
import currentTime from '../common/utils/DateTime';
import AddTaskDialog from '../components/AddTaskDialog';
import TaskList from '../components/TaskList';
import TaskOverview from '../components/TaskOverview';
import Task from '../models/Task';
import Tasks from '../models/Tasks';
import { promptAction } from '@kit.ArkUI';
import CommonConstants from '../common/constants/CommonConstants';

@Entry
@Component
struct HomePage {

  // 所有的任务列表
  @State tasks: Task[] = Tasks.allTaskData;
  // 任务总数
  @State totalCount: number = 0;
  // 完成的任务数量
  @State completedCount: number = 0;
  // 最近更新时间
  @State latestUpdateDate: string = '--';
  // 状态变化监听
  @Provide @Watch('onProgressChanged') progressChanged: boolean = false;

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
    if (value === '') {
      promptAction.showToast({
        message: "任务名称不能为空!",
        duration: 2000
      })
      return
    }
    // 新增一条数据
    Tasks.add(new Task(value, currentTime(), 0))
    // 刷新数据
    this.reloadData()
    // 关闭弹框
    this.dialogController.close()
  }

  aboutToAppear(): void {
    this.tasks = Tasks.allTaskData
    this.totalCount = this.tasks.length
    this.completedCount = this.tasks.filter((task) => {
      return task.progress == CommonConstants.SLIDER_MAX_VALUE;
    }).length
  }

  reloadData(): void {
    this.tasks = Tasks.allTaskData
    this.totalCount = this.tasks.length
    this.completedCount = this.tasks.filter((task) => {
      return task.progress == CommonConstants.SLIDER_MAX_VALUE;
    }).length
    this.latestUpdateDate = currentTime()
  }

  build() {
    Column() {
      // 标题
      Header('任务管理')

      // 进度概览
      TaskOverview({
        totalCount: this.totalCount,
        completedCount: this.completedCount,
        updateAt: this.latestUpdateDate
      })

      // 任务列表
      TaskList({
        tasks: $tasks,
        onAddClick: () => {
          this.dialogController.open()
        },
        onDeleteClick: (selectedTasks: boolean[]) => {
          // 删除数据
          Tasks.delete(selectedTasks)
          // 重新获取全部任务
          this.reloadData()
        }
      })
        .height('60%')
    }
    .width(CommonConstants.FULL_WIDTH)
    .height(CommonConstants.FULL_HEIGHT)
    .backgroundColor('#F1F3F5')
  }

  onProgressChanged() {
    this.reloadData()
  }
}