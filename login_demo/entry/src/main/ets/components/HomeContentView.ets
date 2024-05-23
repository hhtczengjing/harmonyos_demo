import { Header } from '../common/components/Header'
import HomeBanner from './home/HomeBanner'
import HomeCategory from './home/HomeCategory'
import HomeMenu from './home/HomeMenu'
import homeDataService from '../services/HomeContentDataService'
import HomeContentData from '../models/HomeContentData'

@Component
export default struct HomeContentView {
  @State homeData?: HomeContentData | null = null;

  aboutToAppear(): void {
    this.homeData = homeDataService.requestData()
  }

  build() {
    Column() {
      // 标题
      Header('首页')

      List({ space: 10 }) {
        // 轮播图
        ListItem() {
          HomeBanner({ swiperData: this.homeData?.banners })
            .margin({ top: 10 })
        }

        // 快捷入口
        ListItem() {
          HomeMenu({ menus: this.homeData?.menus })
            .margin({ top: 10 })
        }

        // 列表
        ListItem() {
          HomeCategory({ categories: this.homeData?.categories })
            .margin({ top: 10 })
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
      .padding(20)
    }
    .backgroundColor($r('app.color.content_page_background'))
    .width('100%')
    .height('100%')
  }
}