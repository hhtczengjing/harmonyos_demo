export function currentTime() {
  return new Date().toLocaleString('zh-CN', { timeZone: 'Asia/Shanghai' })
}

export function dateFormat(update_at: number) {
  return new Date(update_at).toLocaleString('zh-CN', { timeZone: 'Asia/Shanghai' })
}

export function currentTimeStamp() {
  return new Date().getTime()
}