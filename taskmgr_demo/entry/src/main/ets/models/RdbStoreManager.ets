import { relationalStore, ValuesBucket } from '@kit.ArkData';
import { BusinessError } from '@kit.BasicServicesKit';
import { currentTimeStamp } from '../common/utils/DateTime';
import Task from './Task';

const DEFAULT_TABLE_NAME: string = 'tasks';

export default class RdbStoreManager {
  // 无参构造函数
  private constructor() {
    // do nothing
  }

  // 全局上下文
  private static instance: RdbStoreManager;
  private store: relationalStore.RdbStore | undefined
  private context?: Context;

  public static sharedManager(): RdbStoreManager {
    if (!RdbStoreManager.instance) {
      RdbStoreManager.instance = new RdbStoreManager();
    }
    return RdbStoreManager.instance;
  }

  init(context: Context): Promise<void> {
    this.context = context
    return new Promise((resolve, reject) => {
      const tableCreateSql =
        'create table if not exists tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, progress REAL, create_at INTEGER, update_at INTEGER);'
      let config: relationalStore.StoreConfig = {
        name: 'task_mgr.db', securityLevel: relationalStore.SecurityLevel.S1
      }
      relationalStore.getRdbStore(this.context, config, (error, storeInstance) => {
        if (error) {
          reject(error)
          return
        }
        this.store = storeInstance
        this.store.executeSql(tableCreateSql).then(() => {
          resolve()
        }).catch((error: BusinessError) => {
          reject(error)
        })
      })
    })
  }

  insert(name: string, progress: number): Promise<number> {
    let currentTime = currentTimeStamp()
    let bucket: ValuesBucket = {
      'name': name,
      'progress': progress,
      'create_at': currentTime,
      'update_at': currentTime
    }
    return new Promise((resolve, reject) => {
      this.store?.insert(DEFAULT_TABLE_NAME, bucket, (error, result) => {
        if (error) {
          reject(error)
          return
        }
        resolve(result)
      })
    })
  }

  update(id: number, progress: number): Promise<number> {
    let currentTime = currentTimeStamp()
    let bucket: ValuesBucket = {
      'progress': progress, 'update_at': currentTime
    }
    let predicates: relationalStore.RdbPredicates = new relationalStore.RdbPredicates(DEFAULT_TABLE_NAME)
    predicates.equalTo('id', id)
    return new Promise((resolve, reject) => {
      this.store?.update(bucket, predicates, (error, result) => {
        if (error) {
          reject(error)
          return
        }
        resolve(result)
      })
    })
  }

  delete(ids: number[]): Promise<number> {
    let predicates: relationalStore.RdbPredicates = new relationalStore.RdbPredicates(DEFAULT_TABLE_NAME)
    predicates.in('id', ids)
    return new Promise((resolve, reject) => {
      this.store?.delete(predicates, (error, result) => {
        if (error) {
          reject(error)
          return
        }
        resolve(result)
      })
    })
  }

  queryAll(): Promise<Task[]> {
    let predicates: relationalStore.RdbPredicates = new relationalStore.RdbPredicates(DEFAULT_TABLE_NAME)
    return new Promise((resolve, reject) => {
      this.store?.query(predicates, (error, resultSet) => {
        if (error) {
          reject(error)
          return
        }
        let results: Task[] = []
        while (resultSet.goToNextRow()) {
          let id: number = resultSet.getLong(resultSet.getColumnIndex('id'))
          let name: string = resultSet.getString(resultSet.getColumnIndex('name'))
          let progress: number = resultSet.getDouble(resultSet.getColumnIndex('progress'))
          let createAt: number = resultSet.getLong(resultSet.getColumnIndex('create_at'))
          let updateAt: number = resultSet.getLong(resultSet.getColumnIndex('update_at'))
          let bucket: Task = new Task(id, name, progress, createAt, updateAt)
          results.push(bucket)
        }
        resolve(results)
      })
    })
  }

  queryTask(id: number): Promise<Task> {
    let predicates: relationalStore.RdbPredicates = new relationalStore.RdbPredicates(DEFAULT_TABLE_NAME)
    predicates.equalTo('id', id)
    return new Promise((resolve, reject) => {
      this.store?.query(predicates, (error, resultSet) => {
        if (error) {
          reject(error)
          return
        }
        if (resultSet.goToNextRow()) {
          let id: number = resultSet.getLong(resultSet.getColumnIndex('id'))
          let name: string = resultSet.getString(resultSet.getColumnIndex('name'))
          let progress: number = resultSet.getDouble(resultSet.getColumnIndex('progress'))
          let createAt: number = resultSet.getLong(resultSet.getColumnIndex('create_at'))
          let updateAt: number = resultSet.getLong(resultSet.getColumnIndex('update_at'))
          let bucket: Task = new Task(id, name, progress, createAt, updateAt)
          resolve(bucket)
        } else {
          reject('查询失败')
        }
      })
    })
  }
}