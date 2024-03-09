<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="导师姓名" prop="teacherName">
        <el-input
          v-model="queryParams.teacherName"
          placeholder="请输入导师姓名"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="导师职称" prop="teacherPosition">
        <el-select v-model="queryParams.teacherPosition" placeholder="请选择导师职称" clearable @keyup.enter.native="handleQuery">
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
          v-model="queryParams.schoolName"
          placeholder="请输入所在学校"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="所在学院" prop="departmentId">
        <el-input
          v-model="queryParams.departmentId"
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

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['user:teacher:add']"
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
          v-hasPermi="['user:teacher:edit']"
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
          v-hasPermi="['user:teacher:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['user:teacher:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="teacherList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="导师姓名" align="center" prop="teacherName" />
      <el-table-column label="研究方向" align="center" prop="teacherDirection" />
      <el-table-column label="导师职称" align="center" prop="teacherPosition">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.user_teacher_position" :value="scope.row.teacherPosition"/>
        </template>
      </el-table-column>
      <el-table-column label="导师图片地址" align="center" prop="teacherImage" >
        <template slot-scope="scope">
          <el-link :href="scope.row.teacherImage" type="primary" target="_blank">{{ scope.row.teacherImage }}</el-link>
        </template>
      </el-table-column>
      <el-table-column label="导师信息链接" align="center" prop="teacherLink" >
        <template slot-scope="scope">
          <el-link :href="scope.row.teacherLink" type="primary" target="_blank">{{ scope.row.teacherLink }}</el-link>
        </template>
      </el-table-column>
      <el-table-column label="所在学校" align="center" prop="schoolName" />
      <el-table-column label="所在学院" align="center" prop="departmentName" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['user:teacher:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['user:teacher:remove']"
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

    <!-- 添加或修改导师表对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="导师姓名" prop="teacherName">
          <el-input v-model="form.teacherName" placeholder="请输入导师姓名" />
        </el-form-item>
        <el-form-item label="研究方向" prop="teacherDirection">
          <el-input v-model="form.teacherDirection" placeholder="请输入研究方向" />
        </el-form-item>
        <el-form-item label="导师职称" prop="teacherPosition">
          <el-select v-model="form.teacherPosition" placeholder="请选择导师职称" clearable @keyup.enter.native="handleQuery">
            <el-option
              v-for="dict in dict.type.user_teacher_position"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="导师图片地址" prop="teacherImage">
          <el-input v-model="form.teacherImage" placeholder="请输入导师图片地址" />
        </el-form-item>
        <el-form-item label="导师信息链接" prop="teacherLink">
          <el-input v-model="form.teacherLink" placeholder="请输入导师信息链接" />
        </el-form-item>
        <el-form-item label="所在学院" prop="departmentId">
          <el-input v-model="form.departmentId" placeholder="请输入所在学院" />
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
import { listTeacher, getTeacher, delTeacher, addTeacher, updateTeacher } from "@/api/wx/teacher";

export default {
  name: "Teacher",
  dicts: ['user_teacher_position'],
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
      // 导师表表格数据
      teacherList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        teacherName: null,
        teacherPosition:null,
        schoolName:null,
        departmentId: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        teacherName: [
          { required: true, message: "导师姓名不能为空", trigger: "blur" }
        ],
        teacherDirection: [
          { required: true, message: "研究方向不能为空", trigger: "blur" }
        ],
        teacherPosition: [
          { required: true, message: "导师职称不能为空", trigger: "blur" }
        ],
        teacherImage: [
          { required: true, message: "导师图片地址不能为空", trigger: "blur" }
        ],
        teacherLink: [
          { required: true, message: "导师信息链接不能为空", trigger: "blur" }
        ],
        departmentId: [
          { required: true, message: "所在学院不能为空", trigger: "blur" }
        ]
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询导师表列表 */
    getList() {
      this.loading = true;
      listTeacher(this.queryParams).then(response => {
        this.teacherList = response.rows;
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
        teacherId: null,
        teacherName: null,
        teacherDirection: null,
        teacherPosition: null,
        teacherImage: null,
        teacherLink: null,
        departmentId: null
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
      this.ids = selection.map(item => item.teacherId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加导师表";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const teacherId = row.teacherId || this.ids
      getTeacher(teacherId).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改导师表";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.teacherId != null) {
            updateTeacher(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addTeacher(this.form).then(response => {
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
      const teacherIds = row.teacherId || this.ids;
      this.$modal.confirm('是否确认删除导师表编号为"' + teacherIds + '"的数据项？').then(function() {
        return delTeacher(teacherIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('user/teacher/export', {
        ...this.queryParams
      }, `teacher_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>
