<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="满意程度" prop="satisfaction">
        <el-rate
          style="margin-top: 8px"
          v-model="queryParams.satisfaction"
          @keyup.enter.native="handleQuery"
          :colors="colors"
        >
        </el-rate>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['user:feedback:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['user:feedback:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="feedbackList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="满意程度" align="center" prop="satisfaction" >
        <template slot-scope="scope">
          <el-rate
            style="margin-top: 8px"
            v-model="scope.row.satisfaction"
            show-text
            :colors="colors" disabled>
          </el-rate>
        </template>
      </el-table-column>
      <el-table-column label="调剂情况" align="center" prop="action" >
        <template slot-scope="scope">
          <el-input
            type="textarea"
            :value="scope.row.action"
          >
          </el-input>
        </template>
      </el-table-column>
      <el-table-column label="您的建议" align="center" prop="suggest" >
        <template slot-scope="scope">
          <el-input
            type="textarea"
            :value="scope.row.suggest"
          >
          </el-input>
        </template>
      </el-table-column>>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['user:feedback:remove']"
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
  </div>
</template>

<script>
import { listFeedback, delFeedback } from "@/api/wx/feedback";

export default {
  name: "FeedbackList",
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
      feedbackList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        satisfaction: null,
        action: null,
        suggest: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        satisfaction: [
          { required: true, message: "满意程度不能为空", trigger: "blur" }
        ],
        action: [
          { required: true, message: "调剂情况不能为空", trigger: "blur" }
        ],
        suggest: [
          { required: true, message: "您的建议不能为空", trigger: "blur" }
        ]
      },
      colors: ['#e3d486', '#f8cb5e', '#FF9900'],
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询【请填写功能名称】列表 */
    getList() {
      this.loading = true;
      listFeedback(this.queryParams).then(response => {
        this.feedbackList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.queryParams.satisfaction=null
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.userId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const userIds = row.userId || this.ids;
      this.$modal.confirm('是否确认删除数据？').then(function() {
        return delFeedback(userIds);
      }).then(() => {
        if(this.queryParams.satisfaction===0)
          this.queryParams.satisfaction=null
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('system/feedback/export', {
        ...this.queryParams
      }, `feedback_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>
