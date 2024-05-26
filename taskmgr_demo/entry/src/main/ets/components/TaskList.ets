import Task from '../models/Task'
import TaskItem from './TaskItem'

@Extend(Text)
function operateTextStyle(color: Resource|string) {
  .fontSize(16)
  .fontColor(color)
  .lineHeight(19)
  .fontWeight(FontWeight.Regular)
}

@Extend(Button)
function operateButtonStyle(color: Resource|string) {
  .fontSize(16)
  .fontColor(color)
  .fontWeight(FontWeight.Regular)
  .height(40)
  .width(156)
  .backgroundColor('#0D182431')
}

@Component
export default struct TaskList {
  @Link tasks: Task[];
  @State isEditMode: boolean = false;
  onAddClick?: () => void;
  @State selectedTask: boolean[] = []

  build() {
    Column() {
      // 标题区域(标题 + 编辑按钮)
      Row() {
        Text('任务')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)

        Blank()

        // 仅有任务数据的时候才需要显示编辑入口
        if (this.tasks.length > 0) {
          if (this.isEditMode) {
            Text('取消')
              .operateTextStyle('#007DFF')
              .onClick(() => {
                this.isEditMode = false
              })

            Text('全选')
              .operateTextStyle('#007DFF')
              .margin({left: 20})
            Checkbox()
              .width(20).onClick(() => {

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
      .padding({left: 16, right: 12})
      .width('100%')
      .height(30)

      // 任务列表
      List({space: 12}) {
        ForEach(this.tasks, (item: Task, index: number) => {
          ListItem() {
            TaskItem({
              index: index,
              task: item,
              isEditMode: this.isEditMode,
              selectedTask: this.selectedTask
            })
          }
        })
      }
      .edgeEffect(EdgeEffect.Spring)
      .margin({top: 12})
      .width('100%')
      .height('80%')

      Blank()

      // 操作按钮
      if (this.isEditMode) {
        Button('删除')
          .operateButtonStyle('#E84026')
          .onClick(() => {

          })
      } else {
        Button('新增')
          .operateButtonStyle('#007DFF')
          .onClick(() => {
            if (this.onAddClick) {
              this.onAddClick()
            }
          })
      }
    }
    .width('93.3%')
    .height('100%')
    .padding({top: 16})
  }
}