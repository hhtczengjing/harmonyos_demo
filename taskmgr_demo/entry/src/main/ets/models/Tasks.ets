import Task from './Task';

class Tasks {
  private _allTaskData: Task[] = [];

  // 添加任务
  add(task: Task) {
    if (task.name === '' || task.update === '' || task.progress < 0) {
      return
    }
    this._allTaskData.push(task)
  }

  // 删除选中任务
  delete(selected: boolean[]) {
    this._allTaskData = this._allTaskData.filter((_ ,index) => {
      return !selected[index]
    })
  }

  public get allTaskData(): Task[] {
    return this._allTaskData;
  }
}

export default new Tasks()