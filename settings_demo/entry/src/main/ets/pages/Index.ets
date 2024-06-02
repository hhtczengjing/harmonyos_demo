import CommonConstants from '../common/constants/CommonConstants';
import { promptAction, router } from '@kit.ArkUI';
import { NaviBar } from '../common/components/NaviBar';
import { PreferencesManager } from '../common/utils/PreferencesManager';

export interface IMenuItem {
  icon: ResourceStr
  title: ResourceStr
  url?: string
}

@Entry
@Component
struct Index {
  @State fontSize: number = 16;
  @State settings: IMenuItem[] = [
    { icon: $r('app.media.ic_app_management'), title: '应用管理' },
    { icon: $r('app.media.ic_storage'), title: '存储空间' },
    { icon: $r('app.media.ic_privacy'), title: '个人隐私' },
    { icon: $r('app.media.ic_setting_the_font_size'), title: '字体大小', url: 'pages/FontSizeSettingPage' }
  ]

  // 使用onPageShow可以保证设置完成后再次进入页面刷新数据
  onPageShow(): void {
    PreferencesManager.sharedManager().getValue("FontSize", 16).then((value) => {
      this.fontSize = value;
      console.info('从首选项加载上次设置的字体大小：' + this.fontSize);
    });
  }

  @Builder
  SettingList() {
    List() {
      ForEach(this.settings, (item: IMenuItem) => {
        ListItem() {
          SettingListCell({
            item: item,
            fontSize: this.fontSize
          })
        }
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

  build() {
    Column() {
      // 标题
      NaviBar({ title: '设置', hasLeftIcon: false })

      // 设置列表
      this.SettingList()
    }
    .height(CommonConstants.FULL_HEIGHT)
    .width(CommonConstants.FULL_WIDTH)
    .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
  }
}

@Component
struct SettingListCell {
  @Prop item: IMenuItem;
  @Prop fontSize: number;

  build() {
    Row() {
      Image(this.item.icon)
        .width(24)
        .height(24)
        .objectFit(ImageFit.Cover)

      Text(this.item.title)
        .textAlign(TextAlign.Start)
        .fontSize(`${this.fontSize}fp`)
        .fontWeight(FontWeight.Medium)
        .margin({ left: 10 })

      Blank()
    }
    .width(CommonConstants.FULL_WIDTH)
    .height(56)
    .onClick(() => {
      if (!this.item.url) {
        promptAction.showToast({
          message: '正在研发中...',
          duration: 1500
        })
        return;
      }
      router.pushUrl({
        url: this.item.url
      })
    })
  }
}