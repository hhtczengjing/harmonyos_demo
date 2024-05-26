@Builder
export function Header(content?: string | Resource) {
  Text(content)
    .fontSize(24)
    .fontWeight(700)
    .textAlign(TextAlign.Start)
    .width('100%')
    .height(32)
    .margin({ left: 16, top: 12, bottom: 12 })
}