type ConfirmBlock = (value: string) => void

@Component
@CustomDialog
export default struct AddTaskDialog {
  controller? : CustomDialogController
  onConfirm?: ConfirmBlock
  @State taskName: string = ''

  build() {
    Column({space: 20}) {
      Text('添加任务')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      TextInput({placeholder: '输入任务名称'})
        .onChange((value) => {
          this.taskName = value
        })

      Row(){
        Button('取消')
          .onClick(() =>{
            this.controller?.close()
          })

        Blank()

        Button('确定')
          .onClick(() => {
            if (this.onConfirm) {
              this.onConfirm(this.taskName)
            }
          })
      }
      .padding(20)
      .width('100%')
      .height('10%')
    }
    .padding(20)
    .width('90%')
    .backgroundColor(Color.White)
    .borderRadius(16)
  }
}