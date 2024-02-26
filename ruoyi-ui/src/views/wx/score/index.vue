<template>
  <div class="app-container">
    <el-form :model="queryParams" :rules="rulesQuery" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px" style="margin-top: 20px;">
      <el-form-item label="考研年份" prop="scoreYear">
        <el-input
          v-model="queryParams.scoreYear"
          placeholder="请输入考研的年份"
          clearable
          :maxlength="20" show-word-limit
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="专业" prop="majorId">
        <el-select v-model="queryParams.majorId" placeholder="请输入该专业的类型" filterable clearable :style="{width: '100%'}" @keyup.enter.native="handleQuery">
          <el-option v-for="(item, index) in majorList" :key="index" :label="item.majorCode+' '+item.majorName"
                     :value="item.majorId" :disabled="item.disabled"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="专业类型" prop="majorType">
        <el-select v-model="queryParams.majorType" placeholder="请选择该专业的类型" filterable clearable :style="{width: '100%'}" @keyup.enter.native="handleQuery">
          <el-option v-for="(item, index) in majorTypeList" :key="index" :label="item.name"
                     :value="item.value" :disabled="item.disabled"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="所在学校" prop="schoolName">
        <el-select v-model="queryParams.schoolName" filterable clearable placeholder="请选择院系所在的学校" @change="schoolChange" @keyup.enter.native="handleQuery">
          <el-option
            v-for="item in schoolList"
            :key="item.schoolId"
            :label="item.schoolName"
            :value="item.schoolName">
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="所在学院" prop="majorDepartmentId">
        <el-select v-model="queryParams.departmentName" placeholder="请输入专业所在学院" filterable clearable :style="{width: '100%'}" value-key="departmentId" @change="departmentChange($event)" @keyup.enter.native="handleQuery">
          <el-option v-for="item in DepartmentList" :key="item.departmentId" :label="item.schoolName+' '+item.departmentName"
                     :value="item" :disabled="item.disabled"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="复试线" prop="scoreAll">
        <el-input
          v-model="queryParams.scoreAll"
          placeholder="请输入复试的分数"
          clearable
          :maxlength="3" show-word-limit
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="英语线" prop="scoreEnglish">
        <el-input
          v-model="queryParams.scoreEnglish"
          placeholder="请输入英语的分数"
          clearable
          :maxlength="3" show-word-limit
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="政治线" prop="scorePolitics">
        <el-input
          v-model="queryParams.scorePolitics"
          placeholder="请输入政治的分数"
          clearable
          :maxlength="3" show-word-limit
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="专业一" prop="scoreMath">
        <el-input
          v-model="queryParams.scoreMath"
          placeholder="请输入专业一的分数"
          clearable
          :maxlength="3" show-word-limit
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="专业二" prop="scoreMajor">
        <el-input
          v-model="queryParams.scoreMajor"
          placeholder="请输入专业二的分数"
          clearable
          :maxlength="3" show-word-limit
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
          v-hasPermi="['user:score:add']"
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
          v-hasPermi="['user:score:edit']"
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
          v-hasPermi="['user:score:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="info"
                   plain
                   icon="el-icon-upload2"
                   size="mini"
                   @click="upload.open = true"
                   v-hasPermi="['user:score:add']"
        >导入</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['user:score:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="scoreList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="考试年份" align="center" prop="scoreYear" />
      <el-table-column label="专业代码" align="center" prop="majorCode" />
      <el-table-column label="专业名称" align="center" prop="majorName" />
      <el-table-column label="专业类型" align="center" prop="majorType" >
        <template slot-scope="scope">
          <el-tag v-if="scope.row.majorType===1">学硕</el-tag>
          <el-tag v-else>专硕</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="所属学校" align="center" prop="schoolName" />
      <el-table-column label="所属院系" align="center" prop="departmentName" />
      <el-table-column label="复试线" align="center" prop="scoreAll" />
      <el-table-column label="英语线" align="center" prop="scoreEnglish" />
      <el-table-column label="政治线" align="center" prop="scorePolitics" />
      <el-table-column label="专业一" align="center" prop="scoreMath" />
      <el-table-column label="专业二" align="center" prop="scoreMajor" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['user:score:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['user:score:remove']"
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
        <el-form-item label="考试年份" prop="scoreYear">
          <el-input v-model="form.scoreYear" placeholder="请输入考试的年份" />
        </el-form-item>
        <el-form-item label="复试线" prop="scoreAll">
          <el-input v-model="form.scoreAll" placeholder="请输入复试线" />
        </el-form-item>
        <el-form-item label="英语线" prop="scoreEnglish">
          <el-input v-model="form.scoreEnglish" placeholder="请输入英语线" />
        </el-form-item>
        <el-form-item label="政治线" prop="scorePolitics">
          <el-input v-model="form.scorePolitics" placeholder="请输入政治线" />
        </el-form-item>
        <el-form-item label="专业一" prop="scoreMath">
          <el-input v-model="form.scoreMath" placeholder="请输入数学线" />
        </el-form-item>
        <el-form-item label="专业二" prop="scoreMajor">
          <el-input v-model="form.scoreMajor" placeholder="请输入专业线" />
        </el-form-item>
        <el-form-item label="所属专业" prop="scoreMajorId">
          <el-select v-model="form.scoreMajorId" placeholder="请输入专业所在院" filterable clearable :style="{width: '100%'}">
            <el-option v-for="(item, index) in connectList" :key="index" :label="item.majorCode+' '+item.majorName+' '+item.majorDepartmentName+' '+item.majorSchoolName"
                       :value="item.connectId" :disabled="item.disabled"></el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

    <el-dialog :title="upload.title" :visible.sync="upload.open" width="400px" append-to-body>
      <el-upload ref="upload" :limit="1" accept=".xlsx, .xls"
                 :headers="upload.headers"
                 :action="upload.url + '?updateSupport=' + upload.updateSupport"
                 :disabled="upload.isUploading"
                 :on-progress="handleFileUploadProgress"
                 :on-success="handleFileSuccess"
                 :auto-upload="false"
                 drag
      >
        <i class="el-icon-upload"></i>
        <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
        <div class="el-upload__tip text-center" slot="tip">
          <span>仅允许导入xls、xlsx格式文件。</span>
          <el-link type="primary" :underline="false" style="font-size:12px;vertical-align: baseline;" @click="importTemplate">下载模板</el-link>
        </div>
      </el-upload>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitFileForm">确 定</el-button>
        <el-button @click="upload.open = false">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listScore, getScore, delScore, addScore, updateScore } from "@/api/wx/score";
import { listDepartment, listsMajor, majorList } from '@/api/wx/major'
import { listSchool } from '@/api/wx/department'
import { getToken } from '@/utils/auth'

export default {
  name: "Score",
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
      scoreList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        scoreYear: null,
        scoreAll: null,
        scoreMath: null,
        scoreEnglish: null,
        scorePolitics: null,
        scoreMajor: null,
        scoreMajorId: null,
        majorName: null,
        majorType: null,
        majorCode:null,
        departmentName:null,
        schoolName:null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        scoreYear: [
          { required: true, message: "考试的年份不能为空", trigger: "blur" }
        ],
        scoreAll: [
          { required: true, message: "复试线不能为空", trigger: "blur" }
        ],
        scoreMath: [
          { required: true, message: "数学线不能为空", trigger: "blur" }
        ],
        scoreEnglish: [
          { required: true, message: "英语线不能为空", trigger: "blur" }
        ],
        scorePolitics: [
          { required: true, message: "政治线不能为空", trigger: "blur" }
        ],
        scoreMajor: [
          { required: true, message: "专业线不能为空", trigger: "blur" }
        ],
        scoreMajorId: [
          { required: true, message: "所属专业不能为空", trigger: "blur" }
        ],
      },
      rulesQuery: {
        scoreAll: [
          { message: "初始分数有误",pattern:'^(500|[1-4]{0,1}\\d{0,1}\\d)$',trigger: "blur"},
        ],
        scoreEnglish: [
          { message: "英语分数有误",pattern:'^(100|\\d{0,1}\\d)$',trigger: "blur"},
        ],
        scorePolitics:[
          { message: "政治分数有误",pattern:'^(100|\\d{0,1}\\d)$',trigger: "blur"},
        ],
        scoreMath:[
          { message: "专业一分数有误",pattern:'^(150|\\d{0,1}\\d|[1]{0,1}[0-4]{0,1}\\d)$',trigger: "blur"},
        ],
        scoreMajor:[
          { message: "专业二分数有误",pattern:'^(150|\\d{0,1}\\d|[1]{0,1}[0-4]{0,1}\\d)$',trigger: "blur"},
        ]
      },
      majorList:[],
      connectList:[],
      schoolList:[],
      DepartmentList:[],
      majorTypeList:[{ name:"学硕",value:1},{name:"专硕",value:2}],
      upload: {
        // 是否显示弹出层（用户导入）
        open: false,
        // 弹出层标题（用户导入）
        title: "",
        // 是否禁用上传
        isUploading: false,
        // 设置上传的请求头部
        headers: { Authorization: "Bearer " + getToken()},
        // 上传的地址
        url: process.env.VUE_APP_BASE_API + "/user/score/importData"
      },
    };
  },
  created() {
    this.getList();
    this.getSList();
    this.getConnectList();
    this.getSchool();
    this.getDepartmentList();
  },
  methods: {
    /** 查询【请填写功能名称】列表 */
    getList() {
      this.loading = true;
      listScore(this.queryParams).then(response => {
        this.scoreList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    getConnectList() {
      this.loading = true;
      console.log(this.queryParams)
      majorList().then(response => {
        this.connectList = response.rows;
        console.log('connect')
        console.log(response.rows)
        this.loading = false;
      });
    },
    getSList(){
      this.loading = true;
      listsMajor().then(response => {
        this.majorList = response.rows;
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
      console.log(value)
      this.queryParams.departmentName=value.departmentName
      this.queryParams.schoolName=value.schoolName
    },
    schoolChange(){
      this.queryParams.departmentName=null
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        scoreId: null,
        scoreYear: null,
        scoreAll: null,
        scoreMath: null,
        scoreEnglish: null,
        scorePolitics: null,
        scoreMajor: null,
        scoreMajorId: null,
        departmentName:null,
        schoolName:null
      };
      this.resetForm("form");
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.$refs["queryForm"].validate(valid => {
        if(valid){
          this.queryParams.pageNum = 1;
          this.getList();
        }
        else
          this.$modal.msgWarning("信息有误！");
      })
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.scoreId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加复试线";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      const scoreId = row.scoreId || this.ids
      getScore(scoreId).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改复试线";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.scoreId != null) {
            updateScore(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addScore(this.form).then(response => {
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
      const scoreIds = row.scoreId || this.ids;
      this.$modal.confirm('是否确认删除该复试线？').then(function() {
        return delScore(scoreIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('user/score/export', {
        ...this.queryParams
      }, `score_${new Date().getTime()}.xlsx`)
    },
    importTemplate() {
      this.download('/user/score/importTemplate', {
      }, `score_template_${new Date().getTime()}.xlsx`)
    },
    // 文件上传中处理
    handleFileUploadProgress(event, file, fileList) {
      this.upload.isUploading = true;
    },
    // 文件上传成功处理
    handleFileSuccess(response, file, fileList) {
      this.upload.open = false;
      this.upload.isUploading = false;
      this.$refs.upload.clearFiles();
      this.$alert("<div style='overflow: auto;overflow-x: hidden;max-height: 70vh;padding: 10px 20px 0;'>" + response.msg + "</div>", "导入结果", { dangerouslyUseHTMLString: true });
      this.getList();
    },
    // 提交上传文件
    submitFileForm() {
      this.$refs.upload.submit();
    }
  }
};
</script>
