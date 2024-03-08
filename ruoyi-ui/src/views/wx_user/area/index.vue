<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="地区名称" prop="areaName">
        <el-input
          v-model="queryParams.areaName"
          placeholder="请输入地区名称"
          clearable
          :maxlength="20" show-word-limit
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="地区类型" prop="areaType">
        <el-select v-model="queryParams.areaType" placeholder="请选择该专业的类型" clearable :maxlength="20" show-word-limit :style="{width: '100%'}" @keyup.enter.native="handleQuery">
          <el-option v-for="(item, index) in areaTypeList" :key="index" :label="item.name"
                     :value="item.value" :disabled="item.disabled"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-table v-loading="loading" :data="areaList">
      <el-table-column label="地区名称" align="center" prop="areaName" />
      <el-table-column label="地区类型" align="center" prop="areaType" >
        <template slot-scope="scope">
          <el-tag v-if="scope.row.areaType===1">A区</el-tag>
          <el-tag v-else-if="scope.row.areaType===2" type="success">B区</el-tag>
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
import { listArea } from "@/api/wx/area";

export default {
  name: "Area",
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
      areaList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        areaName: null,
        areaType: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        areaName: [
          { required: true, message: "地区名称不能为空", trigger: "blur" }
        ],
        areaType: [
          { required: true, message: "判断该地区是一区还是二区不能为空", trigger: "change" }
        ]
      },
      areaTypeList:[{ name:"A区",value:1},{name:"B区",value:2}]
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询【请填写功能名称】列表 */
    getList() {
      this.loading = true;
      listArea(this.queryParams).then(response => {
        this.areaList = response.rows;
        this.total = response.total;
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
        areaId: null,
        areaName: null,
        areaType: null
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
    },
  }
};
</script>
