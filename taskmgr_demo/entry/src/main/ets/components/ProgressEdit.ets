import Logger from '../common/utils/Logger';

@Component
@Entry
export default struct ProgressEdit {
  // 进度
  @Prop progress: number = 20;
  // 点击取消的回调
  onCancel?: () => void;
  // 点击确定的回调
  onConfirm?: (value: number) => void;
  // 滑动模式
  @State mode: number = 1

  build() {
    Column() {
      Row() {
        // 进度滑块
        Slider({ value: this.progress, step: 1, style: SliderStyle.InSet })
          .width('80%')
          .onChange((value, mode) => {
            Logger.debug('进度发生变化', value.toString())
            this.progress = Math.trunc(value)
            this.mode = mode
          })

        // 进度显示
        Text(`${this.progress}%`)
          .fontSize($r('sys.float.ohos_id_text_size_button1'))
          .fontColor($r('sys.color.ohos_id_text_color_active'))
      }
      .justifyContent(FlexAlign.Center)
      .width('100%')

      Row() {
        TextButton({title: '取消'})
          .onClick(() => {
            Logger.debug('点击取消按钮')
            if (this.onCancel) {
              this.onCancel()
            }
          })

        Blank()

        TextButton({title: '确定'})
          .onClick(() => {
            Logger.debug('点击确定按钮', this.progress.toString())
            if (this.onConfirm) {
              this.onConfirm(this.progress)
            }
          })
      }
      .width('70%')
      .padding(10)
    }
  }
}

@Component
struct TextButton {
  title: Resource | string = '测试'
  @State bgColor: ResourceColor = $r('sys.color.ohos_id_color_button_normal')

  build() {
    Text(this.title)
      .backgroundColor(this.bgColor)
      .borderRadius(10)
      .fontSize($r('sys.float.ohos_id_text_size_button1'))
      .fontColor($r('sys.color.ohos_id_text_color_active'))
      .width(96)
      .textAlign(TextAlign.Center)
      .padding(5)
      .onTouch((e) => {
        this.bgColor = e.type == TouchType.Down ? $r('sys.color.ohos_id_picker_press_color') : $r('sys.color.ohos_id_color_button_normal')
      })
  }
}