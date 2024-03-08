<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="学院名称" prop="departmentName">
        <el-input
          v-model="queryParams.departmentName"
          placeholder="请输入学院名称"
          clearable
          :maxlength="20" show-word-limit
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="所在学校" prop="schoolType">
        <el-select v-model="queryParams.departmentSchoolId" filterable clearable placeholder="请选择学院所在的学校" @keyup.enter.native="handleQuery">
          <el-option
            v-for="item in schoolList"
            :key="item.schoolId"
            :label="item.schoolName"
            :value="item.schoolId">
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-table v-loading="loading" :data="departmentList">
      <el-table-column label="院系名称" align="center" prop="departmentName" />
      <el-table-column label="学校名称" align="center" prop="schoolName" >
        <template slot-scope="scope">
          <el-tag>{{scope.row.schoolName}}</el-tag>
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
import { listDepartment, getDepartment, delDepartment, addDepartment, updateDepartment,listSchool } from "@/api/wx/department";
import school from '@/views/wx/school/index.vue'

export default {
  name: "Department",
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
      departmentList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        departmentName: null,
        departmentSchoolId: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        departmentName: [
          { required: true, message: "院系名称不能为空", trigger: "blur" }
        ],
        departmentSchoolId: [
          { required: true, message: "院系所在的学校不能为空", trigger: "blur" }
        ]
      },
      schoolList:[]
    };
  },
  created() {
    this.getList();
    this.getSchool();
  },
  methods: {
    /** 查询【请填写功能名称】列表 */
    getList() {
      this.loading = true;
      listDepartment(this.queryParams).then(response => {
        this.departmentList = response.rows;
        this.total = response.total;
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
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        departmentId: null,
        departmentName: null,
        departmentSchoolId: null,
        schoolName:null
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
