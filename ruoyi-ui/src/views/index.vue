<template>
  <div>
    <el-card>
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
          <el-cascader v-model="queryParams.majorName" :options="majorCascader" @change="majorCascaderChange"></el-cascader>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
          <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>
    <div style="display: flex;">
      <v-chart id="main" :option="option2"></v-chart>
    </div>
    <el-drawer
      title="详细信息"
      :visible.sync="drawer"
      :with-header="false"
      size="50%"
      id="content">
      <el-card>
        <v-chart id="main2" :option="option" style="height: 600px; width: 650px"></v-chart>
      </el-card>
      <hr>
      <el-card>
        <h3>专业信息</h3>
        <el-descriptions direction="vertical" :column="4" border>
          <el-descriptions-item label="专业代码"><el-tag size="small">{{ eventContent.majorCode }}</el-tag></el-descriptions-item>
          <el-descriptions-item label="专业名称"><el-tag size="small">{{ eventContent.majorName }}</el-tag></el-descriptions-item>
          <el-descriptions-item label="专业类型">
            <el-tag v-if="eventContent.majorType===1">专硕</el-tag>
            <el-tag v-else>学硕</el-tag>
          </el-descriptions-item>
          <el-descriptions-item label="所在院系"><el-tag size="small">{{ eventContent.departmentName }}</el-tag></el-descriptions-item>
          <el-descriptions-item label="所在学校"><el-tag size="small">{{ eventContent.schoolName }}</el-tag></el-descriptions-item>
          <el-descriptions-item label="学院层次">
            <el-tag v-if="eventContent.schoolLevels===1">985，211，双一流</el-tag>
            <el-tag v-else-if="eventContent.schoolLevels===2">211，双一流</el-tag>
            <el-tag v-else-if="eventContent.schoolLevels===3">211</el-tag>
            <el-tag v-else-if="eventContent.schoolLevels===4">双一流</el-tag>
            <el-tag v-else>双非</el-tag>
          </el-descriptions-item>
          <el-descriptions-item label="是否为自划线">
            <el-tag v-if="eventContent.schoolType===1" type="success">是</el-tag>
            <el-tag v-else type="warning">否</el-tag>
          </el-descriptions-item>
          <el-descriptions-item label="所在地区">
            <el-tag size="small" v-if="eventContent.areaType===1">{{ eventContent.areaName }}/A区</el-tag>
            <el-tag size="small" v-else>{{ eventContent.areaName }}/B区</el-tag>
          </el-descriptions-item>
          <el-descriptions-item label="学校官网">
            <el-tag><el-link :href="eventContent.schoolWebsite" type="primary" target="_blank">{{ eventContent.schoolWebsite }}</el-link></el-tag>
          </el-descriptions-item>
          <el-descriptions-item label="学校研招网">
            <el-tag><el-link :href="eventContent.schoolRecruit" type="primary" target="_blank">{{ eventContent.schoolRecruit }}</el-link></el-tag>
          </el-descriptions-item>
        </el-descriptions>
        <h3>复试线</h3>
        <el-card>
          <el-collapse>
            <el-collapse-item :title="eventContent.scoreYear" name="1">
              <el-card>
                <div>英语：{{ eventContent.scoreEnglish }}</div>
                <div>政治：{{ eventContent.scorePolitics }}</div>
                <div>专业一：{{ eventContent.scoreMath }}</div>
                <div>专业二：{{ eventContent.scoreMajor }}</div>
              </el-card>
            </el-collapse-item>
            <el-collapse-item :title="eventContent.scoreYear2" name="2">
              <el-card>
                <div>英语：{{ eventContent.scoreEnglish2 }}</div>
                <div>政治：{{ eventContent.scorePolitics2 }}</div>
                <div>专业一：{{ eventContent.scoreMath2 }}</div>
                <div>专业二：{{ eventContent.scoreMajor2 }}</div>
              </el-card>
            </el-collapse-item>
            <el-collapse-item :title="eventContent.scoreYear3" name="3">
              <el-card>
                <div>英语：{{ eventContent.scoreEnglish3 }}</div>
                <div>政治：{{ eventContent.scorePolitics3 }}</div>
                <div>专业一：{{ eventContent.scoreMath3 }}</div>
                <div>专业二：{{ eventContent.scoreMajor3 }}</div>
              </el-card>
            </el-collapse-item>
          </el-collapse>
        </el-card>
        <h3>国家线</h3>
        <el-card>
          <el-collapse v-if="eventContent.areaType===1">
            <el-collapse-item :title="nationalList[0].scoreYear" name="1">
              <el-card>
                <div>英语：{{ nationalList[0].scoreEnglish }}</div>
                <div>政治：{{ nationalList[0].scorePolitics }}</div>
                <div>专业一：{{ nationalList[0].scoreMath }}</div>
                <div>专业二：{{ nationalList[0].scoreMajor }}</div>
              </el-card>
            </el-collapse-item>
            <el-collapse-item :title="nationalList[0].scoreYear2" name="2">
              <el-card>
                <div>英语：{{ nationalList[0].scoreEnglish2 }}</div>
                <div>政治：{{ nationalList[0].scorePolitics2 }}</div>
                <div>专业一：{{ nationalList[0].scoreMath2 }}</div>
                <div>专业二：{{ nationalList[0].scoreMajor2 }}</div>
              </el-card>
            </el-collapse-item>
            <el-collapse-item :title="nationalList[0].scoreYear3" name="3">
              <el-card>
                <div>英语：{{ nationalList[0].scoreEnglish3 }}</div>
                <div>政治：{{ nationalList[0].scorePolitics3 }}</div>
                <div>专业一：{{ nationalList[0].scoreMath3 }}</div>
                <div>专业二：{{ nationalList[0].scoreMajor3 }}</div>
              </el-card>
            </el-collapse-item>
          </el-collapse>
          <el-collapse v-else>
            <el-collapse-item :title="nationalList[1].scoreYear" name="1">
              <el-card>
                <div>英语：{{ nationalList[1].scoreEnglish }}</div>
                <div>政治：{{ nationalList[1].scorePolitics }}</div>
                <div>专业一：{{ nationalList[1].scoreMath }}</div>
                <div>专业二：{{ nationalList[1].scoreMajor }}</div>
              </el-card>
            </el-collapse-item>
            <el-collapse-item :title="nationalList[1].scoreYear2" name="2">
              <el-card>
                <div>英语：{{ nationalList[1].scoreEnglish2 }}</div>
                <div>政治：{{ nationalList[1].scorePolitics2 }}</div>
                <div>专业一：{{ nationalList[1].scoreMath2 }}</div>
                <div>专业二：{{ nationalList[1].scoreMajor2 }}</div>
              </el-card>
            </el-collapse-item>
            <el-collapse-item :title="nationalList[1].scoreYear3" name="3">
              <el-card>
                <div>英语：{{ nationalList[1].scoreEnglish3 }}</div>
                <div>政治：{{ nationalList[1].scorePolitics3 }}</div>
                <div>专业一：{{ nationalList[1].scoreMath3 }}</div>
                <div>专业二：{{ nationalList[1].scoreMajor3 }}</div>
              </el-card>
            </el-collapse-item>
          </el-collapse>
        </el-card>
      </el-card>
    </el-drawer>
  </div>
