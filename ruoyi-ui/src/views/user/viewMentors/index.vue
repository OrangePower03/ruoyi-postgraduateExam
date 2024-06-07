<template>
  <div class="app-container">
    <div v-if="teaCherShow">
      <el-form :model="form" ref="queryForm" size="small" :inline="true" label-width="68px">
        <el-form-item label="导师姓名" prop="teacherName">
          <el-input
            v-model="form.teacherName"
            placeholder="请输入导师姓名"
            clearable
            @keyup.enter.native="handleQuery"
          />
        </el-form-item>
        <el-form-item label="导师职称" prop="teacherPosition">
          <el-select v-model="form.teacherPosition" placeholder="请选择导师职称" clearable @keyup.enter.native="handleQuery">
            <el-option
              v-for="dict in dict.type.user_teacher_position"
              :key="dict.value"
              :label="dict.label"
              :value="dict.value"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="所在学校" prop="schoolName">
          <el-input
            v-model="form.schoolName"
            placeholder="请输入所在学校"
            clearable
            @keyup.enter.native="handleQuery"
          />
        </el-form-item>
        <el-form-item label="所在学院" prop="departmentId">
          <el-input
            v-model="form.departmentId"
            placeholder="请输入所在学院"
            clearable
            @keyup.enter.native="handleQuery"
          />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
          <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
        </el-form-item>
      </el-form>

      <div class="cardWin" v-loading="loading">
        <el-divider content-position="center" v-if="teacherList.length===0">暂无数据</el-divider>
        <div class="cardList" v-for="(item,index) in teacherList" :key="index">
          <el-card class="card">
            <el-image class="cardImage" :src="item.teacherImage"></el-image>
            <div class="cardContent">
              <div class="cardTop">
                <span class="cardSpan">{{item.schoolName+' '+item.teacherName}}</span>
                <dict-tag :options="dict.type.user_teacher_position" :value="item.teacherPosition"/>
              </div>
              <div class="cardMiddle">
                <time class="cardInfo">{{ item.teacherDirection }}</time>
                <div class="cardBottom">
                  <el-button type="text" @click="showComment(item)">评价</el-button>
                  <el-link :href="item.teacherLink" type="primary" target="_blank">查看详情</el-link>
                </div>
              </div>
            </div>
          </el-card>
        </div>
      </div>

      <pagination
        v-show="total>0"
        :total="total"
        :page.sync="form.pageNum"
        :limit.sync="form.pageSize"
        @pagination="getList"
      />
    </div>

    <div v-else>
      <el-scrollbar style="height:644px;width:100%;margin-bottom: 10px">
        <el-button icon="el-icon-arrow-left" size="mini" @click="teaCherShow=true">返回</el-button>
        <el-divider content-position="center">{{currentTeacherName}}老师评论区</el-divider>
        <div style="padding: 20px;width: 100%">
          <el-divider content-position="center" v-if="commentList.length===0">暂无评论</el-divider>
          <el-timeline v-loading="loading">
            <el-timeline-item v-for="item in commentList" :timestamp="item.commentDate" placement="top">
              <el-card>
                <h4><span style="font-weight: bold;">{{item.userName}}:</span>{{' '+item.commentContent}}</h4>
              </el-card>
            </el-timeline-item>
          </el-timeline>
          <pagination
            v-show="commentTotal>0"
            :total="commentTotal"
            :page.sync="commentForm.pageNum"
            :limit.sync="commentForm.pageSize"
            @pagination="getCommentList"
          />
        </div>
      </el-scrollbar>

      <div style="display: flex;margin: auto">
        <el-input
          v-model="commentForm.commentContent"
          type="textarea"
          maxlength="255"
          :rows="7"
          resize="none"
          show-word-limit
          placeholder="请输入内容"
        >
        </el-input>
        <el-button style="margin-left: 5px" type="primary" plain @click="addComment">发送</el-button>
      </div>
    </div>

  </div>
</template>

<script>
import { listTeacher } from '@/api/wx/teacher'
import { listComment ,addComment } from '@/api/wx/comment'

export default {
  name: 'index',
  dicts:['user_teacher_position'],
  data(){
    return{
      form: {
        pageNum: 1,
        pageSize: 10,
        schoolName: null,
        departmentName:null
      },
      commentForm:{
        pageNum: 1,
        pageSize: 10,
        commentContent:null,
        teacherId: null,
      },
      currentTeacherName:null,
      teaCherShow:true,
      total:0,
      commentTotal:0,
      teacherList:[],
      commentList:[],
      // 总行数
      titleTotal: 50,
      // 总行数
      rowTotal: 200,
      loading:true
    }
  },
  created() {
    this.getList()
  },

  methods:{
    /** 搜索按钮操作 */
    handleQuery() {
      this.form.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.form={
        pageNum: 1,
        pageSize: 10,
        schoolName: null,
        departmentName:null
      }
      this.handleQuery();
    },
    onSubmit(){

    },
    getList() {
      this.loading = true;
      listTeacher(this.form).then(response => {
        this.teacherList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    getCommentList() {
      this.loading = true;
      listComment(this.commentForm).then(response => {
        this.commentList = response.rows;
        this.commentTotal = response.total;
        this.loading = false;
        this.teaCherShow=false
      });
    },
    showComment(item){
      this.commentForm.teacherId=item.teacherId;
      this.currentTeacherName=item.teacherName
      this.getCommentList()
    },
    addComment(){
      addComment(this.commentForm).then(response => {
        this.$modal.msgSuccess("评论成功");
        this.commentForm.commentContent=null
        this.getCommentList();
      });
    }
  }
}
</script>

<style lang="scss" scoped>

.cardWin{
  display: flex; flex-wrap: wrap;
  overflow: auto;
  height: 680px;
  .cardList{
    flex-basis: calc(20% - 12px);
    margin-right: 12px;
    .card{
      margin: 0 0 12px 12px;
      width: 100%;
      height: 500px;
      background: rgb(210,210,210,0.1);
      .cardImage{
        width: 100%;
      }
      .cardContent{
        padding: 14px;
        .cardTop{
          display: flex;
          justify-content: space-between;
          align-items: center;
        }
        .cardSpan{
          font-size: 13px;
          font-weight: bold;
        }
        .cardMiddle{
          margin-top: 13px;
          line-height: 12px;
          .cardInfo{
            font-size: 13px;
            color: #999;
          }
          .cardBottom{
            margin-top: 5px;
            display: flex;
            justify-content: space-between;
          }
        }
      }
    }
  }
}

.el-scrollbar__wrap {
  overflow-x: hidden;
}

</style>
