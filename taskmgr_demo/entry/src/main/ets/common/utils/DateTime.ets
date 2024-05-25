export default function currentTime()  {
  return new Date().toLocaleString('zh-CN', { timeZone: 'Asia/Shanghai'})
}