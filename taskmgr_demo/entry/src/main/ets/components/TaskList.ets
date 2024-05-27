import Logger from '../common/utils/Logger'
import Task from '../models/Task'
import TaskItem from './TaskItem'

@Extend(Text)
function operateTextStyle(color: Resource | string) {
  .fontSize(16)
  .fontColor(color)
  .lineHeight(19)
  .fontWeight(FontWeight.Regular)
}

@Extend(Button)
function operateButtonStyle(color: Resource | string) {
  .fontSize(16)
  .fontColor(color)
  .fontWeight(FontWeight.Regular)
  .height(40)
  .width(156)
  .backgroundColor('#0D182431')
}

@Component
export default struct TaskList {
  // 任务列表
  @Link tasks: Task[];
  // 是否开启编辑模式
  @State isEditMode: boolean = false;
  // 选中的任务状态，并监听数据的变化情况
  @State @Watch('onSelectedTaskChanged') selectedTask: boolean[] = [];
  // 全选状态
  @State selectAll: boolean = false;
  // 点击添加按钮的回调处理
  onAddClick?: () => void;
  // 点击删除按钮的回调处理
  onDeleteClick?: (selectedTask: boolean[]) => void;

  build() {
    Column() {
      // 标题区域(标题 + 编辑按钮)
      this.titleView()

      // 任务列表
      this.listView()

      // 空白
      Blank()

      // 操作按钮
      this.bottomButton()
    }
    .width('93.3%')
    .height('100%')
    .padding({ top: 16 })
  }

  @Builder
  listView() {
    if (this.tasks.length > 0) {
      List({ space: 12 }) {
        ForEach(this.tasks, (item: Task, index: number) => {
          ListItem() {
            TaskItem({
              tasks: $tasks,
              index: index,
              task: item,
              isEditMode: this.isEditMode,
              selectedTask: this.selectedTask
            })
          }
        })
      }
      .edgeEffect(EdgeEffect.Spring)
      .margin({ top: 12 })
      .width('100%')
      .height('80%')
    } else {
      Column() {
        Image($r('app.media.empty_no_data'))
          .objectFit(ImageFit.Cover)
          .width(160)
          .height(140)

        Text('暂无任务，快去添加吧')
          .fontSize(14)
          .margin({ top: 10 })
      }
      .margin({ top: 60 })
      .width('100%')
      .height('80%')
    }
  }

  @Builder
  titleView() {
    Row() {
      Text('任务')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Blank()

      // 仅有任务数据的时候才需要显示编辑入口
      if (this.tasks.length > 0) {
        if (this.isEditMode) {
          // 取消按钮
          Text('取消')
            .operateTextStyle('#007DFF')
            .onClick(() => {
              // 关闭编辑模式
              this.isEditMode = false
              // 重置选中模式
              this.selectAll = false
              this.selectedTask = this.tasks.map(() => false)
              Logger.info('点击取消' + this.selectAll + ', ' + JSON.stringify(this.selectedTask))
            })

          // 全选按钮(文本 + checkbox)
          Text('全选')
            .operateTextStyle('#007DFF')
            .margin({ left: 20 })
            .onClick(() => {
              this.selectAll = !this.selectAll
              this.selectedTask = this.tasks.map(() => this.selectAll)
              Logger.info('点击全选文本' + this.selectAll + ', ' + JSON.stringify(this.selectedTask))
            })
          Checkbox()
            .select(this.selectAll)
            .selectedColor('#007DFF')
            .width(20)
            .onClick(() => {
              this.selectAll = !this.selectAll
              this.selectedTask = this.tasks.map(() => this.selectAll)
              Logger.info('点击全选按钮' + this.selectAll + ', ' + JSON.stringify(this.selectedTask))
            })

        } else {
          Text('编辑')
            .operateTextStyle('#007DFF')
            .onClick(() => {
              this.isEditMode = true
            })
        }
      }
    }
    .padding({ left: 16, right: 12 })
    .width('100%')
    .height(30)
  }

  @Builder
  bottomButton() {
    if (this.isEditMode) {
      Button('删除')
        .operateButtonStyle('#E84026')
        .onClick(() => {
          // 通知上层删除任务
          if (this.onDeleteClick) {
            this.onDeleteClick(this.selectedTask)
          }
          // 删除后退出编辑模式
          this.isEditMode = false
          // 重置选中模式
          this.selectAll = false
          this.selectedTask = this.tasks.map(() => false)
          Logger.info('点击删除' + this.selectAll + ', ' + JSON.stringify(this.selectedTask))
        })
    } else {
      Button('新增')
        .operateButtonStyle('#007DFF')
        .onClick(() => {
          if (this.onAddClick) {
            this.onAddClick()
          }
          Logger.info('点击新增')
        })
    }
  }

  onSelectedTaskChanged() {
    // 数量不一致表示之前没有点过全选/反选，这种情况下不需要处理
    if (this.selectedTask.length != this.tasks.length) {
      return
    }
    Logger.info('onSelectedTaskChanged', JSON.stringify(this.selectedTask))
    // 只要有一个没选中就需要关闭全选
    let allSelected = true
    for (let i = 0; i < this.selectedTask.length; i++) {
      let item = this.selectedTask[i]
      if (item == undefined || item == null || !item) {
        allSelected = false
        break
      }
    }
    this.selectAll = allSelected
  }
}