import { MyCommonPage } from './MyCommonPage';
import { MySharePage } from './MySharePage';

export interface IRouterData {
  title: string;
  params?: IRouterParamData;
}

export interface IRouterParamData {
  type: string;
  data: string;
}

@Builder
export function navDestinationMap(name: string, params: object) {
  if (new RegExp('共享').test(name)) {
    MySharePage({ title: name, params: params })
  } else {
    MyCommonPage({ title: name, params: params })
  }
}