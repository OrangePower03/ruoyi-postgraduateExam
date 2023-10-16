<template>
  <el-form ref="form" :model="majorInfo" :rules="rules" label-width="80px">
    <el-form-item label="初试分数" prop="scoreAll">
      <el-input v-model="majorInfo.scoreAll" :maxlength="3" show-word-limit clearable />
    </el-form-item>
    <el-form-item label="英语分数" prop="scoreEnglish">
      <el-input v-model="majorInfo.scoreEnglish" :maxlength="3" show-word-limit clearable />
    </el-form-item>
    <el-form-item label="政治分数" prop="scorePolitics">
      <el-input v-model="majorInfo.scorePolitics" :maxlength="3" show-word-limit clearable />
    </el-form-item>
    <el-form-item label="专业一" prop="scoreMath">
      <el-input v-model="majorInfo.scoreMath" :maxlength="3" show-word-limit clearable />
    </el-form-item>
    <el-form-item label="专业二" prop="scoreMajor">
      <el-input v-model="majorInfo.scoreMajor" :maxlength="3" show-word-limit clearable />
    </el-form-item>
    <el-form-item label="理想专业" prop="majorName">
      <el-cascader v-model="majorInfo.majorName" :options="majorCascader" @change="majorCascaderChange" :style="{width: '100%'}"></el-cascader>
    </el-form-item>
    <el-form-item label="理想地区" prop="areaName">
      <el-select v-model="majorInfo.areaName" placeholder="请选择学校所在地区" filterable clearable :style="{width: '100%'}" @keyup.enter.native="handleQuery">
        <el-option v-for="(item, index) in areaOptions" :key="index" :label="item.areaName"
                   :value="item.areaName" :disabled="item.disabled"></el-option>
      </el-select>
    </el-form-item>
    <el-form-item>
      <el-button type="primary" size="mini" @click="submit">保存</el-button>
      <el-button type="danger" size="mini" @click="close">关闭</el-button>
    </el-form-item>
  </el-form>
</template>

<script>
import { listsMajor } from '@/api/wx/major'
import { listArea } from '@/api/wx/school'
import { updateScoreinfo } from '@/api/wx/userScoreInfo'

export default {
  props: {
    majorInfo: {
      type: Object
    }
  },
  data() {
    return {
      // 表单校验
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
          { message: "专业不能为空",trigger: "blur"},
        ]
      },
      majorList:[],
      areaOptions:[],
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
    this.getArea()
    this.getSList()
  },
  methods: {
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
    submit() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          updateScoreinfo(this.majorInfo).then(response => {
            this.$modal.msgSuccess("修改成功");
          });
        }else{
          this.$modal.msgWarning("信息有误");
        }
      });
    },
    close() {
      this.$tab.closePage();
    },
    majorCascaderChange(){
      this.majorInfo.majorName=this.majorInfo.majorName[1]
    }
  }
};
</script>
