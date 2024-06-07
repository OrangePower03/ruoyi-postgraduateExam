import request from '@/utils/request'
// export function analysis(data) {
//   return request({
//     url: '/user/school/analysis',
//     method: 'post',
//     data: data
//   })
// }

export function analysis(query) {
  return request({
    url: '/user/school/analysis',
    method: 'get',
    params: query
  })
}
