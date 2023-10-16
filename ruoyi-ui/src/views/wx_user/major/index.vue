<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="专业代码" prop="majorCode">
        <el-input
          v-model="queryParams.majorCode"
          placeholder="请输入专业代码"
          clearable
          :maxlength="20" show-word-limit
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="专业名称" prop="majorName">
        <el-input
          v-model="queryParams.majorName"
          placeholder="请输入专业名称"
          clearable
          :maxlength="20" show-word-limit
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="所在学校" prop="schoolType">
        <el-select v-model="queryParams.majorSchoolName" filterable clearable placeholder="请选择院系所在的学校" @change="schoolChange" @keyup.enter.native="handleQuery">
          <el-option
            v-for="item in schoolList"
            :key="item.schoolId"
            :label="item.schoolName"
            :value="item.schoolName">
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="所在学院" prop="majorDepartmentId">
        <el-select v-model="queryParams.majorDepartmentName" placeholder="请输入专业所在学院" filterable clearable :style="{width: '100%'}" value-key="departmentId" @change="departmentChange($event)" @keyup.enter.native="handleQuery">
          <el-option v-for="item in DepartmentList" :key="item.departmentId" :label="item.schoolName+' '+item.departmentName"
                     :value="item" :disabled="item.disabled"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="专业类型" prop="majorType">
        <el-select v-model="queryParams.majorType" placeholder="请选择该专业的类型" filterable clearable :style="{width: '100%'}" @keyup.enter.native="handleQuery">
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
      <el-table-column label="专业代码" align="center" prop="majorCode" />
      <el-table-column label="专业名称" align="center" prop="majorName" />
      <el-table-column label="专业所在学院" align="center" prop="majorDepartmentName" />
      <el-table-column label="专业所在学校" align="center" prop="majorSchoolName" />
      <el-table-column label="专业类型" align="center" prop="majorType" >
        <template slot-scope="scope">
          <el-tag v-if="scope.row.majorType===1">专硕</el-tag>
          <el-tag v-else>学硕</el-tag>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />
  </div>
</template>

<script>
import {
  listsMajor,
  listMajor,
  listDepartment,
} from '@/api/wx/major'
import { listSchool } from '@/api/wx/department'

export default {
  name: "Major",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 【请填写功能名称】表格数据
      majorList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        majorId:null,
        majorCode:null,
        majorName: null,
        majorDepartmentId: null,
        majorDepartmentName:null,
        majorSchoolName:null,
        majorType: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        majorId: [
          { required: true, message: "专业名称不能为空", trigger: "blur" }
        ],
        departmentId: [
          { required: true, message: "院系不能为空", trigger: "blur" }
        ]
      },
      DepartmentList:[],
      sMajorList:[],
      schoolList:[],
      majorTypeList:[{ name:"专硕",value:1},{name:"学硕",value:2}],
      type:0
    };
  },
  created() {
    this.getList();
    this.getDepartmentList();
    this.getSList();
    this.getSchool()
  },
  methods: {
    /** 查询【请填写功能名称】列表 */
    getList() {
      this.loading = true;
      listMajor(this.queryParams).then(response => {
        this.majorList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    getSList(){
      this.loading = true;
      listsMajor().then(response => {
        this.sMajorList = response.rows;
        console.log(response.rows)
        this.loading = false;
      });
    },
    getDepartmentList() {
      this.loading = true;
      listDepartment().then(response => {
        this.DepartmentList = response.rows;
        console.log(this.DepartmentList)
        this.loading = false;
      });
    },
    getSchool(){
      this.loading = true;
      listSchool().then(response => {
        this.schoolList = response.rows;
        this.loading = false;
      });
    },
    departmentChange(value){
      this.queryParams.majorDepartmentName=value.departmentName
      this.queryParams.majorSchoolName=value.schoolName
    },
    schoolChange(){
      this.queryParams.majorDepartmentName=null
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        majorId: null,
        majorName: null,
        majorDepartmentId: null,
        majorType: null,
        connectId:null,
      };
      this.resetForm("form");
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    }
  }
};
</script>
