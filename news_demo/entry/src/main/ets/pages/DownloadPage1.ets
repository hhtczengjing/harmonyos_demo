import { NaviBar } from '../common/components/NaviBar';
import fs from '@ohos.file.fs';
import { BusinessError } from '@kit.BasicServicesKit';
import { http } from '@kit.NetworkKit';

const URL = "https://xxxx-assets-xxxx.xxxxxx.com/tools/dev/plugins/time_tools/time_tools-0.1.0.zip"

// 从下载链接获取文件名。这里以简单包含文件名的下载链接为例。
function getFileNameFromUrl(url: string): string {
  const segments = url.split('/'); // 将URL字符串按照'/'字符进行分割,返回一个数组。
  return segments.pop() || '未知文件名'; // 使用pop方法从数组的末尾返回最后一个元素。
}

@Entry
@Component
struct DownloadPage1 {
  @State message: string = 'Hello World';
  @State downloadUrl: string = URL;
  @State downloadFinished: boolean = false;
  @State progress: number = 0;

  build() {
    Column() {
      NaviBar({
        title: '下载文件'
      })

      Column() {
        TextInput({ text: this.downloadUrl })
          .margin({ top: 20, bottom: 20 })

        Progress({ value: this.downloadFinished ? 0 : this.progress })
          .margin({ left: 20, right: 20 })

        Button("下载")
          .margin({ top: 10 })
          .onClick(() => {
            this.downloadButtonClick()
          })

        Text("下载完成")
          .fontSize(30)
          .backgroundColor(Color.Green)
          .fontColor(Color.White)
          .borderRadius(8)
          .padding(8)
          .margin({ top: 20 })
          .visibility(this.downloadFinished ? Visibility.Visible : Visibility.Hidden)
      }
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Center)
      .height('100%')
      .width('100%')
    }
    .height('100%')
    .width('100%')
  }

  downloadButtonClick() {
    this.downloadFinished = false
    const filePath = getContext(this).filesDir + '/' + getFileNameFromUrl(this.downloadUrl);
    let file = fs.openSync(filePath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
    console.info('file fd: ' + file.fd);
    this.download(file)
  }

  download(file: fs.File): void {
    let httpRequest = http.createHttp()
    httpRequest.on('headersReceive', (header) => {
      console.info('header: ' + JSON.stringify(header))
    })
    httpRequest.on('dataReceive', (data: ArrayBuffer) => {
      let writeLen: number = fs.writeSync(file.fd, data);
      console.info('write data to file succeed and size is:' + writeLen);
    })
    httpRequest.on('dataReceiveProgress', (info: http.DataReceiveProgressInfo) => {
      this.progress = info.receiveSize / info.totalSize * 100
    })
    httpRequest.on('dataEnd', () => {
      fs.closeSync(file);
      this.downloadFinished = true
      this.progress = 0
      console.info('dataEnd')
    })

    let promise = httpRequest.requestInStream(
      // 请求url地址
      this.downloadUrl,
      {
        // 请求方式
        method: http.RequestMethod.GET,
        // 可选，默认为60s
        connectTimeout: 60000,
        // 可选，默认为60s
        readTimeout: 60000,
        // 可选，默认无此字段
        expectDataType: http.HttpDataType.STRING,
        // 可选，默认为true
        usingCache: true,
        // 可选，默认为1
        priority: 1,
        // 可选，默认值由系统自动指定。
        usingProtocol: http.HttpProtocol.HTTP1_1,
        // 可选，默认为false
        usingProxy: false,
        // 开发者根据自身业务需要添加header字段
        header: {
          'Content-Type': 'application/json'
        }
      })
    promise.then((data) => {
      console.info('Result:' + data)
    }).catch((err: BusinessError) => {
      console.info('error:' + JSON.stringify(err))
    })
  }
}