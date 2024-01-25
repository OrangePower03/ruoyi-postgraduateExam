<template>
  <div class="dashboard-editor-container">
    <div class="top">
      <el-card class="topCard">
          <el-form :model="queryParams" :rules="rules" ref="queryForm" size="small" :inline="true" label-width="68px" style="margin-top: 20px;">
            <el-form-item label="初试分数" prop="scoreAll">
              <el-input v-model="queryParams.scoreAll" placeholder="请输入您的初试分数" :maxlength="3" show-word-limit clearable @keyup.enter.native="handleQuery"
              ></el-input>
            </el-form-item>
            <el-form-item label="英语" prop="scoreEnglish">
              <el-input v-model="queryParams.scoreEnglish" placeholder="请输入您的英语分数" :maxlength="3" show-word-limit clearable @keyup.enter.native="handleQuery"
              ></el-input>
            </el-form-item>
            <el-form-item label="政治" prop="scorePolitics">
              <el-input v-model="queryParams.scorePolitics" placeholder="请输入您的政治分数" :maxlength="3" show-word-limit clearable @keyup.enter.native="handleQuery"
              ></el-input>
            </el-form-item>
            <el-form-item label="专业一" prop="scoreMath">
              <el-input v-model="queryParams.scoreMath" placeholder="请输入您的专业一分数" :maxlength="3" show-word-limit clearable @keyup.enter.native="handleQuery"
              ></el-input>
            </el-form-item>
            <el-form-item label="专业二" prop="scoreMajor">
              <el-input v-model="queryParams.scoreMajor" placeholder="请输入您的专业二分数" :maxlength="3" show-word-limit clearable @keyup.enter.native="handleQuery"
              ></el-input>
            </el-form-item>
            <el-form-item label="地区" prop="areaName">
              <el-select v-model="queryParams.areaName" placeholder="请选择学校所在地区" filterable clearable :style="{width: '100%'}" @keyup.enter.native="handleQuery">
                <el-option v-for="(item, index) in areaOptions" :key="index" :label="item.areaName"
                           :value="item.areaName" :disabled="item.disabled"></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="专业" prop="majorName">
              <el-cascader v-model="queryParams.majorName" :options="majorCascader" @change="majorCascaderChange" filterable clearable></el-cascader>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
              <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
            </el-form-item>
          </el-form>
      </el-card>
    </div>
    <div class="bottom">
      <v-chart class="echarts echarts1" :option="option" @click="openDrawer" autoresize></v-chart>
      <v-chart class="echarts echarts2" :option="option2" autoresize></v-chart>
    </div>
    <school-dialog ref="homePageSchoolDialog"></school-dialog>
  </div>
</template>

<script>
import SchoolDialog from '@/views/user/schoolDialog/schoolDialog.vue'
import { recommend } from '@/api/wx/score'
import { listsMajor } from '@/api/wx/major'
import { listArea } from '@/api/wx/area'
import { listRetest } from '@/api/wx/dscore'

