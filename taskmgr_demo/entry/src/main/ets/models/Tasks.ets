import RdbStoreManager from './RdbStoreManager';
import Task from './Task';
import { BusinessError } from '@kit.BasicServicesKit';
import { dateFormat } from '../common/utils/DateTime';

class Tasks {
  private _allTaskData: Task[] = [];

  queryAll(): Promise<void> {
    return new Promise((resolve, reject) => {
      RdbStoreManager.sharedManager().queryAll().then((results) => {
        this._allTaskData = results
        resolve()
      }).catch((error: BusinessError) => {
        console.log(`查询历史数据失败: ${error}`)
        reject(error)
      })
    })
  }

  addTask(name: string): Promise<void> {
    return new Promise((resolve, reject) => {
      if (name === '') {
        reject('任务名称不能为空')
        return
      }
      RdbStoreManager.sharedManager().insert(name, 0).then((result) => {
        console.log(`插入任务数据[${name}]完成: ${result}`)
        RdbStoreManager.sharedManager().queryTask(result).then((element) => {
          this._allTaskData.push(element)
          resolve()
        }).catch((error1: BusinessError) => {
          console.log(`查询任务数据[${name}]失败: ${error1}`)
          reject('查询失败')
        })
      }).catch((error: BusinessError) => {
        console.log(`插入任务数据[${name}]失败: ${error}`)
        reject('插入失败')
      })
    })
  }

  deleteTasks(selected: boolean[]): Promise<void> {
    return new Promise((resolve, reject) => {
      // 获取删除的任务ID列表
      let deletedTasks = this._allTaskData.filter((_, index) => {
        return selected[index]
      })
      let ids: number[] = []
      for (const element of deletedTasks) {
        ids.push(element.id)
      }
      RdbStoreManager.sharedManager().delete(ids).then((result) => {
        RdbStoreManager.sharedManager().queryAll().then((results) => {
          this._allTaskData = results
          resolve()
        }).catch((error: BusinessError) => {
          console.log(`查询历史数据失败: ${error}`)
          reject(error)
        })
      }).catch((error: BusinessError) => {
        reject(error)
      })
    })
  }

  updateTask(id: number, progress: number): Promise<void> {
    return new Promise((resolve, reject) => {
      RdbStoreManager.sharedManager().update(id, progress).then((result) => {
        RdbStoreManager.sharedManager().queryAll().then((results) => {
          this._allTaskData = results
          resolve()
        }).catch((error: BusinessError) => {
          console.log(`查询历史数据失败: ${error}`)
          reject(error)
        })
      }).catch((error: BusinessError) => {
        reject(error)
      })
    })
  }

  public get allTaskData(): Task[] {
    return this._allTaskData;
  }

  public get latestUpdateDate(): string {
    let latestUpdateAt = 0
    for (const task of this._allTaskData) {
      if (task.update_at > latestUpdateAt) {
        latestUpdateAt = task.update_at
      }
    }
    return latestUpdateAt > 0 ? dateFormat(latestUpdateAt) : '--';
  }
}

export default new Tasks()