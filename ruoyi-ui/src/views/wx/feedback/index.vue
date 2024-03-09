<template>
  <div class="app-container">
    <el-card class="card">
      <h1>用户调剂反馈</h1>
      <hr style="color: #c2fcee;">
      <el-form ref="queryForm" :model="form" size="small" label-width="80px" >
        <el-form-item label="满意程度" prop="satisfaction">
            <el-rate
              style="margin-top: 8px"
              v-model="form.satisfaction"
              show-text
              :colors="colors">
            </el-rate>
        </el-form-item>
        <el-form-item label="调剂情况" prop="action">
          <el-input type="textarea" :rows="10" v-model="form.action" style="font-size:15px;font-family: 'Arial Unicode MS';" :maxlength="255" show-word-limit></el-input>
        </el-form-item>
        <el-form-item label="您的建议" prop="suggest">
          <el-input type="textarea" :rows="10" v-model="form.suggest" style="font-size:15px;font-family: 'Arial Unicode MS';" :maxlength="255" show-word-limit></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="onSubmit">提交</el-button>
          <el-button @click="reset">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script>
import { addFeedback } from '@/api/wx/feedback'
import { background } from 'quill/ui/icons'

export default {
  name: "feedback",
  data() {
    return {
      colors: ['#e3d486', '#f8cb5e', '#FF9900'],
      form: {
        user:null,
        satisfaction:null,
        action:null,
        suggest:null
      },
      url:"https://img1.baidu.com/it/u=773312573,3382853057&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=500"
    }
  },
  methods:{
    background,
    onSubmit() {
      if(this.form.satisfaction!==0&&this.form.action!==null&&this.form.suggest!==null){
        addFeedback(this.form).then(response => {
          this.$message.success('提交成功，感谢您的反馈！')
          this.reset()
        });
      }
      else {
        this.$message.warning('信息未填写完整')
      }
    },
    reset() {
      this.resetForm("queryForm");
    },
  }
};
</script>
<style lang="scss" scoped>
h1{
  font-size: 30px;
  background-image: -webkit-linear-gradient(left, #147B96, #E6D205 25%, #147B96 50%, #E6D205 75%, #147B96);
  -webkit-text-fill-color: transparent;
  -webkit-background-clip: text;
  -webkit-background-size: 200% 100%;
}
.card{
  background-image: url("../../../assets/images/bg3.jpg");
  background-size: 100%;
  border-radius: 25px;
  box-shadow: rgb(146, 161, 159) 0px 1px 2px, rgb(253, 238, 187) 0px 2px 4px, rgb(194, 252, 238) 0px 4px 8px, rgb(194, 231, 252) 0px 8px 16px, rgba(0, 0, 0, 0.07) 0px 16px 32px, rgba(0, 0, 0, 0.07) 0px 32px 64px;
}
</style>
