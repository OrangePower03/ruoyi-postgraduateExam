<template>
  <div style="width:48%;height:100%;display: flex;flex-direction: column;align-items: center">
    <div style="width: 100%;padding:10px;overflow: auto;box-shadow: 0 0 5px gainsboro;border: 1px solid gainsboro;height: 94%;border-radius: 15px;display: flex;flex-direction: column;align-items: center;">
      <div style="width: 100%;height: 500px;overflow: auto;">
        <el-table v-loading="loading" :data="infoList">
          <el-table-column :label="title" align="center" prop="infoTitle" >
            <template slot-scope="scope">
              <el-link :href="scope.row.infoLink" type="primary" target="_blank">{{ scope.row.infoTitle }}</el-link>
            </template>
          </el-table-column>
          <el-table-column label="时间" align="center" prop="infoDate" />
        </el-table>

        <pagination
          v-show="total>0"
          :total="total"
          :page.sync="queryParams.pageNum"
          :limit.sync="queryParams.pageSize"
          @pagination="getInfoList"
        />
      </div>
    </div>
  </div>
</template>

<script>
import { listInfo } from '@/api/wx/info'

export default {
  name: 'infoList',

  data(){
    return{
      loading:false,
      title:'',
      infoList:[],
      total:0,
      queryParams:{
        pageNum:1,
        pageSize:10,
        infoType:null,
        schoolId:null
      }
    }
  },
  mounted() {
    this.setInfoType()
  },
  methods:{
    getInfoList(){
      this.loading = true;
      listInfo(this.queryParams).then(response => {
        this.infoList = response.rows;
        this.total = response.total
        this.loading = false;
      });
    },
    setInfoType(){
      this.$on('setInfoType',item=>{
        this.queryParams.schoolId=item.schoolId
        this.queryParams.infoType=item.infoType
        if(item.infoType===1)
          this.title="招生公告"
        else
          this.title="招生简章"
        this.getInfoList()
      })
    }
  }
}
</script>

<style scoped>

</style>
