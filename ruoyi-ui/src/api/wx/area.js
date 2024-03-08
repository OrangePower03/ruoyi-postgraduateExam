import request from '@/utils/request'

// 查询【请填写功能名称】列表
export function listArea(query) {
  return request({
    url: '/user/area/list',
    method: 'get',
    params: query
  })
}

// 查询【请填写功能名称】详细
export function getArea(areaId) {
  return request({
    url: '/user/area/' + areaId,
    method: 'get'
  })
}

// 新增【请填写功能名称】
export function addArea(data) {
  return request({
    url: '/user/area',
    method: 'post',
    data: data
  })
}

// 修改【请填写功能名称】
export function updateArea(data) {
  return request({
    url: '/user/area',
    method: 'put',
    data: data
  })
}

// 删除【请填写功能名称】
export function delArea(areaId) {
  return request({
    url: '/user/area/' + areaId,
    method: 'delete'
  })
}
