import UserInfoData from '../models/mine/UserInfoData'
import SettingListItemData from './mine/SettingListItemData'

export default class MineContentData {
  userInfo: UserInfoData
  settings: SettingListItemData[]

  constructor(userInfo: UserInfoData, settings: SettingListItemData[]) {
    this.userInfo = userInfo
    this.settings = settings
  }
}