import { notificationManager } from '@kit.NotificationKit';
import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  build() {
    Column() {
      Button('发布通知')
        .margin({top: 32})
        .onClick(() => {
          this.notify(101, '通知', '通知内容')
        })

      Button('更新通知')
        .margin({top: 20})
        .onClick(() => {
          this.notify(101, '通知1', '通知内容1')
        })

      Button('取消通知')
        .margin({top: 20})
        .onClick(() => {
          this.cancel(101)
        })
    }
    .height('100%')
    .width('100%')
  }

  async notify(id: number, title: string, text: string) {
    try {
      await notificationManager.requestEnableNotification()

      const request: notificationManager.NotificationRequest = {
        id: id,
        content: {
          notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
          normal: {
            title: title,
            text: text
          }
        }
      }

      await notificationManager.publish(request)

      promptAction.showToast({
        message: '发布通知成功'
      })
    } catch (e) {
      promptAction.showToast({
        message: '发布通知失败' + JSON.stringify(e)
      })
    }
  }

  async cancel(id: number) {
    try {
      await notificationManager.requestEnableNotification()
      await notificationManager.cancel(id)
      promptAction.showToast({
        message: '发布通知成功'
      })
    } catch (e) {
      promptAction.showToast({
        message: '发布通知失败' + JSON.stringify(e)
      })
    }
  }
}