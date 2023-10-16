<template>
  <div class="app-container">
    <el-row :gutter="20">
      <el-col :span="6" :xs="24">
        <el-card class="box-card">
          <div slot="header" class="clearfix">
            <span>个人信息</span>
          </div>
          <div>
            <div class="text-center">
              <userAvatar :user="user" />
            </div>
            <ul class="list-group list-group-striped">
              <li class="list-group-item">
                <svg-icon icon-class="user" />用户名称
                <div class="pull-right">{{ user.userName }}</div>
              </li>
              <li class="list-group-item">
                <svg-icon icon-class="phone" />手机号码
                <div class="pull-right">{{ user.phonenumber }}</div>
              </li>
              <li class="list-group-item">
                <svg-icon icon-class="email" />用户邮箱
                <div class="pull-right">{{ user.email }}</div>
              </li>
<!--              <li class="list-group-item">
                <svg-icon icon-class="tree" />所属部门
                <div class="pull-right" v-if="user.dept">{{ user.dept.deptName }} / {{ postGroup }}</div>
              </li>-->
              <li class="list-group-item">
                <svg-icon icon-class="peoples" />所属角色
                <div class="pull-right">{{ roleGroup }}</div>
              </li>
              <li class="list-group-item">
                <svg-icon icon-class="date" />创建日期
                <div class="pull-right">{{ user.createTime }}</div>
              </li>
            </ul>
          </div>
        </el-card>
      </el-col>
      <el-col :span="18" :xs="24">
        <el-card>
          <div slot="header" class="clearfix">
            <span>基本资料</span>
          </div>
          <el-tabs v-model="activeTab">
            <el-tab-pane label="基本资料" name="userinfo">
              <userInfo :user="user" />
            </el-tab-pane>
            <el-tab-pane label="考研信息" name="scoreInfo">
              <scoreInfo :majorInfo="majorInfo"/>
            </el-tab-pane>
            <el-tab-pane label="修改密码" name="resetPwd">
              <resetPwd />
            </el-tab-pane>
          </el-tabs>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import userAvatar from "./userAvatar";
import userInfo from "./userInfo";
import resetPwd from "./resetPwd";
import scoreInfo from "./scoreInfo";
import { getUserProfile } from "@/api/system/user";
import { listScoreinfo } from '@/api/wx/userScoreInfo'
export default {
  name: "Profile",
  components: { userAvatar, userInfo, resetPwd, scoreInfo },
  data() {
    return {
      user: {},
      roleGroup: {},
      postGroup: {},
      majorInfo:{},
      activeTab: "userinfo"
    };
  },
  created() {
    this.getUser();
    this.getUserScoreInfo()
  },
  methods: {
    getUser() {
      getUserProfile().then(response => {
        this.user = response.data;
        this.roleGroup = response.roleGroup;
        this.postGroup = response.postGroup;
      });
    },
    getUserScoreInfo() {
      listScoreinfo().then(response => {
        if(response.data===undefined)
        {
          this.majorInfo = {}
          this.majorInfo.majorName="金融"
        }
        else{
          this.majorInfo=response.data
          this.majorInfo.scoreAll=''+this.majorInfo.scoreAll
          this.majorInfo.scoreEnglish=''+this.majorInfo.scoreEnglish
          this.majorInfo.scorePolitics=''+this.majorInfo.scorePolitics
          this.majorInfo.scoreMath=''+this.majorInfo.scoreMath
          this.majorInfo.scoreMajor=''+this.majorInfo.scoreMajor
        }
      });
    }
  }
};
</script>
