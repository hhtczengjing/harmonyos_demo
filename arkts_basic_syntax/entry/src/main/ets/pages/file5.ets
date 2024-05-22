interface W {
  bundleName: string
  action: string
  entities: string[]
}

export function WTest(): void {
  let wantInfo: W = {
    'bundleName': 'com.huawei.hmos.browser',
    'action': 'ohos.want.action.viewData',
    'entities': ['entity.system.browsable']
  }
  console.log(`bundleName: ${wantInfo.bundleName}, action: ${wantInfo.action}`)
}