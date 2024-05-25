import Task from './Task';

class Tasks {
  private _allTaskData: Task[] = [];

  // 添加任务
  add(task: Task) {

  }

  // 删除选中任务
  delete(tasks: Task[]) {
    
  }

  public get allTaskData(): Task[] {
    return this._allTaskData;
  }
}

export default new Tasks()