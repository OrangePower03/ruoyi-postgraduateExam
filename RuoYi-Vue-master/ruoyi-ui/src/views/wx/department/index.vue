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

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['user:department:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['user:department:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['user:department:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['user:department:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="departmentList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="院系名称" align="center" prop="departmentName" />
      <el-table-column label="学校名称" align="center" prop="schoolName" >
        <template slot-scope="scope">
          <el-tag>{{scope.row.schoolName}}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['user:department:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['user:department:remove']"
          >删除</el-button>
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

    <!-- 添加或修改【请填写功能名称】对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="院系名称" prop="departmentName">
          <el-input v-model="form.departmentName" placeholder="请输入院系名称" />
        </el-form-item>
        <el-form-item label="所在学校" prop="departmentSchoolId">
          <el-select v-model="form.departmentSchoolId" placeholder="请选择学院所在的学校" clearable :style="{width: '100%'}">
            <el-option v-for="item in schoolList" :key="item.schoolId" :label="item.schoolName"
                        :value="parseInt(item.schoolId)" :disabled="item.disabled">
            </el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
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
      // 选中数组
      ids: [],
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
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.departmentId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加院系信息";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const departmentId = row.departmentId || this.ids
      getDepartment(departmentId).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改院系信息";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.departmentId != null) {
            updateDepartment(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addDepartment(this.form).then(response => {
              this.$modal.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const departmentIds = row.departmentId || this.ids;
      this.$modal.confirm('是否确认删除学院信息？（提示：删除学院的同时学院开设专业的分数也将一并删除）？').then(function() {
        return delDepartment(departmentIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('user/department/export', {
        ...this.queryParams
      }, `department_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>
