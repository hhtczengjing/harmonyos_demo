import { http } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';

interface IResponseData {
  code: number;
  msg?: string;
  data?: object;
}

export default class RequestUtil {
  public static sendRequest<T>(type: number, page: number): Promise<T> {
    let httpRequest = http.createHttp()
    return new Promise((resolve, reject) => {
      httpRequest.request(`https://v2.alapi.cn/api/new/toutiao?token=qlVquQZPYSeaCi6u&type=${type}&page=${page}`, {
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
          reject(new Error('加载失败'))
        }
      }).catch((error: BusinessError) => {
        reject(error)
      })
    })
  }
}