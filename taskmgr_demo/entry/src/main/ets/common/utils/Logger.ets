import { hilog } from '@kit.PerformanceAnalysisKit'

class Logger {
  private prefix: string = '[task_mgr]'
  private domain: number = 0xFF00
  private format: string = '%{public}s, %{public}s'

  debug(...args: string[]) {
    hilog.debug(this.domain, this.prefix, this.format, args)
  }

  info(...args: string[]) {
    hilog.info(this.domain, this.prefix, this.format, args)
  }

  error(...args: string[]) {
    hilog.error(this.domain, this.prefix, this.format, args)
  }

  fatal(...args: string[]) {
    hilog.fatal(this.domain, this.prefix, this.format, args)
  }
}

export default new Logger()