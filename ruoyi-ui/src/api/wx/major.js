import request from '@/utils/request'

// 查询【请填写功能名称】列表
export function listMajor(query) {
  return request({
    url: '/user/connect/list',
    method: 'get',
    params: query
  })
}
export function majorList(query) {
  return request({
    url: '/user/connect/majorList',
    method: 'get',
    params: query
  })
}

export function listSMajor(query) {
  return request({
    url: '/user/major/sList',
    method: 'get',
    params: query
  })
}

export function listsMajor(query) {
  return request({
    url: '/user/major/slist',
    method: 'get',
    params: query
  })
}

// 查询【请填写功能名称】详细
export function getMajor(majorId) {
  return request({
    url: '/user/major/' + majorId,
    method: 'get'
  })
}

export function getConnect(connectId) {
  return request({
    url: '/user/connect/' + connectId,
    method: 'get'
  })
}

// 新增【请填写功能名称】
export function addMajor(data) {
  return request({
    url: '/user/major',
    method: 'post',
    data: data
  })
}

// 修改【请填写功能名称】
export function updateMajor(data) {
  return request({
    url: '/user/major',
    method: 'put',
    data: data
  })
}

// 删除【请填写功能名称】
export function delMajor(majorId) {
  return request({
    url: '/user/major/' + majorId,
    method: 'delete'
  })
}
export function listDepartment(query) {
  return request({
    url: '/user/department/departmentList',
    method: 'get',
    params: query
  })
}

// 新增【请填写功能名称】
export function addConnect(data) {
  return request({
    url: '/user/connect',
    method: 'post',
    data: data
  })
}

// 修改【请填写功能名称】
export function updateConnect(data) {
  return request({
    url: '/user/connect',
    method: 'put',
    data: data
  })
}

// 删除【请填写功能名称】
export function delConnect(connectId) {
  return request({
    url: '/user/connect/' + connectId,
    method: 'delete'
  })
}
