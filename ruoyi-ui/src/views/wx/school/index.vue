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

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['user:school:add']"
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
          v-hasPermi="['user:school:edit']"
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
          v-hasPermi="['user:school:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['user:school:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="schoolList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="学校名称" align="center" prop="schoolName" />
      <el-table-column label="学校所在地区" align="center" prop="areaName" />
      <el-table-column label="学校层次" align="center" prop="schoolLevels" >
        <template slot-scope="scope">
          <el-tag v-if="scope.row.schoolLevels===1">985，211，双一流</el-tag>
          <el-tag v-else-if="scope.row.schoolLevels===2">211，双一流</el-tag>
          <el-tag v-else-if="scope.row.schoolLevels===3">双一流</el-tag>
          <el-tag v-else-if="scope.row.schoolLevels===4">普通院校</el-tag>
          <el-tag v-else-if="scope.row.schoolLevels===5">科研院所</el-tag>
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
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['user:school:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['user:school:remove']"
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

    <!-- 添加或修改学校对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="学校名称" prop="schoolName">
          <el-input v-model="form.schoolName" placeholder="请输入学校的名字" />
        </el-form-item>
        <el-form-item label="所在地区" prop="schoolArea">
          <el-select v-model="form.schoolArea" placeholder="请选择所在地区" clearable :style="{width: '100%'}">
            <el-option v-for="(item, index) in areaOptions" :key="index" :label="item.areaName"
                       :value="item.areaId" :disabled="item.disabled"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="学校层次" prop="schoolLevels">
          <el-select v-model="form.schoolLevels" placeholder="请选择学校层次" clearable :style="{width: '100%'}">
            <el-option v-for="(item, index) in levelOptions" :key="index" :label="item.levelName"
                       :value="item.levelId" :disabled="item.disabled"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="是否为自划线学校" prop="schoolType">
          <el-select v-model="form.schoolType" placeholder="请选择是否为自划线学校" clearable :style="{width: '100%'}">
            <el-option v-for="(item, index) in typeOptions" :key="index" :label="item.typeName"
                       :value="item.typeId" :disabled="item.disabled"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="学校官网" prop="schoolWebsite">
          <el-input v-model="form.schoolWebsite" placeholder="请输入学校的名字" />
        </el-form-item>
        <el-form-item label="学校研招网" prop="schoolRecruit">
          <el-input v-model="form.schoolRecruit" placeholder="请输入学校的名字" />
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
import { listSchool, getSchool, delSchool, addSchool, updateSchool,listArea } from "@/api/wx/school";

export default {
  name: "School",
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
        ],
        schoolWebsite:[
          { required: true, message: "学校官网不能为空", trigger: "blur" }
        ],
        schoolRecruit:[
          { required: true, message: "学校研招网不能为空", trigger: "blur" }
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
        "levelName":"双一流"
      },{
        "levelId":4,
        "levelName":"普通院校"
      },{
        "levelId":5,
        "levelName":"科研院所"
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
        this.schoolList = response.rows;
        this.total = response.total;
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
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.schoolId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "新增学校信息";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const schoolId = row.schoolId || this.ids
      getSchool(schoolId).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改学校信息";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.schoolId != null) {
            updateSchool(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addSchool(this.form).then(response => {
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
      const schoolIds = row.schoolId || this.ids;
      this.$modal.confirm('是否确认删除学校？（提示：删除学校的同时学校的学院以及各专业的分数信息也将一并删除）').then(function() {
        return delSchool(schoolIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('user/school/export', {
        ...this.queryParams
      }, `school_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>
