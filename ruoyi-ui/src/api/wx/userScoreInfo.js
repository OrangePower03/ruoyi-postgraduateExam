import request from '@/utils/request'

// 查询【请填写功能名称】列表
export function listScoreinfo(query) {
  return request({
    url: '/user/scoreinfo/list',
    method: 'get',
    params: query
  })
}

// 查询【请填写功能名称】详细
export function getScoreinfo(userId) {
  return request({
    url: '/user/scoreinfo/' + userId,
    method: 'get'
  })
}

// 新增【请填写功能名称】
export function addScoreinfo(data) {
  return request({
    url: '/user/scoreinfo',
    method: 'post',
    data: data
  })
}

// 修改【请填写功能名称】
export function updateScoreinfo(data) {
  return request({
    url: '/user/scoreinfo',
    method: 'put',
    data: data
  })
}

// 删除【请填写功能名称】
export function delScoreinfo(userId) {
  return request({
    url: '/user/scoreinfo/' + userId,
    method: 'delete'
  })
}
