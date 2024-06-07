<template>
  <div>
    <el-dialog :title="title" :visible.sync="open" width="90%" append-to-body>
       <div style="margin-bottom: 30px;font-size: 18px;">
         <font>以下为推荐院校的AI分析：</font>
       </div>
      <el-card class="card" v-loading="loading">
        <div style="width: 100%;height:30px;display: flex;justify-content: space-around;border-bottom: 1px solid black">
          <div v-for="(item,index) in schools">
            <el-link type="primary" @click="analysis(item,index)"><font>{{item}}</font></el-link>
          </div>
        </div>
        <div style="padding-top: 10px;">
          <font>{{schoolName}}：</font>
          <div style="padding: 0 10px 0 10px;">
            <p>
              <font>
                {{schoolInfo}}
              </font>
            </p>
            <p style="padding-bottom: 10px;">
              <el-button type="primary" round style="float: right;" @click="openDrawer()">了解学校详情</el-button>
            </p>
          </div>
        </div>
      </el-card>
      <el-divider>学校点评</el-divider>
      <el-card class="card" v-loading="loading">
          <p>
            <font>
              {{conclusion}}
            </font>
          </p>
      </el-card>
    </el-dialog>

    <school-dialog ref="homePageSchoolDialog"></school-dialog>
  </div>
</template>

<script>
import SchoolDialog from '@/views/user/schoolDialog/schoolDialog.vue'
import { analysis } from '@/api/wx/analysis'

export default {
  name: 'analysis',
  components: { SchoolDialog },
  data(){
    return{
      title:"学校情况AI分析",
      open:false,
      // majorName:"金融",
      schools:[],
      schoolIds:[],
      schoolName:"中山大学",
      schoolInfo:"",
      conclusion:"",
      loading:true,
      major:"",
      // majorId:"",
      score:null,
      currentIndex:0
    }
  },
  created() {
    this.openAnalysis()
  },
  methods:{
    async openAnalysis(){
      this.$on("analysis", item=>{
        this.schoolInfo=""
        this.conclusion=""
        this.schoolName=item.schools[0]
        this.open=true
        this.schools=item.schools
        this.schoolIds=item.schoolIds
        this.score=item.score
        this.major=item.major
        // this.majorId=item.majorId
        // this.getConclusion()
        this.analysis(item.schools[0],0)
        // this.getSchoolInfo(this.schoolName,item.schoolId)
      })
    },
    // getConclusion(){
    //   this.loading = true;
    //   analysis({score:this.score,major:this.major,schools:this.schools}).then(response=>{
    //     console.log(response)
    //     if(response.code===200){
    //       this.schoolInfo=response.data.intro
    //       this.conclusion=response.data.analysis
    //       this.loading=false
    //     }
    //   })
    // },
    analysis(schoolName,index) {
      this.loading = true;
      analysis({schoolName:schoolName}).then(response=>{
        if(response.code===200){
          this.schoolName=schoolName
          this.schoolInfo=response.data.intro
          this.conclusion=response.data.analysis
          this.currentIndex=index
          this.loading=false
        }
      })
    },
    openDrawer(){
      this.$refs.homePageSchoolDialog.$emit('schoolDialogShow',this.schoolIds[this.currentIndex])
    },
  }
}
</script>

<style scoped>
::v-deep .el-dialog{
  border-radius: 25px;
}
::v-deep .el-dialog__header {

  background-color: rgb(73,162,255);
  border-top-left-radius: 25px;
  border-top-right-radius: 25px;
}
::v-deep .el-dialog__title {
  font-size: 24px;
  color: white ;
  font-weight: bold;
}
.card{
  margin-bottom: 10px;
  border-radius: 25px;
}
font{
  font-weight: bold;
}
</style>