</template>

<script>
import { listAllInfo } from '@/api/wx/score'
import * as echarts from 'echarts';
import { listsMajor } from '@/api/wx/major'
import { listArea } from '@/api/wx/school'
import { listRetest } from '@/api/wx/dscore'
import { listScoreinfo } from '@/api/wx/userScoreInfo'
let option2
export default {
  name:"Index",
  data() {
    return {
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
          data: ['2021', '2021', '2022']
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
            data: [330, 350, 310]
          },
          {
            name: '国家线',
            type: 'line',
            smooth: true,
            data: [348, 360, 346]
          }
        ]
      },
      option2:{
        dataset: {
          source: []
        },
        grid: { containLabel: true },
        xAxis: {
          name: '平均复试线',
          min: function(value) {//取最小值向下取整为最小刻度
            return Math.floor(value.min)-10
          },
          max: function(value) {//取最大值向上取整为最大刻度
            return  Math.ceil(value.max)
          }
        },
        yAxis: { type: 'category' },
        visualMap: {
          orient: 'horizontal',
          left: 'center',
          min: 10,
          max: 100,
          text: ['相对录取难度高', '相对录取难度低'],
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
              y: '大学'
            }
          }
        ]
      },
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
      AllInfoList:[],
      drawer: false,
      eventContent:{
        scoreYear: null,
        scoreAll: 0,
        scoreMath: null,
        scoreEnglish: null,
        scorePolitics: null,
        scoreMajor:null,
        scoreYear2: null,
        scoreAll2: 0,
        scoreMath2: null,
        scoreEnglish2: null,
        scorePolitics2: null,
        scoreMajor2:null,
        scoreYear3: null,
        scoreAll3: 0,
        scoreMath3: null,
        scoreEnglish3: null,
        scorePolitics3: null,
        scoreMajor3:null,
        majorName: null,
        majorType: null,
        majorCode:null,
        departmentName:null,
        schoolName:null,
        schoolType:null,
        schoolLevels:null,
        areaName:null,
        areaType:null
      },
      majorList:[],
      areaOptions:[],
      retestList:[],
      DScoreList:[[],[]],
      nationalList:[
        {
          scoreYear:null,
          scoreEnglish:null,
          scorePolitics: null,
          scoreMath: null,
          scoreMajor:null,
          scoreYear2:null,
          scoreEnglish2:null,
          scorePolitics2: null,
          scoreMath2: null,
          scoreMajor2:null,
          scoreYear3:null,
          scoreEnglish3:null,
          scorePolitics3: null,
          scoreMath3: null,
          scoreMajor3:null,
        },
        {
          scoreYear:null,
          scoreEnglish:null,
          scorePolitics: null,
          scoreMath: null,
          scoreMajor:null,
          scoreYear2:null,
          scoreEnglish2:null,
          scorePolitics2: null,
          scoreMath2: null,
          scoreMajor2:null,
          scoreYear3:null,
          scoreEnglish3:null,
          scorePolitics3: null,
          scoreMath3: null,
          scoreMajor3:null,
        }
      ],
      majorInfo:[],
      majorCascader:[{
        value:1,
        label:"专硕",
        children:[]
      },{
        value:2,
        label:"学硕",
        children:[]
      }]
    };
  },
  created() {
    this.getSList();
    this.getArea();
    this.getRetest();
    this.getUserScoreInfo();
  },
  mounted() {
    this.getList();
    this.getChart();
  },
  methods:{
    /** 查询【请填写功能名称】列表 */
    getSList(){
      this.loading = true;
      listsMajor().then(response => {
        this.majorList = response.rows;
        for (let i=0;i<this.majorList.length;i++){
          if(this.majorList[i].majorType===1)
          {
            this.majorCascader[0].children.push({
              value: this.majorList[i].majorName,
              label: this.majorList[i].majorCode+' '+this.majorList[i].majorName
            })
          }else{
            this.majorCascader[1].children.push({
              value: this.majorList[i].majorName,
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
    getUserScoreInfo() {
      listScoreinfo().then(response => {
        this.majorInfo = response.data;
        if(this.majorInfo===null)
        {
          this.queryParams.majorName="金融"
        }
        else{
          this.queryParams.scoreAll=''+this.majorInfo.scoreAll
          this.queryParams.scoreEnglish=''+this.majorInfo.scoreEnglish
          this.queryParams.scorePolitics=''+this.majorInfo.scorePolitics
          this.queryParams.scoreMath=''+this.majorInfo.scoreMath
          this.queryParams.scoreMajor=''+this.majorInfo.scoreMajor
          this.queryParams.majorName=this.majorInfo.majorName
          this.queryParams.areaName=this.majorInfo.areaName
        }
      });
    },
    getRetest(){
      this.loading = true;
      let query={
        majorName:this.queryParams.majorName
      }
      listRetest(query).then(response => {
        this.retestList = response.rows;
        this.DScoreList[0]=[this.retestList[4].scoreAll,this.retestList[2].scoreAll,this.retestList[0].scoreAll]
        this.DScoreList[1]=[this.retestList[5].scoreAll,this.retestList[3].scoreAll,this.retestList[1].scoreAll]
        this.retestList[0].scoreYear=this.retestList[0].scoreYear+"年A区国家线："+this.retestList[0].scoreAll
        this.retestList[2].scoreYear=this.retestList[2].scoreYear+"年A区国家线："+this.retestList[2].scoreAll
        this.retestList[4].scoreYear=this.retestList[4].scoreYear+"年A区国家线："+this.retestList[4].scoreAll
        this.retestList[1].scoreYear=this.retestList[1].scoreYear+"年B区国家线："+this.retestList[1].scoreAll
        this.retestList[3].scoreYear=this.retestList[3].scoreYear+"年B区国家线："+this.retestList[3].scoreAll
        this.retestList[5].scoreYear=this.retestList[5].scoreYear+"年B区国家线："+this.retestList[5].scoreAll
        this.nationalList[0].scoreYear=this.retestList[0].scoreYear
        this.nationalList[0].scoreEnglish=this.retestList[0].scoreEnglish
        this.nationalList[0].scorePolitics=this.retestList[0].scorePolitics
        this.nationalList[0].scoreMath=this.retestList[0].scoreMath
        this.nationalList[0].scoreMajor=this.retestList[0].scoreMajor
        this.nationalList[0].scoreYear2=this.retestList[2].scoreYear
        this.nationalList[0].scoreEnglish2=this.retestList[2].scoreEnglish
        this.nationalList[0].scorePolitics2=this.retestList[2].scorePolitics
        this.nationalList[0].scoreMath2=this.retestList[2].scoreMath
        this.nationalList[0].scoreMajor2=this.retestList[2].scoreMajor
        this.nationalList[0].scoreYear3=this.retestList[4].scoreYear
        this.nationalList[0].scoreEnglish3=this.retestList[4].scoreEnglish
        this.nationalList[0].scorePolitics3=this.retestList[4].scorePolitics
        this.nationalList[0].scoreMath3=this.retestList[4].scoreMath
        this.nationalList[0].scoreMajor3=this.retestList[4].scoreMajor
        this.nationalList[1].scoreYear=this.retestList[1].scoreYear
        this.nationalList[1].scoreEnglish=this.retestList[1].scoreEnglish
        this.nationalList[1].scorePolitics=this.retestList[1].scorePolitics
        this.nationalList[1].scoreMath=this.retestList[1].scoreMath
        this.nationalList[1].scoreMajor=this.retestList[1].scoreMajor
        this.nationalList[1].scoreYear2=this.retestList[3].scoreYear
        this.nationalList[1].scoreEnglish2=this.retestList[3].scoreEnglish
        this.nationalList[1].scorePolitics2=this.retestList[3].scorePolitics
        this.nationalList[1].scoreMath2=this.retestList[3].scoreMath
        this.nationalList[1].scoreMajor2=this.retestList[3].scoreMajor
        this.nationalList[1].scoreYear3=this.retestList[5].scoreYear
        this.nationalList[1].scoreEnglish3=this.retestList[5].scoreEnglish
        this.nationalList[1].scorePolitics3=this.retestList[5].scorePolitics
        this.nationalList[1].scoreMath3=this.retestList[5].scoreMath
        this.nationalList[1].scoreMajor3=this.retestList[5].scoreMajor
        this.loading = false;
      });
    },
    getChart(){
      let chartDom = document.getElementById('main');
      let myChart = echarts.init(chartDom);
      setTimeout(() =>{
        myChart.on('click', (event)=> {
          this.eventContent.scoreYear=this.AllInfoList[event.value[6]*3].scoreYear+"年复试线："+this.AllInfoList[event.value[6]*3].scoreAll
          this.eventContent.scoreAll=this.AllInfoList[event.value[6]*3].scoreAll
          this.eventContent.scoreMath=this.AllInfoList[event.value[6]*3].scoreMath
          this.eventContent.scoreEnglish=this.AllInfoList[event.value[6]*3].scoreEnglish
          this.eventContent.scorePolitics=this.AllInfoList[event.value[6]*3].scorePolitics
          this.eventContent.scoreMajor=this.AllInfoList[event.value[6]*3].scoreMajor
          this.eventContent.scoreYear2=this.AllInfoList[event.value[6]*3+1].scoreYear+"年复试线："+this.AllInfoList[event.value[6]*3+1].scoreAll
          this.eventContent.scoreAll2=this.AllInfoList[event.value[6]*3+1].scoreAll
          this.eventContent.scoreMath2=this.AllInfoList[event.value[6]*3+1].scoreMath
          this.eventContent.scoreEnglish2=this.AllInfoList[event.value[6]*3+1].scoreEnglish
          this.eventContent.scorePolitics2=this.AllInfoList[event.value[6]*3+1].scorePolitics
          this.eventContent.scoreMajor2=this.AllInfoList[event.value[6]*3+1].scoreMajor
          this.eventContent.scoreYear3=this.AllInfoList[event.value[6]*3+2].scoreYear+"年复试线："+this.AllInfoList[event.value[6]*3+2].scoreAll
          this.eventContent.scoreAll3=this.AllInfoList[event.value[6]*3+2].scoreAll
          this.eventContent.scoreMath3=this.AllInfoList[event.value[6]*3+2].scoreMath
          this.eventContent.scoreEnglish3=this.AllInfoList[event.value[6]*3+2].scoreEnglish
          this.eventContent.scorePolitics3=this.AllInfoList[event.value[6]*3+2].scorePolitics
          this.eventContent.scoreMajor3=this.AllInfoList[event.value[6]*3+2].scoreMajor
          this.eventContent.majorName=this.AllInfoList[event.value[6]*3].majorName
          this.eventContent.majorType=this.AllInfoList[event.value[6]*3].majorType
          this.eventContent.majorCode=this.AllInfoList[event.value[6]*3].majorCode
          this.eventContent.departmentName=this.AllInfoList[event.value[6]*3].departmentName
          this.eventContent.schoolName=this.AllInfoList[event.value[6]*3].schoolName
          this.eventContent.schoolType=this.AllInfoList[event.value[6]*3].schoolType
          this.eventContent.schoolWebsite=this.AllInfoList[event.value[6]*3].schoolWebsite
          this.eventContent.schoolRecruit=this.AllInfoList[event.value[6]*3].schoolRecruit
          this.eventContent.schoolLevels=this.AllInfoList[event.value[6]*3].schoolLevels
          this.eventContent.areaName=this.AllInfoList[event.value[6]*3].areaName
          this.eventContent.areaType=this.AllInfoList[event.value[6]*3].areaType
          this.option.series[0].data=event.value.slice(3,6)
          if(this.eventContent.areaType===1)
            this.option.series[1].data=this.DScoreList[0]
          else
            this.option.series[1].data=this.DScoreList[1]
          this.drawer=true
        });
      });
    },
    getList() {
      this.loading = true
      listAllInfo(this.queryParams).then(response => {
        this.AllInfoList = response.rows
        console.log(this.AllInfoList)
        this.option2.dataset.source = [['推荐指数', '平均复试线', '大学', '分数一', '分数二', '分数三', '编号'], [], [], [], [], [], [], [], [], []]
        this.option.xAxis.data = []
        console.log(this.AllInfoList[0].scoreYear)
        this.option.xAxis.data[0] = this.AllInfoList[0].scoreYear
        this.option.xAxis.data[1] = this.AllInfoList[1].scoreYear
        this.option.xAxis.data[2] = this.AllInfoList[2].scoreYear
        let length=this.AllInfoList.length
        let max,min,differ
        if(length!==0)
        {
          min=(this.AllInfoList[length-1].scoreAll+this.AllInfoList[length-2].scoreAll+this.AllInfoList[length-3].scoreAll)/3
          max=(this.AllInfoList[0].scoreAll+this.AllInfoList[1].scoreAll+this.AllInfoList[2].scoreAll)/3+1
          differ=max-min
        }
        for (let i = 0; i < this.AllInfoList.length; i += 3) {
          this.option2.dataset.source[i / 3 + 1][1] = (this.AllInfoList[i].scoreAll+this.AllInfoList[i+1].scoreAll+this.AllInfoList[i+2].scoreAll)/3
          this.option2.dataset.source[i / 3 + 1][0] = ((this.option2.dataset.source[i / 3 + 1][1]-min)/differ)*100
          this.option2.dataset.source[i / 3 + 1][2] = this.AllInfoList[i].schoolName
          this.option2.dataset.source[i / 3 + 1][3] = this.AllInfoList[i].scoreAll
          this.option2.dataset.source[i / 3 + 1][4] = this.AllInfoList[i + 1].scoreAll
          this.option2.dataset.source[i / 3 + 1][5] = this.AllInfoList[i + 2].scoreAll
          this.option2.dataset.source[i / 3 + 1][6] = i / 3
        }
        this.loading = false
      })
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.$refs["queryForm"].validate(valid => {
        if(valid){
          this.getRetest()
          this.getList()
        }
        else
          this.$modal.msgWarning("信息有误！");
      })
    },
    resetQuery() {
      this.resetForm("queryForm");
      console.log(this.queryParams)
      this.handleQuery();
    },
    majorCascaderChange(){
      this.queryParams.majorName=this.queryParams.majorName[1]
    }
  }
};
</script>

<style lang="scss" scoped>
#main{
  height: 620px;
  width: 100%;
}
#main2{
  left: 5%;
}
</style>

