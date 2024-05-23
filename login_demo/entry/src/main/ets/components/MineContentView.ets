import { Header } from '../common/components/Header'
import SettingListItem from './mine/SettingListItem'
import UserInfoView from './mine/UserInfoView'
import mineDataService from '../services/MineContentDataService'
import MineContentData from '../models/MineContentData'
import SettingListItemData from '../models/mine/SettingListItemData'

@Component
export default struct MineContentView {
  @State mineData?: MineContentData | null = null;

  aboutToAppear(): void {
    this.mineData = mineDataService.requestData()
  }

  build() {
    Column() {
      // 标题
      Header('我的')

      Column() {
        // 登录用户
        UserInfoView({ data: this.mineData?.userInfo })
          .margin({ top: 24 })

        // 列表
        List() {
          ForEach(this.mineData?.settings, (item: SettingListItemData) => {
            ListItem() {
              SettingListItem({ data: item })
            }
          })
        }
        .scrollBar(BarState.Off)
        .backgroundColor(Color.White)
        .margin({ top: 22 })
        .width('100%')
        .divider({
          strokeWidth: 0.25,
          color: Color.Grey,
          startMargin: 42,
          endMargin: 24
        })
        .borderRadius(16)
        .padding({ top: 4, bottom: 4})

        Blank()

        // 退出登录
        Button('退出', { type: ButtonType.Capsule })
          .width('90%')
          .height(40)
          .fontSize(16)
          .fontColor('#FA2A2D')
          .fontWeight(FontWeight.Medium)
          .backgroundColor('#E5E8EA')
          .margin({bottom: 44})
      }
      .margin({left: 16, right: 16, bottom: 40})
      .height('90%')
    }
    .backgroundColor($r('app.color.content_page_background'))
    .width('100%')
    .height('100%')
  }
}