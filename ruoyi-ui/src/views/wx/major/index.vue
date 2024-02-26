<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="专业代码" prop="majorCode">
        <el-input
          v-model="queryParams.majorCode"
          placeholder="请输入专业代码"
          clearable
          :maxlength="20" show-word-limit
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="专业名称" prop="majorName">
        <el-input
          v-model="queryParams.majorName"
          placeholder="请输入专业名称"
          clearable
          :maxlength="20" show-word-limit
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="所在学校" prop="schoolType">
        <el-select v-model="queryParams.majorSchoolName" filterable clearable placeholder="请选择院系所在的学校" @change="schoolChange" @keyup.enter.native="handleQuery">
          <el-option
            v-for="item in schoolList"
            :key="item.schoolId"
            :label="item.schoolName"
            :value="item.schoolName">
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="所在学院" prop="majorDepartmentId">
        <el-select v-model="queryParams.majorDepartmentName" placeholder="请选择专业所在学院" filterable clearable :style="{width: '100%'}" value-key="departmentId" @keyup.enter.native="handleQuery">
          <el-option v-for="item in DepartmentList" :key="item.departmentId" :label="item.departmentName"
                     :value="item.departmentName"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="专业类型" prop="majorType">
        <el-select v-model="queryParams.majorType" placeholder="请选择该专业的类型" filterable clearable :style="{width: '100%'}" @keyup.enter.native="handleQuery">
          <el-option v-for="(item, index) in majorTypeList" :key="index" :label="item.name"
                     :value="item.value" :disabled="item.disabled"></el-option>
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
          v-hasPermi="['user:major:add']"
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
          v-hasPermi="['user:major:edit']"
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
          v-hasPermi="['user:major:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['user:major:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="majorList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="专业代码" align="center" prop="majorCode" />
      <el-table-column label="专业名称" align="center" prop="majorName" />
      <el-table-column label="专业所在学院" align="center" prop="majorDepartmentName" />
      <el-table-column label="专业所在学校" align="center" prop="majorSchoolName" />
      <el-table-column label="专业类型" align="center" prop="majorType" >
        <template slot-scope="scope">
          <el-tag v-if="scope.row.majorType===1">学硕</el-tag>
          <el-tag v-else>专硕</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['user:major:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['user:major:remove']"
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

    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="专业" prop="majorId">
          <el-cascader v-model="form.majorId" :options="majorCascade" @change="majorChange" filterable clearable :style="{width: '100%'}"></el-cascader>
        </el-form-item>
        <el-form-item label="所在学院" prop="departmentId">
          <el-select
            v-model="form.departmentId"
            filterable
            remote
            reserve-keyword
            placeholder="请选择所在学院"
            :style="{width: '100%'}"
            :remote-method="remoteMethod"
            :loading="loading">
            <el-option
              v-for="item in options"
              :key="item.value"
              :label="item.label"
              :value="item.value"
              :disabled="item.disabled"
            >
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
import {
  listsMajor,
  listMajor,
  listDepartment,
  getConnect,
  addConnect,
  delConnect,
  updateConnect
} from '@/api/wx/major'
import { listSchool } from '@/api/wx/department'
import item from '@/layout/components/Sidebar/Item.vue'

export default {
  name: "Major",
  computed: {
    item() {
      return item
    }
  },
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
      // 查询专业表格数据
      majorList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        majorId:null,
        majorCode:null,
        majorName: null,
        majorDepartmentId: null,
        majorDepartmentName:null,
        majorSchoolName:null,
        majorType: null
      },
      // 表单参数
      form: {
        connectId:null,
        majorId: null,
        departmentId: null,
      },
      // 表单校验
      rules: {
        majorId: [
          { required: true, message: "专业名称不能为空", trigger: "blur" }
        ],
        departmentId: [
          { required: true, message: "院系不能为空", trigger: "blur" }
        ]
      },
      DepartmentList:[],
      sMajorList:[],
      schoolList:[],
      majorTypeList:[{ name:"学硕",value:1},{name:"专硕",value:2}],
      type:0,
      majorCascade:[{
        value:"专硕",
        label:"专硕",
        children:[]
      },{
        value:"学硕",
        label:"学硕",
        children:[]
      }],
      schoolCascade:[],
      testList:[],
      options: [],
      value:null
    };
  },
  created() {
    listDepartment().then(response => {
      this.testList = response.rows.map(item => {
        return { value: item.departmentId, label: item.schoolName+' '+item.departmentName };
      });
    });
    this.getList();
    this.getSList();
    this.getSchool()
  },
  methods: {
    remoteMethod(query){
      if (query !== '') {
        this.loading = true;
        let i=0;
        this.options = this.testList.filter(item => {
          if (i>999)
            return false
          if (item.label.toLowerCase().indexOf(query.toLowerCase()) > -1){
            i++;
            return true;
          }
          return false
        });
        if(i===1000)
          this.options.push({value:0,label:"数据加载上限为一千条，请输入更详细的信息吧！",disabled: true})
        this.loading = false;
      } else
        this.options = [];
    },
    /** 查询专业列表 */
    getList() {
      this.loading = true;
      listMajor(this.queryParams).then(response => {
        this.majorList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    getSList(){
      this.loading = true;
      listsMajor().then(response => {
        this.sMajorList = response.rows;
        for (let i=0;i<this.sMajorList.length;i++){
          if(this.sMajorList[i].majorType===1)
            this.majorCascade[0].children.push({
              value: this.sMajorList[i].majorId,
              label: this.sMajorList[i].majorCode+' '+this.sMajorList[i].majorName
            })
          else
            this.majorCascade[1].children.push({
              value: this.sMajorList[i].majorId,
              label: this.sMajorList[i].majorCode+' '+this.sMajorList[i].majorName
            })
        }
        this.loading = false;
      });
    },
    getDepartmentList(name) {
      this.loading = true;
      listDepartment({schoolName:name}).then(response => {
        this.DepartmentList = response.rows;
        this.loading = false;
      });
    },
    getSchool(){
      this.loading = true;
      listSchool().then(response => {
        this.schoolList = response.rows;
        for (let i=0;i<this.schoolList.length;i++){
          this.schoolCascade.push({
            value:this.schoolList[i].schoolName,
            label:this.schoolList[i].schoolName,
            children:[]
          })
        }
        this.loading = false;
      });
    },
    schoolChange(event){
      this.queryParams.majorDepartmentName=null
      if(event==='')
        this.DepartmentList=null
      else
        this.getDepartmentList(event)
    },
    majorChange(){
      this.form.majorId=this.form.majorId[1]
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        majorId: null,
        departmentId: null,
        connectId:null,
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
      this.ids = selection.map(item => item.connectId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加院校专业";
      this.type=0
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const connectId = row.connectId || this.ids
      getConnect(connectId).then(response => {
        this.form = response.data;
        this.options = this.testList.filter(item => {
          return item.value===this.form.departmentId;
        });
        this.open = true;
        this.title = "修改院校专业";
        this.type=1
      });

    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.type) {
            updateConnect(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addConnect(this.form).then(response => {
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
      const connectIds = row.connectId || this.ids;
      this.$modal.confirm('是否确认删除院校专业？（提示：删除院校专业的同时院校的专业对应的分数信息也将一并删除）').then(function() {
        return delConnect(connectIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('user/major/export', {
        ...this.queryParams
      }, `major_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>
