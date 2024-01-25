import request from '@/utils/request'

// 查询导师表列表
export function listTeacher(query) {
  return request({
    url: '/user/teacher/list',
    method: 'get',
    params: query
  })
}

// 查询导师表详细
export function getTeacher(teacherId) {
  return request({
    url: '/user/teacher/' + teacherId,
    method: 'get'
  })
}

// 新增导师表
export function addTeacher(data) {
  return request({
    url: '/user/teacher',
    method: 'post',
    data: data
  })
}

// 修改导师表
export function updateTeacher(data) {
  return request({
    url: '/user/teacher',
    method: 'put',
    data: data
  })
}

// 删除导师表
export function delTeacher(teacherId) {
  return request({
    url: '/user/teacher/' + teacherId,
    method: 'delete'
  })
}
