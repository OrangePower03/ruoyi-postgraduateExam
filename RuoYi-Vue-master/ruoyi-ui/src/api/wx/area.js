import request from '@/utils/request'

// 查询地区列表
export function listArea(query) {
  return request({
    url: '/user/area/list',
    method: 'get',
    params: query
  })
}

// 查询地区详细
export function getArea(areaId) {
  return request({
    url: '/user/area/' + areaId,
    method: 'get'
  })
}

// 新增地区
export function addArea(data) {
  return request({
    url: '/user/area',
    method: 'post',
    data: data
  })
}

// 修改地区
export function updateArea(data) {
  return request({
    url: '/user/area',
    method: 'put',
    data: data
  })
}

// 删除地区
export function delArea(areaId) {
  return request({
    url: '/user/area/' + areaId,
    method: 'delete'
  })
}
