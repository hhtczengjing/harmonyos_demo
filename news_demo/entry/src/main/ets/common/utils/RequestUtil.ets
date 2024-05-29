import { http } from '@kit.NetworkKit'
import { BusinessError } from '@kit.BasicServicesKit';

interface IResponseData {
  code: number;
  msg?: string;
  data?: object;
}

export default class RequestUtil {
  public static sendRequest<T>(): Promise<T> {
    let httpRequest = http.createHttp()
    return new Promise((resolve, reject) => {
      httpRequest.request('https://v2.alapi.cn/api/new/toutiao?token=qlVquQZPYSeaCi6u', {
        method: http.RequestMethod.GET,
        header: {
          'Content-Type': 'application/json'
        }
      }).then((data) => {
        console.info('data.responseCode:' + data.responseCode)
        if (data.responseCode === http.ResponseCode.OK) {
          console.info('data.result:' + data.result)
          if (data.result) {
            let respData = JSON.parse(data.result as string) as IResponseData
            resolve((respData.data as T))
            return
          }
        }
      }).catch((error: BusinessError) => {
        reject(error)
      })
    })
  }
}