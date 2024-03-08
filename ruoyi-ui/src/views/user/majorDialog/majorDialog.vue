<template>
  <div>
    <el-dialog :title="title" :visible.sync="isMajorShow" width="90%" append-to-body center>
      <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" label-width="68px">
        <el-form-item label="学校名称" prop="majorSchoolName">
          <el-input
            v-model="queryParams.majorSchoolName"
            placeholder="请输入学校名称"
            clearable
            @keyup.enter.native="handleQuery"
          />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
          <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
        </el-form-item>
      </el-form>

      <el-table v-loading="loading" :data="schoolList">
        <el-table-column label="学校名称" align="center" prop="majorSchoolName" />
        <el-table-column label="学院名称" align="center" prop="majorDepartmentName"/>
        <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
          <template slot-scope="scope">
            <el-button
              size="mini"
              type="text"
              icon="el-icon-search"
              @click="changeSchoolShow(scope.row)"
              v-hasPermi="['user:school:list']"
            >查看</el-button>
          </template>
        </el-table-column>
      </el-table>

      <pagination
        v-show="total>0"
        :total="total"
        :page.sync="queryParams.pageNum"
        :limit.sync="queryParams.pageSize"
        @pagination="getSchoolList"
      />
    </el-dialog>

    <school-dialog ref="schoolDialog2"></school-dialog>
  </div>
</template>

<script>
import SchoolDialog from '@/views/user/schoolDialog/schoolDialog.vue'
import { listMajor } from '@/api/wx/major'

export default {
  name: 'majorDialog',
  components: { SchoolDialog },
  data(){
    return{
      title:null,
      isMajorShow:false,
      isSchoolShow:false,
      loading:false,
      schoolList: [],
      queryParams:{
        pageNum:1,
        pageSize:10,
        majorId:null,
        majorSchoolName: null
      },
      total:0
    }
  },
  mounted() {
    this.changeMajorDialogShow()
  },
  methods:{
    handleQuery(){
      this.queryParams.pageNum=1
      this.getSchoolList()
    },
    resetQuery(){
      this.queryParams.majorSchoolName=null
      this.handleQuery()
    },
    getSchoolList(){
      this.loading = true;
      listMajor(this.queryParams).then(response => {
        this.schoolList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    changeMajorDialogShow(){
      this.$on('majorDialogShow', row => {
        this.queryParams.majorId=row.majorId
        this.resetQuery()
        this.title=row.majorName+"专业开设院校"
        this.isMajorShow=true
      })
    },
    changeSchoolShow(row){
      this.$refs.schoolDialog2.$emit('schoolDialogShow',row.schoolId)
    }
  }
}
</script>

<style scoped>

</style>
