import { promptAction, router } from '@kit.ArkUI';
import PreferencesManager from '../common/utils/PreferencesManager';
import RegisterDialog from '../components/RegisterDialog';

@Entry
@Component
struct Index {
  @State account: string = '';
  @State password: string = '';
  @State isLoading: boolean = false;
  @State timeOutId: number = -1;

  dialogController: CustomDialogController = new CustomDialogController({
    builder: RegisterDialog({
      cancel: () => {
        if (this.dialogController) {
          this.dialogController.close()
        }
      },
      confirm: (account, password) => {
        promptAction.showToast({ message: "注册成功" })
        if (this.dialogController) {
          this.dialogController.close()
        }
      },
    }),
    autoCancel: true,
    alignment: DialogAlignment.Bottom,
    offset: { dx: 0, dy: -20 },
    customStyle: false,
    cornerRadius: 10,
  })

  aboutToDisappear(): void {
    if (this.timeOutId !== -1) {
      clearTimeout(this.timeOutId);
    }
    this.timeOutId = -1;
  }

  build() {
    Column() {
      Image($r('app.media.logo'))
        .objectFit(ImageFit.Cover)
        .width(78)
        .height(78)
        .margin({ top: 100 })
        .borderRadius(8)

      Text('账号登录')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 40 })

      Text('登录账号以使用更多服务')
        .fontColor(Color.Gray)
        .margin({ top: 10 })

      Column() {
        TextInput({ placeholder: '账号' })
          .type(InputType.Normal)
          .height(60)
          .backgroundColor(Color.White)
          .onChange((value) => {
            this.account = value
          })
        Line()
          .lineStyle()

        TextInput({ placeholder: '密码' })
          .type(InputType.Password)
          .height(60)
          .backgroundColor(Color.White)
          .onChange((value) => {
            this.password = value
          })
        Line()
          .lineStyle()
      }
      .width('100%')
      .margin({ top: 40 })

      Row() {
        Text('短信验证码登录')
          .fontSize(14)
          .fontColor(Color.Orange)
          .padding({ left: 10 })

        Text('忘记密码')
          .fontSize(14)
          .fontColor(Color.Orange)
          .padding({ right: 10 })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .margin({ top: 10 })

      Button('登录')
        .backgroundColor(Color.Orange)
        .fontColor(Color.White)
        .width('90%')
        .margin({ top: 80 })
        .onClick(this.login.bind(this))
        .enabled(!this.isLoading)

      if (this.isLoading) {
        LoadingProgress()
          .color('#182431')
          .width(30)
          .height(30)
          .margin({ top: 20 })
      }

      Text('注册账号')
        .fontSize(14)
        .fontColor(Color.Orange)
        .margin({ top: 10 })
        .onClick(() => {
          if (this.dialogController != null) {
            this.dialogController.open()
          }
        })

      Blank()

      Column() {
        Text('其他登录方式')
          .fontColor(Color.Gray)
          .fontSize(14)
          .margin({ top: 10 })

        Row() {
          Button({ type: ButtonType.Circle }) {
            Image($r('app.media.huawei'))
              .objectFit(ImageFit.Cover)
              .width(44)
              .height(44)
          }
          .backgroundColor(Color.White)

          Button({ type: ButtonType.Circle }) {
            Image($r('app.media.wechat'))
              .objectFit(ImageFit.Cover)
              .width(44)
              .height(44)
          }
          .backgroundColor(Color.White)

          Button({ type: ButtonType.Circle }) {
            Image($r('app.media.weibo'))
              .objectFit(ImageFit.Cover)
              .width(44)
              .height(44)
          }
          .backgroundColor(Color.White)
        }
        .width('70%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ top: 16 })
      }
      .padding({ bottom: 20 })

    }
    .height('100%')
    .width('100%')
  }

  login(): void {
    if (this.account === '' || this.password === '') {
      promptAction.showToast({
        message: '账号或密码不能为空'
      })
      return
    }
    this.isLoading = true;
    if (this.timeOutId !== -1) {
      return
    }
    this.timeOutId = setTimeout(() => {
      this.isLoading = false;
      this.timeOutId = -1;
      let sp = new PreferencesManager(getContext(this), 'AppSettings')
      sp.setObject("LoginData", JSON.stringify({'account': this.account, 'password': this.password})).then(() => {
        router.replaceUrl({ url: 'pages/MainPage' });
      })
    }, 2000);
  }
}

@Extend(Line)
function lineStyle() {
  .width('100%')
  .height(1)
  .backgroundColor('#33182431')
}