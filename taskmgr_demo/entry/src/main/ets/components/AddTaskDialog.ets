import CommonConstants from '../common/constants/CommonConstants'
import Logger from '../common/utils/Logger'

type ConfirmBlock = (value: string) => void

@Component
@CustomDialog
export default struct AddTaskDialog {
  controller?: CustomDialogController
  onConfirm?: ConfirmBlock
  @State taskName: string = ''

  build() {
    Column({ space: 20 }) {
      Text('添加任务')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width(CommonConstants.FULL_WIDTH)

      TextInput({ placeholder: '输入任务名称' })
        .onChange((value) => {
          this.taskName = value
        })

      Row() {
        Button('取消')
          .onClick(() => {
            this.controller?.close()
          })

        Blank()

        Button('确定')
          .onClick(() => {
            Logger.info('点击确定添加', '任务名称: ' + this.taskName)
            if (this.onConfirm) {
              this.onConfirm(this.taskName)
            }
          })
      }
      .width(CommonConstants.FULL_WIDTH)
      .height('10%')
      .padding(20)
    }
    .width('90%')
    .padding(20)
    .backgroundColor(Color.White)
    .borderRadius(16)
  }
}