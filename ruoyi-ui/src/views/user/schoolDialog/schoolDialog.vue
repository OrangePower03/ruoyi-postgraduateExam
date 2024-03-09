<template>
  <el-dialog :title="title" :visible.sync="dialogTableVisible" width="90%" append-to-body center>
    <el-tabs v-model="activeName" @tab-click="handleClick">
      <el-tab-pane label="学校概况" name="first">
          <el-descriptions direction="vertical" :column="4" border>
            <el-descriptions-item label="学校名称">
              <el-tag>{{schoolInfo.schoolName}}</el-tag>
            </el-descriptions-item>
            <el-descriptions-item label="学校层次">
              <el-tag v-if="schoolInfo.schoolLevels===1">985，211，双一流</el-tag>
              <el-tag v-else-if="schoolInfo.schoolLevels===2">211，双一流</el-tag>
              <el-tag v-else-if="schoolInfo.schoolLevels===3">双一流</el-tag>
              <el-tag v-else-if="schoolInfo.schoolLevels===4">普通高校</el-tag>
            </el-descriptions-item>
            <el-descriptions-item label="所在地区">
              <el-tag size="small" v-if="schoolInfo.areaType===1">{{ schoolInfo.areaName }}/A区</el-tag>
              <el-tag size="small" v-else-if="schoolInfo.areaType===2">{{ schoolInfo.areaName }}/B区</el-tag>
            </el-descriptions-item>
            <el-descriptions-item label="是否为自划线">
              <el-tag v-if="schoolInfo.schoolType===1" type="success">是</el-tag>
              <el-tag v-else-if="schoolInfo.schoolType===1" type="warning">否</el-tag>
            </el-descriptions-item>
            <el-descriptions-item label="学校官网">
              <el-tag><el-link :href="schoolInfo.schoolWebsite" type="primary" target="_blank">{{ schoolInfo.schoolWebsite }}</el-link></el-tag>
            </el-descriptions-item>
            <el-descriptions-item label="学校研招网">
              <el-tag><el-link :href="schoolInfo.schoolRecruit" type="primary" target="_blank">{{ schoolInfo.schoolRecruit }}</el-link></el-tag>
            </el-descriptions-item>
          </el-descriptions>

        <div style="overflow: auto">
          <el-table v-loading="loading" :data="elDepartmentList" height="480">
            <el-table-column :label="title+`二级学院`" align="center" prop="label" />
          </el-table>
        </div>
      </el-tab-pane>

      <el-tab-pane label="招生信息" name="second">
        <div class="scorePane">
          <div style="width: 100%;height: 720px;display: flex;justify-content: space-around">
            <info-list ref="infoList"></info-list>
            <info-list ref="infoList2"></info-list>
          </div>


