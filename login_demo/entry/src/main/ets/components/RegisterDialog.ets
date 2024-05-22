import { promptAction } from '@kit.ArkUI'

@Component
@CustomDialog
export default struct RegisterDialog {
  @State account: string = ''
  @State password: string = ''
  controller?: CustomDialogController
  cancel?: () => void
  confirm?: (account: string, password: string) => void

  build() {
    Column({ space: 10 }) {
      Text('注册账号')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .textAlign(TextAlign.Start)

      TextInput({ placeholder: '账号' })
        .type(InputType.Normal)
        .onChange((value) => {
          this.account = value
        })
        .margin({ top: 15 })

      TextInput({ placeholder: '密码' })
        .type(InputType.Password)
        .onChange((value) => {
          this.password = value
        })
        .margin({ top: 10 })

      Row() {
        Button('取消')
          .onClick(() => {
            if (this.cancel) {
              this.cancel()
            }
          })

        Blank()

        Button('确定')
          .onClick(() => {
            if (this.account.length <= 0 || this.password.length <= 0) {
              promptAction.showToast({message: "请输入用户名或密码"})
              return
            }
            if (this.confirm) {
              this.confirm(this.account, this.password)
            }
          })
      }
      .padding(20)
      .width('100%')
      .height(80)
    }
    .padding(20)
  }
}