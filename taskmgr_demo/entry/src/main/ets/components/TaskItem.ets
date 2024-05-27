import CommonConstants from '../common/constants/CommonConstants';
import currentTime from '../common/utils/DateTime';
import Task from '../models/Task';
import ProgressEdit from './ProgressEdit';

@Component
export default struct TaskItem {
  // 任务列表
  @Link tasks: Task[];
  // 当前任务的索引
  index: number = 0;
  // 当前的任务
  @Prop task: Task;
  // 是否开启编辑模式
  @Prop isEditMode: boolean;
  // 是否展开面板
  @Prop isExpanded: boolean;
  // 最新的进度
  @State latestProgress?: number = CommonConstants.SLIDER_MIN_VALUE;
  // 最新的更新时间
  @State updateDate?: string = '';
  // 选中的任务列表
  @Link selectedTask: boolean[];
  // 进度变化
  @Consume progressChanged: boolean;

  aboutToAppear(): void {
    // 在组件显示前先从任务初始化数据
    this.updateDate = this.task.update
    this.latestProgress = this.task.progress
  }

  @Builder
  TaskInfo() {
    Row() {
      // 任务名称
      Text(this.task.name)
        .fontSize(16)
        .fontWeight(500)
        .fontColor('#182431')
        .width('30%')
        .textAlign(TextAlign.Start)
        .maxLines(2)
        .decoration({
          type: this.latestProgress === CommonConstants.SLIDER_MAX_VALUE ? TextDecorationType.LineThrough :
          TextDecorationType.None
        })

      Blank()

      // 进度 + 更新时间
      Column() {
        // 任务进度
        Text(`${this.latestProgress}%`)
          .fontSize(16)
          .fontWeight(500)
          .fontColor('#182431')

        // 更新时间
        Text(`最近更新: ${this.updateDate}`)
          .fontSize(12)
          .fontColor('#182431')
          .opacity(0.4)
          .fontWeight(500)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.End)
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopEnd }) {
      Column() {
        // 任务基本信息
        this.TaskInfo()

        // 进度编辑区域
        if (this.isExpanded) {
          Blank()

          ProgressEdit({
            progress: this.latestProgress,
            onCancel: () => {
              // 取消操作，将进度编辑区域折叠
              this.isExpanded = false
            },
            onConfirm: (value) => {
              // 确认操作，更新数据(通知上层刷新)
              this.updateDate = currentTime()
              this.latestProgress = value
              // 更新数据
              this.task.updateData(this.updateDate, this.latestProgress)
              this.tasks[this.index] = this.task
              // 通知进度发生变化
              this.progressChanged = !this.progressChanged
              // 将编辑区域折叠
              this.isExpanded = false
            }
          })
        }
      }
      .width(CommonConstants.FULL_WIDTH)
      .height(this.isExpanded ? 148 : 64)
      .opacity(this.latestProgress === 100 ? 0.6 : 1) // 完成的任务调整透明度
      .backgroundColor(this.selectedTask[this.index] ? '#1A007DFF' : Color.White)
      .borderRadius(24)
      .onClick(() => {
        // 展开折叠动画
        animateTo({ duration: 300 }, () => {
          this.isExpanded = !this.isExpanded
        })
      })
      .padding({
        left: 16,
        top: 14,
        right: this.isEditMode ? 54 : 16,
        bottom: 12
      })

      if (this.isEditMode) {
        Column() {
          Checkbox()
            .margin({ right: 16 })
            .width(20)
            .selectedColor('#007DFF')
            .select(this.selectedTask[this.index])
            .onChange((isChecked) => {
              this.selectedTask[this.index] = isChecked
            })
        }
        .height(CommonConstants.FULL_HEIGHT)
        .justifyContent(FlexAlign.Center)
      }
    }
    .width(CommonConstants.FULL_WIDTH)
    .height(this.isExpanded ? 148 : 64)
  }
}