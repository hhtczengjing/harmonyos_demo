import CommonConstants from '../common/constants/CommonConstants';
import { promptAction, router } from '@kit.ArkUI';
import { NaviBar } from '../common/components/NaviBar';

export interface IMenuItem {
  icon: ResourceStr
  title: ResourceStr
  url?: string
}

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @State settings: IMenuItem[] = [
    { icon: $r('app.media.ic_app_management'), title: '应用管理' },
    { icon: $r('app.media.ic_storage'), title: '存储空间' },
    { icon: $r('app.media.ic_privacy'), title: '个人隐私' },
    { icon: $r('app.media.ic_setting_the_font_size'), title: '字体大小', url: 'pages/FontSizeSettingPage' }
  ]

  build() {
    Column() {
      NaviBar({
        title: '设置',
        hasLeftIcon: false
      })

      List() {
        ForEach(this.settings, (item: IMenuItem) => {
          ListItem() {
            Row() {
              Image(item.icon)
                .width(24)
                .height(24)
                .objectFit(ImageFit.Cover)

              Text(item.title)
                .textAlign(TextAlign.Start)
                .margin({ left: 10 })

              Blank()
            }
            .width(CommonConstants.FULL_WIDTH)
            .height(56)
          }
          .onClick(() => {
            if (!item.url) {
              promptAction.showToast({
                message: '正在研发中...',
                duration: 1500
              })
            }
            router.pushUrl({
              url: item.url
            })
          })
        })
      }
      .divider({
        strokeWidth: 0.5,
        startMargin: 24,
        endMargin: 0,
        color: '#E3E6ED'
      })
      .padding({ left: 16 })
    }
    .height(CommonConstants.FULL_HEIGHT)
    .width(CommonConstants.FULL_WIDTH)
    .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
  }
}