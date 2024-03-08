<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="学校名称" prop="schoolName">
        <el-input
          v-model="queryParams.schoolName"
          placeholder="请输入学校的名字"
          clearable
          :maxlength="20" show-word-limit
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="所在地区" prop="schoolArea">
        <el-select v-model="queryParams.schoolArea" placeholder="请选择学校所在地区" filterable clearable :style="{width: '100%'}" @keyup.enter.native="handleQuery">
          <el-option v-for="(item, index) in areaOptions" :key="index" :label="item.areaName"
                     :value="item.areaId" :disabled="item.disabled"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="学校层次" prop="schoolLevels">
        <el-select v-model="queryParams.schoolLevels" placeholder="请选择学校层次" clearable :style="{width: '100%'}" @keyup.enter.native="handleQuery">
          <el-option v-for="(item, index) in levelOptions" :key="index" :label="item.levelName"
                     :value="item.levelId" :disabled="item.disabled"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="自划线" prop="schoolType">
        <el-select v-model="queryParams.schoolType" placeholder="请选择是否为自划线学校" clearable :style="{width: '100%'}" @keyup.enter.native="handleQuery">
          <el-option v-for="(item, index) in typeOptions" :key="index" :label="item.typeName"
                     :value="item.typeId" :disabled="item.disabled"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-table v-loading="loading" :data="schoolList">
      <el-table-column label="学校名称" align="center" prop="schoolName" />
      <el-table-column label="学校所在地区" align="center" prop="areaName" />
      <el-table-column label="学校层次" align="center" prop="schoolLevels" >
        <template slot-scope="scope">
          <el-tag v-if="scope.row.schoolLevels===1">985，211，双一流</el-tag>
          <el-tag v-else-if="scope.row.schoolLevels===2">211，双一流</el-tag>
          <el-tag v-else-if="scope.row.schoolLevels===3">211</el-tag>
          <el-tag v-else-if="scope.row.schoolLevels===4">双一流</el-tag>
          <el-tag v-else-if="scope.row.schoolLevels===5">普通院校</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="是否为自划线学校" align="center" prop="schoolType" >
        <template slot-scope="scope">
          <el-tag v-if="scope.row.schoolType===1" type="success">是</el-tag>
          <el-tag v-else-if="scope.row.schoolType===2" type="warning">否</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="学校官网" align="center" prop="schoolWebsite" >
        <template slot-scope="scope">
          <el-link :href="scope.row.schoolWebsite" type="primary" target="_blank">{{ scope.row.schoolWebsite }}</el-link>
        </template>
      </el-table-column>
      <el-table-column label="学校研招网" align="center" prop="schoolRecruit" >
        <template slot-scope="scope">
          <el-link :href="scope.row.schoolRecruit" type="primary" target="_blank">{{ scope.row.schoolRecruit }}</el-link>
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
import { listSchool,listArea } from "@/api/wx/school";

export default {
  name: "School",
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
      schoolList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        schoolName: null,
        schoolArea: null,
        areaName:null,
        schoolType: null,
        schoolLevels: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        schoolName: [
          { required: true, message: "学校的名字不能为空", trigger: "blur" }
        ],
        schoolArea: [
          { required: true, message: "学校所在地区不能为空", trigger: "blur" }
        ],
        schoolType: [
          { required: true, message: "是否为34所自划线不能为空", trigger: "change" }
        ],
        schoolLevels: [
          { required: true, message: "学校层次不能为空", trigger: "blur" }
        ]
      },
      areaOptions:[],
      levelOptions:[{
        "levelId":1,
        "levelName":"985，211，双一流"
      },{
        "levelId":2,
        "levelName":"211，双一流",
      },{
        "levelId":3,
        "levelName":"211"
      },{
        "levelId":4,
        "levelName":"双一流"
      },{
        "levelId":5,
        "levelName":"普通院校"
      }],
      typeOptions:[{
        "typeName":"是",
        "typeId":1
      },{
        "typeName":"否",
        "typeId":2
      }]
    };
  },
  created() {
    this.getList();
    this.getArea();
  },
  methods: {
    /** 查询【请填写功能名称】列表 */
    getList() {
      this.loading = true;
      listSchool(this.queryParams).then(response => {
        console.log(response)
        this.schoolList = response.rows;
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
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        schoolId: null,
        schoolName: null,
        schoolArea: null,
        schoolType: null,
        schoolLevels: null
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
