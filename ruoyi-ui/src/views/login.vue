<template>
  <div class="login">
    <el-form ref="loginForm" :model="loginForm" :rules="loginRules" class="login-form">
      <h3 class="title">一研为定</h3>
      <el-form-item prop="username">
        <el-input
          v-model="loginForm.username"
          type="text"
          auto-complete="off"
          placeholder="账号"
        >
          <svg-icon slot="prefix" icon-class="user" class="el-input__icon input-icon" />
        </el-input>
      </el-form-item>
      <el-form-item prop="password">
        <el-input
          v-model="loginForm.password"
          type="password"
          auto-complete="off"
          placeholder="密码"
          @keyup.enter.native="handleLogin"
        >
          <svg-icon slot="prefix" icon-class="password" class="el-input__icon input-icon" />
        </el-input>
      </el-form-item>
      <el-form-item prop="code" v-if="captchaEnabled">
        <el-input
          v-model="loginForm.code"
          auto-complete="off"
          placeholder="验证码"
          style="width: 63%"
          @keyup.enter.native="handleLogin"
        >
          <svg-icon slot="prefix" icon-class="validCode" class="el-input__icon input-icon" />
        </el-input>
        <div class="login-code">
          <img :src="codeUrl" @click="getCode" class="login-code-img"/>
        </div>
      </el-form-item>
      <el-checkbox v-model="loginForm.rememberMe" style="margin:0px 0px 25px 0px;">
        <h4 class="title">记住密码</h4>
      </el-checkbox>
      <el-form-item style="width:100%;">
        <el-button
          class="longButton"
          :loading="loading"
          size="medium"
          style="width:100%;"
          @click.native.prevent="handleLogin"
        >
          <span v-if="!loading">登录</span>
          <span v-else>登 录 中...</span>
        </el-button>
        <div style="float: right;" v-if="register">
          <router-link class="link-type" :to="'/register'">立即注册</router-link>
        </div>
      </el-form-item>
    </el-form>
    <!--  底部  -->
    <div class="el-login-footer">
      <span>考研加油,愿披星戴月的你,终能凯旋！</span>
    </div>
  </div>
</template>

<script>
import { getCodeImg } from "@/api/login";
import Cookies from "js-cookie";
import { encrypt, decrypt } from '@/utils/jsencrypt'

export default {
  name: "Login",
  data() {
    return {
      codeUrl: "",
      loginForm: {
        username: "",
        password: "",
        rememberMe: false,
        code: "",
        uuid: ""
      },
      loginRules: {
        username: [
          { required: true, trigger: "blur", message: "请输入您的账号" }
        ],
        password: [
          { required: true, trigger: "blur", message: "请输入您的密码" }
        ],
        code: [{ required: true, trigger: "change", message: "请输入验证码" }]
      },
      loading: false,
      // 验证码开关
      captchaEnabled: true,
      // 注册开关
      register: true,
      redirect: undefined
    };
  },
  watch: {
    $route: {
      handler: function(route) {
        this.redirect = route.query && route.query.redirect;
      },
      immediate: true
    }
  },
  created() {
    this.getCode();
    this.getCookie();
  },
  methods: {
    getCode() {
      getCodeImg().then(res => {
        this.captchaEnabled = res.captchaEnabled === undefined ? true : res.captchaEnabled;
        if (this.captchaEnabled) {
          this.codeUrl = "data:image/gif;base64," + res.img;
          this.loginForm.uuid = res.uuid;
        }
      });
    },
    getCookie() {
      const username = Cookies.get("username");
      const password = Cookies.get("password");
      const rememberMe = Cookies.get('rememberMe')
      this.loginForm = {
        username: username === undefined ? this.loginForm.username : username,
        password: password === undefined ? this.loginForm.password : decrypt(password),
        rememberMe: rememberMe === undefined ? false : Boolean(rememberMe)
      };
    },
    handleLogin() {
      this.$refs.loginForm.validate(valid => {
        if (valid) {
          this.loading = true;
          if (this.loginForm.rememberMe) {
            Cookies.set("username", this.loginForm.username, { expires: 30 });
            Cookies.set("password", encrypt(this.loginForm.password), { expires: 30 });
            Cookies.set('rememberMe', this.loginForm.rememberMe, { expires: 30 });
          } else {
            Cookies.remove("username");
            Cookies.remove("password");
            Cookies.remove('rememberMe');
          }
          this.$store.dispatch("Login", this.loginForm).then(() => {
            this.$router.push({ path: this.redirect || "/" }).catch(()=>{});
          }).catch(() => {
            this.loading = false;
            if (this.captchaEnabled) {
              this.getCode();
            }
          });
        }
      });
    }
  }
};
</script>

