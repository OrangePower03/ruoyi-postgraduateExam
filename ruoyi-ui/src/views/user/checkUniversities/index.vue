<template>
  <div class="app-container">
    <el-form ref="form" :model="form" :inline="true" label-width="80px">
      <el-form-item label="学校名称">
        <el-input v-model="form.schoolName" placeholder="请输入学院名称" maxlength="20"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="onSubmit">查询</el-button>
      </el-form-item>
    </el-form>

    <div class="schoolPosition">
      <span class="leftFont">院校位置</span>
      <el-radio-group v-model="positionItem" size="mini" @change="positionEvent">
        <el-radio-button v-for="city in all" :label="city" :key="city">{{city}}</el-radio-button>
      </el-radio-group>
      <div class="right">
        <div class="rightSection1">
          <el-tag type="danger" class="fontStyle2">A区</el-tag>
          <el-radio-group v-model="positionItem" size="small" @change="positionEvent">
            <el-radio-button v-for="city in areaA" :label="city" :key="city">{{city}}</el-radio-button>
          </el-radio-group>
        </div>
        <div class="rightSection2">
          <el-tag class="fontStyle2">B区</el-tag>
          <el-radio-group v-model="positionItem" size="small" @change="positionEvent">
            <el-radio-button v-for="city in areaB" :label="city" :key="city">{{city}}</el-radio-button>
          </el-radio-group>
        </div>
      </div>
    </div>

    <div class="schoolLevel">
      <div class="rightSection1_2">
        <span class="font_2">院校层次</span>
        <el-radio-group class="allItem" v-model="levelItem" size="small" @change="levelEvent">
          <el-radio-button v-for="city in all" :label="city" :key="city">{{city}}</el-radio-button>
        </el-radio-group>
        <el-radio-group v-model="levelItem" size="small" @change="levelEvent">
          <el-radio-button v-for="city in level" :label="city" :key="city">{{city}}</el-radio-button>
        </el-radio-group>
      </div>
      <div class="rightSection2_2">
        <span class="font_2">自划线类型</span>
        <el-radio-group class="allItem" v-model="isItem" size="small" @change="isEvent">
          <el-radio-button v-for="city in all" :label="city" :key="city">{{city}}</el-radio-button>
        </el-radio-group>
        <el-radio-group v-model="isItem" size="small" @change="isEvent">
          <el-radio-button v-for="city in is" :label="city" :key="city">{{city}}</el-radio-button>
        </el-radio-group>
      </div>
    </div>

    <div class="schoolList">
      <el-table v-loading="loading" :data="schoolList">
        <el-table-column label="学校名称" align="center" prop="schoolName" />
        <el-table-column label="学校位置" align="center" prop="areaName" />
        <el-table-column label="学校层次" align="center" prop="schoolLevels" >
          <template slot-scope="scope">
            <el-tag v-if="scope.row.schoolLevels===1">985，211，双一流</el-tag>
            <el-tag v-else-if="scope.row.schoolLevels===2">211，双一流</el-tag>
            <el-tag v-else-if="scope.row.schoolLevels===3">双一流</el-tag>
            <el-tag v-else-if="scope.row.schoolLevels===4">普通院校</el-tag>
            <el-tag v-else-if="scope.row.schoolLevels===5">科研院所</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="自划线" align="center" prop="schoolType" >
          <template slot-scope="scope">
            <el-tag v-if="scope.row.schoolType===1" type="success">是</el-tag>
            <el-tag v-else-if="scope.row.schoolType===2" type="warning">否</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
          <template slot-scope="scope">
            <el-button
              size="mini"
              type="text"
              icon="el-icon-search"
              @click="changeSchoolShow(scope.row.schoolId)"
              v-hasPermi="['user:school:list']"
            >查看</el-button>
          </template>
        </el-table-column>
      </el-table>

      <pagination
        v-show="total>0"
        :total="total"
        :page.sync="form.pageNum"
        :limit.sync="form.pageSize"
        @pagination="getList"
      />
    </div>

    <school-dialog ref="schoolDialog"></school-dialog>

  </div>
</template>

<script>
import SchoolDialog from '@/views/user/schoolDialog/schoolDialog.vue'
import { listSchool } from '@/api/wx/school'

export default {
  name: 'index',
  components: { SchoolDialog },
  data() {
    return {
      form: {
        pageNum: 1,
        pageSize: 10,
        schoolName: null,
        areaName:null,
        schoolLevels:null,
        schoolType:null
      },
      all:["全部"],
      areaA:["北京","天津","河北","山西","辽宁","吉林","黑龙江","上海","江苏","浙江","安徽","福建","江西","山东","河南","湖北","湖南","广东","重庆","四川","陕西"],
      areaB:["内蒙古","广西","海南","贵州","云南","西藏","甘肃","青海","宁夏","新疆"],
      level:["985、211、双一流","211、双一流","双一流","双一流","普通高校"],
      is:["是","否"],
      positionItem:"全部",
      levelItem:"全部",
      isItem:"全部",
      // 遮罩层
      loading: false,
      // 总条数
      total: 0,
      // 导师表表格数据
      schoolList: []
    }
  },
  created() {
    this.getList()
  },
  methods: {
    onSubmit() {
      this.getList()
    },
    positionEvent(event){
      if(this.positionItem==="全部")
        this.form.areaName=null
      else
        this.form.areaName=event
      this.form.pageNum=1
      this.getList()
    },
    levelEvent(event){
      if(this.levelItem==="全部")
        this.form.schoolLevels=null
      else
        for(let i=0;i<this.level.length;i++)
          if(this.level[i]===event)
            this.form.schoolLevels=i+1
      this.form.pageNum=1
      this.getList()
    },
    isEvent(event){
      if(this.isItem==="全部")
        this.form.schoolType=null
      else
        for(let i=0;i<this.is.length;i++)
          if(this.is[i]===event)
            this.form.schoolType=i+1
      this.form.pageNum=1
      this.getList()
    },
    getList(){
      this.loading = true;
      listSchool(this.form).then(response => {
        this.schoolList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    changeSchoolShow(id){
      this.$refs.schoolDialog.$emit('schoolDialogShow',id)
    }
  }
}
</script>

<style lang="scss" scoped>
  .schoolPosition{
    display: flex;
    .leftFont{
      font-size: 14px;
      font-weight: bold;
      color: rgb(96, 98, 102);
      margin: 7px 12px 0 12px;
    }
    .right{
      margin-left: 12px;
      display: flex;
      flex-direction: column;
      .rightSection1{
        display: flex;
      }
      .rightSection2{
        display: flex;
        margin-top: 20px;
      }
      .fontStyle2{
        margin-right: 12px;
      }
    }
  }

  .schoolLevel{
    margin-top: 20px;
    display: flex;
    .font_2{
      font-size: 14px;
      font-weight: bold;
      color: rgb(96, 98, 102);
      margin: 7px 12px 0 12px;
    }
    .allItem{
      margin-right: 12px;
    }
    .rightSection2_2{
        margin-left: 20px;
    }
  }

  .schoolList{
    margin-top: 20px;
  }

</style>
