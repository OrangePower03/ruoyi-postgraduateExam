<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="信息标题" prop="infoTitle">
        <el-input
          v-model="queryParams.infoTitle"
          placeholder="请输入信息标题"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>

      <el-form-item label="信息类型" prop="infoType">
        <el-select v-model="queryParams.infoType" placeholder="请选择信息类型" clearable @keyup.enter.native="handleQuery">
          <el-option
            v-for="dict in dict.type.user_info_type"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          ></el-option>
        </el-select>
      </el-form-item>

      <el-form-item label="信息日期" prop="infoDate">
        <el-date-picker clearable
                        v-model="queryParams.infoDate"
                        type="date"
                        value-format="yyyy-MM-dd"
                        placeholder="请选择信息日期">
        </el-date-picker>
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
          v-hasPermi="['user:info:add']"
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
          v-hasPermi="['user:info:edit']"
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
          v-hasPermi="['user:info:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['user:info:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="infoList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="信息标题" align="center" prop="infoTitle" />
      <el-table-column label="信息链接" align="center" prop="infoLink" >
        <template slot-scope="scope">
          <el-link :href="scope.row.infoLink" type="primary" target="_blank">{{ scope.row.infoLink }}</el-link>
        </template>
      </el-table-column>
      <el-table-column label="信息类型" align="center" prop="infoType" >
        <template slot-scope="scope">
          <dict-tag :options="dict.type.user_info_type" :value="scope.row.infoType"/>
        </template>
      </el-table-column>
      <el-table-column label="学校名称" align="center" prop="schoolName" />
      <el-table-column label="信息日期" align="center" prop="infoDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.infoDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['user:info:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['user:info:remove']"
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

    <!-- 添加或修改招生信息对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="信息标题" prop="infoTitle">
          <el-input v-model="form.infoTitle" placeholder="请输入信息标题" />
        </el-form-item>
        <el-form-item label="信息链接" prop="infoLink">
          <el-input v-model="form.infoLink" placeholder="请输入信息链接" />
        </el-form-item>
        <el-form-item label="信息类型" prop="infoType">
          <el-select v-model="form.infoType" placeholder="请选择信息类型" clearable>
            <el-option
              v-for="dict in dict.type.user_info_type"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="信息日期" prop="infoDate">
          <el-date-picker clearable
                          v-model="form.infoDate"
                          type="date"
                          value-format="yyyy-MM-dd"
                          placeholder="请选择信息日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="学校名称" prop="schoolId">
          <el-select v-model="form.schoolId" placeholder="请选择所在地区" clearable filterable :style="{width: '100%'}">
            <el-option v-for="(item, index) in schoolOptions" :key="index" :label="item.schoolName"
                       :value="item.schoolId" :disabled="item.disabled"></el-option>
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
import { listInfo, getInfo, delInfo, addInfo, updateInfo ,schoolList} from "@/api/wx/info";

export default {
  name: "Info",
  dicts:['user_info_type'],
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
      // 招生信息表格数据
      infoList: [],
      schoolOptions:[],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        infoTitle: null,
        infoDate: null,
        infoType:null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        infoTitle: [
          { required: true, message: "信息标题不能为空", trigger: "blur" }
        ],
        infoLink: [
          { required: true, message: "信息链接不能为空", trigger: "blur" }
        ],
        infoDate: [
          { required: true, message: "信息日期不能为空", trigger: "blur" }
        ],
        schoolId: [
          { required: true, message: "学校id不能为空", trigger: "blur" }
        ]
      }
    };
  },
  created() {
    this.getList();
    this.getSchoolList()
  },
  methods: {
    /** 查询招生信息列表 */
    getList() {
      this.loading = true;
      listInfo(this.queryParams).then(response => {
        this.infoList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    getSchoolList(){
      this.loading = true
      schoolList().then(response =>{
        this.schoolOptions=response.rows
        this.loading = false;
      })
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        infoId: null,
        infoTitle: null,
        infoLink: null,
        infoDate: null,
        schoolId: null
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
      this.ids = selection.map(item => item.infoId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加招生信息";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const infoId = row.infoId || this.ids
      getInfo(infoId).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改招生信息";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.infoId != null) {
            updateInfo(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addInfo(this.form).then(response => {
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
      const infoIds = row.infoId || this.ids;
      this.$modal.confirm('是否确认删除招生信息编号为"' + infoIds + '"的数据项？').then(function() {
        return delInfo(infoIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('user/info/export', {
        ...this.queryParams
      }, `info_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>
