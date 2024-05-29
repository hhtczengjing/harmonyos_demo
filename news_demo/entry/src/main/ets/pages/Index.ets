import { router } from '@kit.ArkUI';
import CommonConstants from '../common/constants/CommonConstants';
import RequestUtil from '../common/utils/RequestUtil';

interface NewsItem {
  title?: string;
  type?: string;
  digest?: string;
  pc_url?: string;
  m_url?: string;
  imgsrc?: string;
  source?: string;
  time?: string;
}

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @State news: NewsItem[] = []

  aboutToAppear(): void {
    RequestUtil.sendRequest<NewsItem[]>().then((results) => {
      this.news = results;
    })
  }

  @Builder
  Header(content?: string | Resource) {
    Row() {
      Text(content)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Start)
        .width('100%')
        .padding({ left: 12 })
    }
    .backgroundColor(Color.White)
    .height(48)
  }

  @Builder
  NewsListItem(item: NewsItem) {
    Row() {
      Column() {
        Text(item.title)
          .width('100%')
          .textAlign(TextAlign.Start)
          .fontWeight(FontWeight.Regular)
          .fontColor($r('sys.color.ohos_id_color_text_primary'))
          .fontSize($r('sys.float.ohos_id_text_size_sub_title1'))

        Row() {
          Text(item.source)
            .fontSize(10)
            .fontColor($r('sys.color.ohos_id_color_text_secondary'))

          Blank()

          Text(item.time)
            .fontSize(10)
            .fontColor($r('sys.color.ohos_id_color_text_secondary'))
        }
        .width('100%')
        .margin({ top: 10 })
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .layoutWeight(1)

      if (item.imgsrc) {
        Image(item.imgsrc)
          .objectFit(ImageFit.Cover)
          .margin({ left: 10 })
          .height(80)
      }
    }
    .padding(10)
    .width('100%')
    .onClick(() => {
      router.pushUrl({
        url: 'pages/DetailPage',
        params: item
      })
    })
  }

  build() {
    Column() {
      this.Header('头条')

      List() {
        ForEach(this.news, (item: NewsItem) => {
          ListItem() {
            this.NewsListItem(item)
          }
        })
      }
      .divider({
        strokeWidth: 1,
        startMargin: 0,
        endMargin: 0,
        color: '#E3E6ED'
      })
      .edgeEffect(EdgeEffect.Spring)
      .margin({ top: 0, bottom: 10 })
    }
    .width(CommonConstants.FULL_WIDTH)
    .height(CommonConstants.FULL_HEIGHT)
  }
}