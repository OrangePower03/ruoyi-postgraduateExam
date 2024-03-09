import request from '@/utils/request'

// 查询【请填写功能名称】列表
export function listScore(query) {
  return request({
    url: '/user/score/list',
    method: 'get',
    params: query
  })
}

export function recommend(query) {
  return request({
    url: '/user/score/recommend',
    method: 'get',
    params: query
  })
}

export function ThreeRetestLine(query) {
  return request({
    url: '/user/score/ThreeRetestLine',
    method: 'get',
    params: query
  })
}

// 查询【请填写功能名称】详细
export function getScore(scoreId) {
  return request({
    url: '/user/score/' + scoreId,
    method: 'get'
  })
}

// 新增【请填写功能名称】
export function addScore(data) {
  return request({
    url: '/user/score',
    method: 'post',
    data: data
  })
}

// 修改【请填写功能名称】
export function updateScore(data) {
  return request({
    url: '/user/score',
    method: 'put',
    data: data
  })
}

// 删除【请填写功能名称】
export function delScore(scoreId) {
  return request({
    url: '/user/score/' + scoreId,
    method: 'delete'
  })
}

export function listMajor(query) {
  return request({
    url: '/user/major/majorList',
    method: 'get',
    params: query
  })
}

export function listAllInfo(query) {
  return request({
    url: '/user/score/AllInfoList',
    method: 'get',
    params: query
  })
}