<style rel="stylesheet/scss" lang="scss">
.login {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
  background-image: url("../assets/images/background3.jpg");
  background-size: cover;
}
.title {
  margin: 0px auto 30px auto;
  text-align: center;
  color: #ffffff;
}

.login-form {
  border-radius: 10px;
  border: 3px double #795C5CFF;
  background: rgb(0, 0, 0,0.5);
  width: 400px;
  padding: 25px 25px 5px 25px;
  .el-input {
    height: 38px;
    input {
      height: 38px;
    }
  }
  .input-icon {
    height: 39px;
    width: 14px;
    margin-left: 2px;
  }
}
.login-tip {
  font-size: 13px;
  text-align: center;
  color: #bfbfbf;
}
.login-code {
  width: 33%;
  height: 38px;
  float: right;
  img {
    cursor: pointer;
    vertical-align: middle;
    border:3px double #92a19f;
    border-radius: 6px;
  }
}
.longButton{
  background: rgb(247,150,192);
  background: radial-gradient(circle, rgb(231, 141, 141) 0%, rgb(194, 252, 238) 100%);
  line-height: 42px;
  padding: 0;
  border: none;
}
.longButton:before,
.longButton:after {
  position: absolute;
  content: "";
  height: 0;
  width: 1px;
}
.longButton:before {
  right: 0;
  top: 0;
  transition: all 500ms ease;
}
.btn-6:after {
  left: 0;
  bottom: 0;
  transition: all 500ms ease;
}
.longButton:hover{
  background: #c2e7fc;
  color: #e59090;
  box-shadow: none;
}
.longButton:hover:before {
  transition: all 500ms ease;
  height: 100%;
}
.longButton:hover:after {
  transition: all 500ms ease;
  height: 100%;
}
.longButton span:before,
.longButton span:after {
  position: absolute;
  content: "";
  box-shadow:
    -1px -1px 20px 0px rgb(246, 253, 187),
    -4px -4px 5px 0px rgb(246, 253, 187),
    7px 7px 20px 0px rgb(194, 252, 238),
    4px 4px 5px 0px rgb(194, 252, 238);
}
.longButton span:before {
  left: 0;
  top: 0;
  width: 0;
  height: .5px;
  transition: all 500ms ease;
}
.longButton span:after {
  right: 0;
  bottom: 0;
  width: 0;
  height: .5px;
  transition: all 500ms ease;
}
.longButton span:hover:before {
  width: 100%;
}
.longButton span:hover:after {
  width: 100%;
}
.el-login-footer {
  line-height: 40px;
  position: fixed;
  bottom: 0;
  width: 100%;
  text-align: center;
  color: #fff;
  font-family: Arial;
  font-weight: bold;
  font-size: 12px;
  letter-spacing: 1px;
  text-shadow: 0 0 10px #000000,0 0 20px #ff9d9d,0 0 30px #00ffff,0 0 40px #00e7ff;
}
.login-code-img {
  height: 38px;
}
.link-type{
  color: #ffffff;
  text-shadow: 0 0 10px black,0 0 20px black,0 0 30px paleturquoise,0 0 40px powderblue;
}
</style>