<!--          <div style="display: flex;justify-content:space-around; height:100%;">-->
<!--            <div style="width:48%;height:100%;display: flex;flex-direction: column;align-items: center">-->
<!--              <div style="width: 100%;padding:10px;overflow: auto;box-shadow: 0 0 5px gainsboro;border: 1px solid gainsboro;height: 94%;border-radius: 15px;display: flex;flex-direction: column;align-items: center;">-->
<!--                <div style="width: 100%;height: 500px;overflow: auto;">-->
<!--                  <el-table v-loading="loading" :data="noticeList">-->
<!--                    <el-table-column label="招生公告" align="center" prop="infoTitle" >-->
<!--                      <template slot-scope="scope">-->
<!--                        <el-link :href="scope.row.infoLink" type="primary" target="_blank">{{ scope.row.infoTitle }}</el-link>-->
<!--                      </template>-->
<!--                    </el-table-column>-->
<!--                    <el-table-column label="时间" align="center" prop="infoDate" />-->
<!--                  </el-table>-->
<!--                </div>-->
<!--              </div>-->
<!--            </div>-->
<!--            <div style="width:48%;display: flex;flex-direction: column;align-items: center">-->
<!--              <div style="width: 100%;padding:10px;overflow: auto;box-shadow: 0 0 5px gainsboro;border: 1px solid gainsboro;height: 94%;border-radius: 15px;display: flex;flex-direction: column;align-items: center;">-->
<!--                <div style="width: 100%;height: 500px;overflow: auto;">-->
<!--                  <el-table v-loading="loading" :data="rulesList">-->
<!--                    <el-table-column label="招生简章" align="center" prop="infoTitle" >-->
<!--                      <template slot-scope="scope">-->
<!--                        <el-link :href="scope.row.infoLink" type="primary" target="_blank">{{ scope.row.infoLink }}</el-link>-->
<!--                      </template>-->
<!--                    </el-table-column>-->
<!--                    <el-table-column label="时间" align="center" prop="infoDate" />-->
<!--                  </el-table>-->
<!--                </div>-->
<!--              </div>-->
<!--            </div>-->
<!--          </div>-->

        </div>
      </el-tab-pane>

      <el-tab-pane label="招生专业" name="third">
        <div class="scorePane">
          <el-form :model="schoolMajorForm" ref="queryForm" size="small" :inline="true" label-width="68px">
            <el-form-item label="专业" prop="majorId">
              <el-select v-model="schoolMajorForm.majorId" placeholder="请选择专业" clearable filterable :style="{width: '100%'}" @keyup.enter.native="handleQuery">
                <el-option v-for="(item, index) in elMajorList" :key="index" :label="item.label"
                           :value="item.value" :disabled="item.disabled"></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="学院" prop="departmentId">
              <el-select v-model="schoolMajorForm.majorDepartmentId" placeholder="请选择该学院" clearable filterable :style="{width: '100%'}" @keyup.enter.native="handleQuery">
                <el-option v-for="(item, index) in elDepartmentList" :key="index" :label="item.label"
                           :value="item.value" :disabled="item.disabled"></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="专业类型" prop="majorType">
              <el-select v-model="schoolMajorForm.majorType" placeholder="请选择该专业的类型" clearable :style="{width: '100%'}" @keyup.enter.native="handleQuery">
                <el-option v-for="(item, index) in majorTypeList" :key="index" :label="item.name"
                           :value="item.value" :disabled="item.disabled"></el-option>
              </el-select>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
              <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
            </el-form-item>
          </el-form>

          <div style="height: 570px;overflow: auto">
            <el-table v-loading="loading" :data="majorList">
              <el-table-column label="专业代码" align="center" prop="majorCode" />
              <el-table-column label="专业名称" align="center" prop="majorName" />
              <el-table-column label="专业类型" align="center" prop="majorType" >
                <template slot-scope="scope">
                  <el-tag v-if="scope.row.majorType===1">学硕</el-tag>
                  <el-tag v-else>专硕</el-tag>
                </template>
              </el-table-column>
              <el-table-column label="所在学院" align="center" prop="majorDepartmentName" />
            </el-table>
          </div>

          <pagination
            v-show="total>0"
            :total="total"
            :page.sync="schoolMajorForm.pageNum"
            :limit.sync="schoolMajorForm.pageSize"
            @pagination="getMajorList"
          />
        </div>
      </el-tab-pane>

      <el-tab-pane label="复试分数线" name="fourth">
        <div class="scorePane">
          <div class="scoreTable">
            <el-form :model="schoolMajorForm" ref="queryForm" size="small" :inline="true" label-width="68px">

              <el-form-item label="专业" prop="majorId">
                <el-select v-model="schoolMajorForm.majorId" placeholder="请选择专业" clearable filterable :style="{width: '100%'}" @keyup.enter.native="handleQuery">
                  <el-option v-for="(item, index) in elMajorList" :key="index" :label="item.label"
                             :value="item.value" :disabled="item.disabled"></el-option>
                </el-select>
              </el-form-item>
              <el-form-item label="学院" prop="departmentId">
                <el-select v-model="schoolMajorForm.majorDepartmentId" placeholder="请选择该学院" clearable filterable :style="{width: '100%'}" @keyup.enter.native="handleQuery">
                  <el-option v-for="(item, index) in elDepartmentList" :key="index" :label="item.label"
                             :value="item.value" :disabled="item.disabled"></el-option>
                </el-select>
              </el-form-item>
              <el-form-item label="专业类型" prop="majorType">
                <el-select v-model="schoolMajorForm.majorType" placeholder="请选择该专业的类型" clearable :style="{width: '100%'}" @keyup.enter.native="handleQuery">
                  <el-option v-for="(item, index) in majorTypeList" :key="index" :label="item.name"
                             :value="item.value" :disabled="item.disabled"></el-option>
                </el-select>
              </el-form-item>
              <el-form-item>
                <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
                <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
              </el-form-item>
            </el-form>

            <el-table v-loading="loading" :data="majorList">
              <el-table-column label="专业名称" align="center" prop="majorName" >
                <template slot-scope="scope">{{scope.row.majorCode+' '+scope.row.majorName}}</template>
              </el-table-column>
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
                    v-hasPermi="['user:school:list']"
                    @click="setScoreCharts(scope.row)"
                  >查看复试线</el-button>
                </template>
              </el-table-column>
            </el-table>

            <pagination
              v-show="total>0"
              :total="total"
              :page.sync="schoolMajorForm.pageNum"
              :limit.sync="schoolMajorForm.pageSize"
              @pagination="getMajorList"
            />
          </div>
          <div style="display: flex;justify-content: center;margin-top: 10px;height: 20px;box-shadow: 0 0 5px gainsboro;border-radius: 15px">
            <span style="font-weight: bold">{{chartTitle}}</span>
          </div>
          <div style="display: flex;justify-content: space-between;align-items:center;width: 100%;margin-top: 10px;">
            <div class="scoreDialog">
              <v-chart :option="option" autoresize></v-chart>
            </div>
            <div style="width: 49%;display: flex;flex-direction: column;">
              <el-card style=" height: 200px; border-radius: 15px;">
                <el-table v-loading="elLoading" :data="currentNationalLine">
                  <el-table-column label="考研年份" align="center" prop="scoreYear" />
                  <el-table-column label="国家线" align="center" prop="scoreAll" />
                  <el-table-column label="英语线" align="center" prop="scoreEnglish" />
                  <el-table-column label="政治线" align="center" prop="scorePolitics" />
                  <el-table-column label="专业一" align="center" prop="scoreMath" />
                  <el-table-column label="专业二" align="center" prop="scoreMajor" />
                </el-table>
              </el-card>
              <el-card style="height: 200px; border-radius: 15px;margin-top: 10px">
                <el-table v-loading="elLoading" :data="currentRetestLine">
                  <el-table-column label="考研年份" align="center" prop="scoreYear" />
                  <el-table-column label="复试线" align="center" prop="scoreAll" />
                  <el-table-column label="英语线" align="center" prop="scoreEnglish" />
                  <el-table-column label="政治线" align="center" prop="scorePolitics" />
                  <el-table-column label="专业一" align="center" prop="scoreMath" />
                  <el-table-column label="专业二" align="center" prop="scoreMajor" />
                </el-table>
              </el-card>
            </div>
          </div>
        </div>
      </el-tab-pane>
    </el-tabs>
  </el-dialog>
