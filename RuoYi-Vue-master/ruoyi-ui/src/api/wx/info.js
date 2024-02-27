import request from '@/utils/request'

// 查询招生信息列表
export function listInfo(query) {
  return request({
    url: '/user/info/list',
    method: 'get',
    params: query
  })
}

// 查询所有的学校信息
export function schoolList() {
  return request({
    url: '/user/school/schoolList',
    method: 'get',
  })
}

// 查询招生信息详细
export function getInfo(infoId) {
  return request({
    url: '/user/info/' + infoId,
    method: 'get'
  })
}

// 新增招生信息
export function addInfo(data) {
  return request({
    url: '/user/info',
    method: 'post',
    data: data
  })
}

// 修改招生信息
export function updateInfo(data) {
  return request({
    url: '/user/info',
    method: 'put',
    data: data
  })
}

// 删除招生信息
export function delInfo(infoId) {
  return request({
    url: '/user/info/' + infoId,
    method: 'delete'
  })
}
