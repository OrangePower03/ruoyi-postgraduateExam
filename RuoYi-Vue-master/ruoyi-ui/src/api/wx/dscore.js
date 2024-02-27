import request from '@/utils/request'

// 查询【请填写功能名称】列表
export function listDscore(query) {
  return request({
    url: '/user/dscore/list',
    method: 'get',
    params: query
  })
}

export function listRetest(query) {
  return request({
    url: '/user/dscore/retestList',
    method: 'get',
    params: query
  })
}


// 查询【请填写功能名称】详细
export function getDscore(scoreId) {
  return request({
    url: '/user/dscore/' + scoreId,
    method: 'get'
  })
}

// 新增【请填写功能名称】
export function addDscore(data) {
  return request({
    url: '/user/dscore',
    method: 'post',
    data: data
  })
}

// 修改【请填写功能名称】
export function updateDscore(data) {
  return request({
    url: '/user/dscore',
    method: 'put',
    data: data
  })
}

// 删除【请填写功能名称】
export function delDscore(scoreId) {
  return request({
    url: '/user/dscore/' + scoreId,
    method: 'delete'
  })
}
