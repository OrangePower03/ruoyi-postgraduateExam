<template>
  <div class="app-container">
    <el-form :model="queryParams" :rules="rulesQuery" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="考研年份" prop="scoreYear">
        <el-input
          v-model="queryParams.scoreYear"
          placeholder="请输入考研年份"
          clearable
          :maxlength="20" show-word-limit
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="专业" prop="majorId">
        <el-select v-model="queryParams.majorId" placeholder="请输入该专业的类型" filterable clearable :style="{width: '100%'}" @keyup.enter.native="handleQuery">
          <el-option v-for="(item, index) in sMajorList" :key="index" :label="item.majorCode+' '+item.majorName"
                     :value="item.majorId" :disabled="item.disabled"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="复试线" prop="scoreAll">
        <el-input
          v-model="queryParams.scoreAll"
          placeholder="请输入复试线"
          clearable
          :maxlength="3" show-word-limit
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="英语线" prop="scoreEnglish">
        <el-input
          v-model="queryParams.scoreEnglish"
          placeholder="请输入英语线"
          clearable
          :maxlength="3" show-word-limit
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="政治线" prop="scorePolitics">
        <el-input
          v-model="queryParams.scorePolitics"
          placeholder="请输入政治线"
          clearable
          :maxlength="3" show-word-limit
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="专业一" prop="scoreMath">
        <el-input
          v-model="queryParams.scoreMath"
          placeholder="请输入专业一"
          clearable
          :maxlength="3" show-word-limit
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="专业二" prop="scoreMajor">
        <el-input
          v-model="queryParams.scoreMajor"
          placeholder="请输入专业线"
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
          v-hasPermi="['user:dscore:add']"
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
          v-hasPermi="['user:dscore:edit']"
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
          v-hasPermi="['user:dscore:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['user:dscore:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="dscoreList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="考研年份" align="center" prop="scoreYear" />
      <el-table-column label="专业名称" align="center" prop="majorName" />
      <el-table-column label="复试线" align="center" prop="scoreAll" />
      <el-table-column label="英语线" align="center" prop="scoreEnglish" />
      <el-table-column label="政治线" align="center" prop="scorePolitics" />
      <el-table-column label="专业一" align="center" prop="scoreMath" />
      <el-table-column label="专业二" align="center" prop="scoreMajor" />
      <el-table-column label="地区类型" align="center" prop="areaType" >
        <template slot-scope="scope">
          <el-tag v-if="scope.row.areaType===1">A区</el-tag>
          <el-tag v-else-if="scope.row.areaType===2" type="success">B区</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['user:dscore:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['user:dscore:remove']"
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
        <el-form-item label="考研年份" prop="scoreYear">
          <el-input v-model="form.scoreYear" placeholder="请输入考研年份" />
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
          <el-input v-model="form.scoreMath" placeholder="请输入专业一" />
        </el-form-item>
        <el-form-item label="专业二" prop="scoreMajor">
          <el-input v-model="form.scoreMajor" placeholder="请输入专业线" />
        </el-form-item>
        <el-form-item label="专业" prop="majorId">
          <el-select v-model="form.majorId" placeholder="请输入该专业的类型" filterable clearable :style="{width: '100%'}">
            <el-option v-for="(item, index) in sMajorList" :key="index" :label="item.majorCode+' '+item.majorName"
                       :value="item.majorId" :disabled="item.disabled"></el-option>
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
import { listDscore, getDscore, delDscore, addDscore, updateDscore } from "@/api/wx/dscore";
import { listsMajor } from '@/api/wx/major'

export default {
  name: "dscore",
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
      dscoreList: [],
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
        majorId: null,
        areaType: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        scoreYear: [
          { required: true, message: "考研年份不能为空", trigger: "blur" }
        ],
        scoreAll: [
          { required: true, message: "复试线不能为空", trigger: "blur" }
        ],
        scoreMath: [
          { required: true, message: "专业一不能为空", trigger: "blur" }
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
        majorId: [
          { required: true, message: "专业编号不能为空", trigger: "blur" }
        ],
        areaType: [
          { required: true, message: "地区类型不能为空", trigger: "change" }
        ]
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
      sMajorList:[]
    };
  },
  created() {
    this.getList();
    this.getSList();
  },
  methods: {
    /** 查询【请填写功能名称】列表 */
    getList() {
      this.loading = true;
      listDscore(this.queryParams).then(response => {
        this.dscoreList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    getSList(){
      this.loading = true;
      listsMajor().then(response => {
        this.sMajorList = response.rows;
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
        scoreId: null,
        scoreYear: null,
        scoreAll: null,
        scoreMath: null,
        scoreEnglish: null,
        scorePolitics: null,
        scoreMajor: null,
        majorId: null,
        areaType: null
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
      this.title = "添加国家线";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const scoreId = row.scoreId || this.ids
      getDscore(scoreId).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改国家线";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.scoreId != null) {
            updateDscore(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addDscore(this.form).then(response => {
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
      this.$modal.confirm('是否确认删除国家线？').then(function() {
        return delDscore(scoreIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('system/dscore/export', {
        ...this.queryParams
      }, `dscore_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>
