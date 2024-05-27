import CommonConstants from '../common/constants/CommonConstants';
import Logger from '../common/utils/Logger';

@Component
export default struct ProgressEdit {
  // 进度
  @Prop progress: number;
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
        Slider({
          value: this.progress,
          step: CommonConstants.SLIDER_STEP,
          style: SliderStyle.InSet
        })
          .width('80%')
          .onChange((value, mode) => {
            Logger.debug('进度发生变化', 'value: ' + value.toString())
            this.progress = Math.trunc(value)
            this.mode = mode
          })

        // 进度显示
        Text(`${this.progress}%`)
          .fontSize($r('sys.float.ohos_id_text_size_button1'))
          .fontColor($r('sys.color.ohos_id_text_color_active'))
      }
      .justifyContent(FlexAlign.Center)
      .width(CommonConstants.FULL_WIDTH)

      Row() {
        TextButton({ title: '取消' })
          .onClick(() => {
            Logger.debug('点击取消按钮', 'value: ' + this.progress.toString())
            if (this.onCancel) {
              this.onCancel()
            }
          })

        Blank()

        TextButton({ title: '确定' })
          .onClick(() => {
            Logger.debug('点击确定按钮', 'value: ' + this.progress.toString())
            if (this.onConfirm) {
              this.onConfirm(this.progress)
            }
          })
      }
      .width('75%')
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
      .width(96)
      .padding(5)
      .backgroundColor(this.bgColor)
      .borderRadius(10)
      .fontSize($r('sys.float.ohos_id_text_size_button1'))
      .fontColor($r('sys.color.ohos_id_text_color_active'))
      .textAlign(TextAlign.Center)
      .onTouch((e) => {
        this.bgColor = e.type == TouchType.Down ? $r('sys.color.ohos_id_picker_press_color') :
        $r('sys.color.ohos_id_color_button_normal')
      })
  }
}