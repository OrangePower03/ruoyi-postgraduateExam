import request from '@/utils/request'

// 查询【请填写功能名称】列表
export function listFeedback(query) {
  return request({
    url: '/user/feedback/list',
    method: 'get',
    params: query
  })
}

// 查询【请填写功能名称】详细
export function getFeedback(userId) {
  return request({
    url: '/user/feedback/' + userId,
    method: 'get'
  })
}

// 新增【请填写功能名称】
export function addFeedback(data) {
  return request({
    url: '/user/feedback',
    method: 'post',
    data: data
  })
}

// 修改【请填写功能名称】
export function updateFeedback(data) {
  return request({
    url: '/user/feedback',
    method: 'put',
    data: data
  })
}

// 删除【请填写功能名称】
export function delFeedback(userId) {
  return request({
    url: '/user/feedback/' + userId,
    method: 'delete'
  })
}