</template>

<script>
import { getSchool } from '@/api/wx/school'
import { listDepartment, listMajor, majorList } from '@/api/wx/major'
import { listRetest } from '@/api/wx/dscore'
import { ThreeRetestLine } from '@/api/wx/score'
import InfoList from '@/views/user/infoList/infoList.vue'

export default {
  name: 'schoolDialog',
  components: { InfoList },
  data(){
    return{
      title: "未知大学",
      loading:false,
      elLoading:false,
      majorList:[],
      dialogTableVisible: false,
      activeName: 'first',
      majorTypeList:[{ name:"学硕",value:1},{name:"专硕",value:2}],
      elMajorList:[],
      elDepartmentList:[],
      currentNationalLine:[],
      currentRetestLine:[],
      chartTitle:null,
      schoolInfo:{
        schoolName:'',
        schoolLevels:null,
        schoolType:null,
        areaName:null,
        areaType:null,
        schoolWebsite: null,
        schoolRecruit: null
      },
      schoolMajorForm:{
        pageNum:1,
        pageSize:10,
        schoolId: null,
        majorDepartmentId:null,
        majorId:null
      },
      noticeQueryParams:{
        pageNum: 1,
        pageSize: 10,
        total:0,
        infoType:1,
        schoolId: null
      },
      rulesQueryParams:{
        pageNum: 1,
        pageSize: 10,
        total:0,
        infoType:2,
        schoolId: null
      },
      total:0,
      total2:0,
      option : {
        title: {
          text: ''
        },
        tooltip: {
          trigger: 'axis'
        },
        legend: {
          data: ['复试线', '国家线']
        },
        grid: {
          left: '3%',
          right: '4%',
          bottom: '3%',
          containLabel: true
        },
        toolbox: {
          feature: {
            saveAsImage: {}
          }
        },
        xAxis: {
          type: 'category',
          data: ['2021','2022', '2023']
        },
        yAxis: {
          min: function(value) {//取最小值向下取整为最小刻度
            return Math.floor(value.min)-10
          },
          max: function(value) {//取最大值向上取整为最大刻度
            return  Math.ceil(value.max)+10
          },
          type: 'value'
        },
        series: [
          {
            name: '复试线',
            type: 'line',
            smooth: true,
            data: []
          },
          {
            name: '国家线',
            type: 'line',
            smooth: true,
            data: []
          }
        ]
      }
    }
  },
  mounted() {
    this.changeDialogShow()
    this.recommend()
  },
  methods:{
    handleQuery(){
      this.getMajorList()
    },
    resetQuery(){
      this.schoolMajorForm.pageNum=1
      this.schoolMajorForm.majorDepartmentId=null
      this.schoolMajorForm.majorId=null
      this.chartTitle=''
      this.currentNationalLine=[]
      this.currentRetestLine=[]
      this.option.series[0].data=[]
      this.option.series[1].data=[]
      this.getMajorList()
    },
    recommend (){
      this.$on('recommend', item => {
        this.schoolMajorForm.schoolId=item.schoolId
        this.noticeQueryParams.schoolId=item.schoolId
        this.rulesQueryParams.schoolId=item.schoolId
        this.activeName = 'fourth'
        this.getSchoolInfo(item.schoolId)
        this.getAllDepartmentList(item.schoolId)
        this.schoolMajorForm.majorId=item.majorId
        this.loading = true;
        listMajor(this.schoolMajorForm).then(response => {
          this.majorList = response.rows;
          this.setScoreCharts(this.majorList[0])
          this.total = response.total;
          this.loading = false;
        });
        this.getAllMajorList()
        this.dialogTableVisible=true
      })
    },
    changeDialogShow(){
      this.$on('schoolDialogShow', id => {
        this.schoolMajorForm.schoolId=id
        this.noticeQueryParams.schoolId=id
        this.rulesQueryParams.schoolId=id
        this.activeName = 'first'
        this.getSchoolInfo(id)
        this.getAllDepartmentList(id)
        this.getMajorList()
        this.getAllMajorList()
        this.dialogTableVisible=true
      })
    },
    getSchoolInfo(schoolId){
      getSchool(schoolId).then(response => {
        this.title=response.data.schoolName
        this.schoolInfo=response.data
      });
    },
    getAllMajorList(){
      this.loading = true;
      majorList(this.schoolMajorForm).then(response => {
        this.elMajorList = response.rows.map(item => {
          return { value: item.majorId, label: item.majorCode+' '+item.majorName };
        });
        this.loading = false;
      });
    },
    getAllDepartmentList(departmentId){
      this.loading = true;
      listDepartment({departmentSchoolId: departmentId}).then(response => {
        this.elDepartmentList = response.rows.map(item => {
          return { value: item.departmentId, label: item.departmentName };
        });
        this.loading = false;
      });
    },
    getMajorList(){
      this.loading = true;
      listMajor(this.schoolMajorForm).then(response => {
        this.loading = false;
        this.majorList = response.rows;
        this.total = response.total;
      });
    },
    handleClick(event) {
      this.resetQuery()
      if(event.index==='1'){
        this.$refs.infoList.$emit('setInfoType',{schoolId:this.schoolMajorForm.schoolId,infoType:1})
        this.$refs.infoList2.$emit('setInfoType',{schoolId:this.schoolMajorForm.schoolId,infoType:2})
      }
    },
    setScoreCharts(row){
      this.chartTitle=row.majorCode+' '+row.majorName
      this.getNationalLine(row)
      this.getRetestLine(row.connectId)
    },
    getNationalLine(row) {
      this.elLoading = true;
      listRetest({ majorId: row.majorId,areaType:this.schoolInfo.areaType}).then(response => {
        this.currentNationalLine=response.rows
        this.option.series[1].data=[]
        for(let i=0;i<response.rows.length;i++)
          this.option.series[1].data.push(response.rows[i].scoreAll)
        this.elLoading = false;
      });
    },
    getRetestLine(connectId){
      this.elLoading = true;
      ThreeRetestLine({ scoreMajorId:connectId }).then(response => {
        this.currentRetestLine=response.rows
        this.option.series[0].data=[]
        for(let i=0;i<response.rows.length;i++)
          this.option.series[0].data.push(response.rows[i].scoreAll)
        this.elLoading = false;
      });
    }
  }
}
</script>

<style lang="scss" scoped>
.scorePane{
  display: flex;
  flex-direction: column;
  height:690px;
  padding: 0 10px 0 10px;
  .scoreTable{
    height: 241px;
    overflow: auto;
  }
  .scoreDialog{
    box-shadow: 0 0 5px gainsboro;
    border: 1px solid gainsboro;
    border-radius: 15px;
    padding: 10px;
    width: 50%;
    height: 408px;
  }
}
</style>
