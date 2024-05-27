import CommonConstants from '../constants/CommonConstants'

@Builder
export function Header(content?: string | Resource) {
  Text(content)
    .fontSize(24)
    .fontWeight(700)
    .textAlign(TextAlign.Start)
    .width(CommonConstants.FULL_WIDTH)
    .height(32)
    .margin({ left: 18, top: 12, bottom: 12 })
}