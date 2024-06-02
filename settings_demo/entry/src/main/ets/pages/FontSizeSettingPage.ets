import { NaviBar } from '../common/components/NaviBar';
import CommonConstants from '../common/constants/CommonConstants';
import { PreferencesManager } from '../common/utils/PreferencesManager';

export enum ChatMessageDirection {
  LEFT,
  RIGHT
}

export interface IChatMessageItem {
  icon: ResourceStr
  text: string
  direction: ChatMessageDirection
}

@Entry
@Component
struct FontSizeSettingPage {
  @State fontSize: number = 16;
  @State chatMessages: IChatMessageItem[] = [
    { icon: $r('app.media.right_head'), text: '你知道现在可以在健康生活添加各种健康目标打卡了吗？', direction: ChatMessageDirection.RIGHT },
    { icon: $r('app.media.left_head'), text: '知道，我添加了运动和饮食相关的目标', direction: ChatMessageDirection.LEFT },
    { icon: $r('app.media.right_head'), text: '太好了，感觉怎么样？', direction: ChatMessageDirection.RIGHT },
    { icon: $r('app.media.left_head'), text: '生活状态越来越好，你也一起试试吧？', direction: ChatMessageDirection.LEFT }
  ]

  aboutToAppear(): void {
    PreferencesManager.sharedManager().getValue("FontSize", 16).then((value) => {
      this.fontSize = value;
      console.info('从首选项加载上次设置的字体大小：' + this.fontSize);
    });
  }

  build() {
    Column() {
      NaviBar({ title: '字体大小设置' })

      // 消息列表
      List({ space: 16 }) {
        ForEach(this.chatMessages, (item: IChatMessageItem) => {
          ListItem() {
            ChatMessageListItem({
              item: item,
              fontSize: this.fontSize
            })
          }
        })
      }
      .width(CommonConstants.FULL_WIDTH)
      .padding({ left: 16, right: 16 })

      Blank()

      // 设置面板
      FontSizeSlider({ fontSize: $fontSize })
    }
    .height(CommonConstants.FULL_HEIGHT)
    .width(CommonConstants.FULL_WIDTH)
    .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
  }
}

@Component
struct ChatMessageListItem {
  @Prop item: IChatMessageItem
  @Prop fontSize: number

  build() {
    Row() {
      // 头像
      Image(this.item.icon)
        .width(44)
        .height(44)

      // 气泡
      Column() {
        Text(this.item.text)
          .textAlign(TextAlign.Start)
          .fontColor('#182341')
          .fontSize(`${this.fontSize}fp`)
          .fontWeight(FontWeight.Medium)
      }
      .padding(12)
      .margin(this.item.direction == ChatMessageDirection.LEFT ? { left: 10, right: 70 } : { left: 70, right: 10 })
      .backgroundColor(this.item.direction == ChatMessageDirection.LEFT ? '#FFFFFF' : '#D7E9F3')
      .borderRadius(12)

      Blank()
    }
    .justifyContent(FlexAlign.Start)
    .width(CommonConstants.FULL_WIDTH)
    .direction(this.item.direction == ChatMessageDirection.LEFT ? Direction.Ltr : Direction.Rtl)
  }
}

@Component
struct FontSizeSlider {
  @Link fontSize: number;

  build() {
    Column() {
      Text('文字大小')
        .fontSize(14)
        .fontColor('#182341')
        .fontWeight(FontWeight.Medium)
        .textAlign(TextAlign.Start)
        .width(CommonConstants.FULL_WIDTH)

      Column() {
        Text(this.getFontTextBySize(this.fontSize))
          .fontSize(14)
          .fontColor('#182341')
          .fontWeight(FontWeight.Medium)

        Row() {
          Text('A')
            .width('12.5%')
            .padding({ right: 8 })
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .textAlign(TextAlign.End)

          Slider({
            min: 14,
            max: 22,
            step: 2,
            style: SliderStyle.InSet,
            value: this.fontSize
          })
            .width('75%')
            .showSteps(true)
            .onChange((value) => {
              this.fontSize = value
              PreferencesManager.sharedManager().save('FontSize', this.fontSize)
            })

          Text('A')
            .width('12.5%')
            .padding({ left: 8 })
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .textAlign(TextAlign.Start)
        }

      }
      .backgroundColor(Color.White)
      .borderRadius(24)
      .padding({ top: 16, bottom: 21 })
      .margin({ top: 6, bottom: '5%' })
    }
    .padding({ left: 16, right: 16 })
    .width(CommonConstants.FULL_WIDTH)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.End)
  }

  getFontTextBySize(fontSize: number) {
    let fontSizeText: Resource | string = ''
    switch (fontSize) {
      case 14:
        fontSizeText = '小'
        break;
      case 16:
        fontSizeText = '标准'
        break;
      case 18:
        fontSizeText = '大'
        break;
      case 20:
        fontSizeText = '超大'
        break;
      case 22:
        fontSizeText = '特大'
        break;
      default:
        fontSizeText = '标准'
    }
    return fontSizeText
  }
}