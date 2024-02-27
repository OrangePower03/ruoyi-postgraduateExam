import request from '@/utils/request'

// 查询学科类别列表
export function listField(query) {
  return request({
    url: '/user/field/list',
    method: 'get',
    params: query
  })
}

export function listAllField(query) {
  return request({
    url: '/user/field/fieldList',
    method: 'get',
    params: query
  })
}

// 查询学科类别详细
export function getField(fieldId) {
  return request({
    url: '/user/field/' + fieldId,
    method: 'get'
  })
}

// 新增学科类别
export function addField(data) {
  return request({
    url: '/user/field',
    method: 'post',
    data: data
  })
}

// 修改学科类别
export function updateField(data) {
  return request({
    url: '/user/field',
    method: 'put',
    data: data
  })
}

// 删除学科类别
export function delField(fieldId) {
  return request({
    url: '/user/field/' + fieldId,
    method: 'delete'
  })
}
