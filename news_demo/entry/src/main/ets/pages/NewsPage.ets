import { router } from '@kit.ArkUI';
import CommonConstants from '../common/constants/CommonConstants';
import RequestUtil from '../common/utils/RequestUtil';
import { PullToRefresh } from '@ohos/pulltorefresh/index';
import { BusinessError } from '@kit.BasicServicesKit';

interface NewsItem {
  // 标题
  title?: string;
  // 类型
  type?: string;
  // 描述
  digest?: string;
  // 网易头条新闻ID
  docid?: string;
  // pc地址
  pc_url?: string;
  // 手机新闻地址
  m_url?: string;
  // 图片地址
  imgsrc?: string;
  // 来源
  source?: string;
  // 创建时间
  time?: string;
}

@Component
export default struct NewsPage {
  private scroller: Scroller = new Scroller();
  @State news: NewsItem[] = [];
  @State type: number = 1;
  @State pageIndex: number = 1;

  aboutToAppear(): void {
    this.news = []
    RequestUtil.sendRequest<NewsItem[]>(this.type, this.pageIndex).then((results) => {
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

  @Builder
  getListView() {
    List({ scroller: this.scroller }) {
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
    .edgeEffect(EdgeEffect.None) // 必须设置列表为滑动到边缘无效果
    .margin({ top: 0, bottom: 24 })
  }

  build() {
    Column() {
      //this.Header('头条')

      PullToRefresh({
        // 必传项，列表组件所绑定的数据
        data: $news,
        // 必传项，需绑定传入主体布局内的列表或宫格组件
        scroller: this.scroller,
        // 必传项，自定义主体布局，内部有列表或宫格组件
        customList: () => {
          this.getListView();
        },
        // 可选项，下拉刷新回调
        onRefresh: () => {
          return new Promise<string>((resolve, reject) => {
            this.pageIndex = 1;
            RequestUtil.sendRequest<NewsItem[]>(this.type, this.pageIndex).then((results) => {
              this.news = results;
              resolve('刷新成功');
            }).catch((error: BusinessError) => {
              reject('刷新失败')
            })
          })
        },
        onLoadMore: () => {
          return new Promise<string>((resolve, reject) => {
            this.pageIndex += 1;
            RequestUtil.sendRequest<NewsItem[]>(this.type, this.pageIndex).then((results) => {
              this.news = this.news.concat(results);
              resolve('加载成功');
            }).catch((error: BusinessError) => {
              reject('加载失败')
            })
          });
        }
      })
    }
    .width(CommonConstants.FULL_WIDTH)
    .height(CommonConstants.FULL_HEIGHT)
  }
}