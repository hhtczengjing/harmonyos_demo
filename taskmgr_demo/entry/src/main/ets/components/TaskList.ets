import currentTime from '../common/utils/DateTime'
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
function operateButtonStyle() {
  .fontSize(16)
  .fontColor(Color.Blue)
  .fontWeight(FontWeight.Regular)
  .height(44)
  .width(80)
  .backgroundColor(Color.Gray)
}

@Component
export default struct TaskList {
  @Link tasks: Task[];
  @State isEditMode: boolean = false;
  onAddClick?: () => void;

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
        ForEach(this.tasks, (item: Task) => {
          ListItem() {
            TaskItem({
              task: item,
              isEditMode: this.isEditMode
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
          .operateButtonStyle()
          .onClick(() => {

          })
      } else {
        Button('新增')
          .operateButtonStyle()
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