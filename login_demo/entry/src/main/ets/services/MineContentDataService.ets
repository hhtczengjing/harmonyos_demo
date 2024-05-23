import { SettingListItemData } from '../components/mine/SettingListItem'
import { UserInfoData } from '../components/mine/UserInfoView'
import MineContentData from '../models/MineContentData'

export class MineContentDataService {

  requestData(): MineContentData {
    let userInfo = this.getUserInfo()
    let settings = this.getSettingsData()
    let data = new MineContentData(userInfo, settings)
    return data
  }

  private getUserInfo(): UserInfoData {
    let info: UserInfoData = {
      name: '张先生',
      email: 'mrzhang@gmail.com'
    }
    return info
  }

  private getSettingsData(): SettingListItemData[] {
    let items: SettingListItemData[] = [
      {icon: $r('app.media.news'), title: '推送通知', type: 1},
      {icon: $r('app.media.storage'), title: '数据管理', type: 0},
      {icon: $r('app.media.menu'), title: '菜单设置', type: 0},
      {icon: $r('app.media.recycle'), title: '清除缓存', type: 0},
      {icon: $r('app.media.privacy'), title: '隐私协议', type: 0},
      {icon: $r('app.media.about'), title: '关于我们', type: 0}
    ]
    return items
  }
}

export default new MineContentDataService()