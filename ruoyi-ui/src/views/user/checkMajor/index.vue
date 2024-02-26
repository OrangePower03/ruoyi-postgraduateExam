<template>
  <div class="app-container" style="display: flex;margin: 15px">
    <div class="cascader" style="display: flex">
      <el-cascader-panel :options="options" @change="selectMajor"></el-cascader-panel>
    </div>
    <div class="right">
      <el-table v-loading="loading" :data="majorList" stripe border  height="725" style="background-color: rgb(255,255,255,0)" >
        <el-table-column label="专业代码" align="center" prop="majorCode" />
        <el-table-column label="专业名称" align="center" prop="majorName" />
        <el-table-column label="专业类型" align="center" prop="majorType" >
          <template slot-scope="scope">
            <el-tag v-if="scope.row.majorType===1">学硕</el-tag>
            <el-tag v-else>专硕</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
          <template slot-scope="scope">
            <el-button
              size="mini"
              type="text"
              icon="el-icon-search"
              @click="majorDialogChange(scope.row)"
              v-hasPermi="['user:school:list']"
            >查看开设院校</el-button>
          </template>
        </el-table-column>
      </el-table>

      <pagination
        v-show="total>0"
        :total="total"
        :page.sync="queryParams.pageNum"
        :limit.sync="queryParams.pageSize"
        @pagination="getMajorList"
      />
    </div>

    <major-dialog ref="majorDialog"></major-dialog>
  </div>
</template>

<script>
import MajorDialog from '@/views/user/majorDialog/majorDialog.vue'
import majorDialog from '@/views/user/majorDialog/majorDialog.vue'
import { listSMajor } from '@/api/wx/major'

export default {
  components: { MajorDialog },
  data() {
    return {
      loading:false,
      total:0,
      queryParams:{
        pageNum:1,
        pageSize:20,
        majorCode:null
      },
      majorList:[],
      options: [{
        value: '1',
        label: '专业型硕士',
        children: [{
          value: '01',
          label: '01哲学',
          children: [{
            value: '0151',
            label: '0151应用理论',
          }]
        }]
      },{
        value: '2',
        label: '学术型硕士',
        children: [{
          value: '01',
          label: '01哲学',
          children: [{
            value: '0101',
            label: '0101哲学'
          }]
        },{
          value: '02',
          label: '02经济学',
          children: [{
            value: '0201',
            label: '0201理论经济学',
          },{
            value: '0202',
            label: '0202应用经济学',
          },{
            value: '0270',
            label: '0270统计学',
          },{
            value: '0271',
            label: '0271区域国别学',
          }]
        }]
      }]
    };
  },
  methods:{
    majorDialogChange(row){
      this.$refs.majorDialog.$emit('majorDialogShow', row)
    },
    selectMajor(event){
      this.queryParams.majorCode=event[2]
      this.getMajorList()
    },
    getMajorList(){
      this.loading = true;
      listSMajor(this.queryParams).then(response => {
        this.majorList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    }
  }
};
</script>

<style>

  .cascader{
    margin-right: 12px;
  }
  .right{
    width: 60%;
    height: 100%;
  }
  .el-cascader-panel {
    height: 725px;
    width: 542px;
    border-radius: 15px;
  }
  .el-scrollbar__wrap{
    overflow: hidden
  }
</style>
