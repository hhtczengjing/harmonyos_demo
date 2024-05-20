import Constants from '../common/constants/Constants'
import ToDoItem from '../components/ToDoItem'

@Entry
@Component
export struct ToDoListPage {

  private totalTasks: string[] = Constants.DEFAULT_TODO_CATEGORIES

  build() {
    Column({space: 16}) {
      Text($r('app.string.todo_list_page_title'))
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .margin({left: 20, top: 20, right: 10, bottom: 0})
        .textAlign(TextAlign.Start)
        .width('80%')

      ForEach(this.totalTasks, (item: string) => {
        ToDoItem({content: item})
      })
    }
    .backgroundColor($r('app.color.todo_list_page_background'))
    .width(Constants.FULL_WIDTH)
    .height(Constants.FULL_HEIGHT)
  }
}