export default {
  name: 'Index',
  components: { SchoolDialog },
  data() {
    return {
      queryParams: {
        scoreAll: null,
        scoreMath: null,
        scoreEnglish: null,
        scorePolitics: null,
        scoreMajor: null,
        majorName: "金融",
        majorCode:null,
        departmentName:null,
        schoolName:null,
        schoolType:null,
        schoolLevels:null,
        areaId: null,
        areaName:null,
        areaType:null
      },
      nowMajorId:1,
      rules: {
        scoreAll: [
          { message: "初始分数有误",pattern:'^(500|[1-4]{0,1}\\d{0,1}\\d)$',trigger: "blur"},
        ],
        scoreEnglish: [
          { message: "英语分数有误",pattern:'^(100|\\d{0,1}\\d)$',trigger: "blur"},
        ],
        scorePolitics:[
          { message: "政治分数有误",pattern:'^(100|\\d{0,1}\\d)$',trigger: "blur"},
        ],
        scoreMath:[
          { message: "专业一分数有误",pattern:'^(150|\\d{0,1}\\d|[1]{0,1}[0-4]{0,1}\\d)$',trigger: "blur"},
        ],
        scoreMajor:[
          { message: "专业二分数有误",pattern:'^(150|\\d{0,1}\\d|[1]{0,1}[0-4]{0,1}\\d)$',trigger: "blur"},
        ],
        majorName:[
          {required:true, message: "专业不能为空",trigger: "blur"},
        ]
      },
      areaOptions:[],
      majorCascader:[{
        value:1,
        label:"专硕",
        children:[]
      },{
        value:2,
        label:"学硕",
        children:[]
      }],
      option: {
        dataset: {
          source: [
            ['推荐指数', '平均复试线', '大学名称', '大学Id'],
            // [100.0, 385, '中国科学技术大学',35],
            // [73.0, 375, '浙江大学',31],
            // [59.5, 370, '武汉大学',37],
            // [32.4, 360, '北京大学',30],
            // [32.4, 360, '清华大学',29],
            // [24.3, 357, '南京大学',34],
            // [18.9, 355, '中山大学',40],
            // [5.4, 350, '山东大学',50],
            // [0.0, 348, '南开大学',48],
          ]
        },
        grid: { containLabel: true },
        xAxis: {
          name: '平均复试线',
          min: function(value) {//取最小值向下取整为最小刻度
            return Math.floor(value.min)-5
          },
          max: function(value) {//取最大值向上取整为最大刻度
            return  Math.ceil(value.max)
          }
        },
        yAxis: { type: 'category' },
        visualMap: {
          orient: 'horizontal',
          left: 'center',
          min: 0,
          max: 100,
          text: ['高相对录取难度', '低相对录取难度'],
          // Map the score column to color
          dimension: 0,
          inRange: {
            color: ['#65B581', '#FFCE34', '#FD665F']
          }
        },
        series: [
          {
            type: 'bar',
            encode: {
              // Map the "amount" column to X axis.
              x: '平均复试线',
              // Map the "product" column to Y axis
              y: '大学名称'
            }
          }
        ]
      },

      option2: {
        title: {
          text: '国家线'
        },
        tooltip: {
          trigger: 'axis'
        },
        legend: {
          data: ['A区国家线', 'B区国家线']
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
          boundaryGap: false,
          data: ['2021', '2022', '2023']
        },
        yAxis: {
          type: 'value',
          min: function(value) {//取最小值向下取整为最小刻度
            return Math.floor(value.min)-5
          },
          max: function(value) {//取最大值向上取整为最大刻度
            return  Math.ceil(value.max)+5
          }
        },
        series: [
          {
            name: 'A区国家线',
            type: 'line',
            smooth: true,
            data: []
          },
          {
            name: 'B区国家线',
            type: 'line',
            smooth: true,
            data: []
          }
        ]
      }
    }
  },
  created() {
    this.algorithm()
    this.getArea()
    this.getSList()
    this.getNationalLine()
  },
  methods: {
    algorithm(){
      recommend({majorName:this.queryParams.majorName}).then(response => {
        this.option.dataset.source=[['推荐指数', '平均复试线', '大学名称', '大学Id']]
        for(let i=0;i<response.rows.length;i++)
          this.option.dataset.source.push([response.rows[i].handledPower*100,response.rows[i].averageScore.scoreAll,
            response.rows[i].schoolName,response.rows[i].schoolId])
      });
    },
    getNationalLine() {
      this.elLoading = true;
      listRetest({ majorId: this.nowMajorId,areaType: 1}).then(response => {
        this.option2.series[0].data=[]
        if (response.rows.length!==0)
          this.option2.series[0].data=[response.rows[0].scoreAll,response.rows[1].scoreAll,response.rows[2].scoreAll]
      });
      listRetest({ majorId: this.nowMajorId,areaType: 2}).then(response => {
        this.option2.series[1].data=[]
        if (response.rows.length!==0)
          this.option2.series[1].data=[response.rows[0].scoreAll,response.rows[1].scoreAll,response.rows[2].scoreAll]
      });
    },
    openDrawer(event){
      if (event.data[3]!==undefined)
        this.$refs.homePageSchoolDialog.$emit("recommend",{schoolId:event.data[3],majorId:this.nowMajorId})
    },
    getSList(){
      this.loading = true;
      listsMajor().then(response => {
        this.majorList = response.rows;
        for (let i=0;i<this.majorList.length;i++){
          if(this.majorList[i].majorType===1)
          {
            this.majorCascader[0].children.push({
              value: [this.majorList[i].majorId,this.majorList[i].majorName],
              label: this.majorList[i].majorCode+' '+this.majorList[i].majorName
            })
          }else{
            this.majorCascader[1].children.push({
              value: [this.majorList[i].majorId,this.majorList[i].majorName],
              label: this.majorList[i].majorCode+' '+this.majorList[i].majorName
            })
          }
        }
        this.loading = false;
      });
    },
    getArea(){
      this.loading = true;
      listArea().then(response => {
        this.areaOptions = response.rows;
        this.loading = false;
      });
    },
    update(event){

    },
    majorCascaderChange(event){
      this.nowMajorId=event[1][0]
      this.queryParams.majorName=event[1][1]
      this.algorithm()
      this.getNationalLine()
    },
    handleQuery(){

    },
    resetQuery(){

    }
  },

}
</script>

<style lang="scss" scoped>
.top{
  margin-top: 7px;
  height: 150px;
  display: flex;
  justify-content: center;
  width: 100%;
  .topCard{
    border-radius: 15px;
    width: 97%;
    height: 150px;
    overflow: auto;
  }
}
.bottom{
  display: flex;
  .echarts{
    background: rgba(200, 205, 205, 0.1);
    padding: 20px;
    border-radius: 15px;
    margin-top: 23px;
    height: 650px;
    margin-left: 23px;
    box-shadow:0 0 10px gainsboro;
  }
  .echarts1{
    width: 57%;
  }
  .echarts2{
    width: 38%;
  }
}
</style>
