import request from '@/utils/request'

// 查询【请填写功能名称】列表
export function listSchool(query) {
  return request({
    url: '/user/school/list',
    method: 'get',
    params: query
  })
}

// 查询【请填写功能名称】详细
export function getSchool(schoolId) {
  return request({
    url: '/user/school/' + schoolId,
    method: 'get'
  })
}

// 新增【请填写功能名称】
export function addSchool(data) {
  return request({
    url: '/user/school',
    method: 'post',
    data: data
  })
}

// 修改【请填写功能名称】
export function updateSchool(data) {
  return request({
    url: '/user/school',
    method: 'put',
    data: data
  })
}

// 删除【请填写功能名称】
export function delSchool(schoolId) {
  return request({
    url: '/user/school/' + schoolId,
    method: 'delete'
  })
}

export function listArea(query) {
  return request({
    url: '/user/area/areaList',
    method: 'get',
    params: query
  })
}

export function listDepartment(query) {
  return request({
    url: '/user/department/list',
    method: 'get',
    params: query
  })
}
