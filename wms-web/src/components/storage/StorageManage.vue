<template>
  <div>
    <div style="margin-bottom: 5px;">
      <el-input v-model="name" placeholder="Enter warehouse name" suffix-icon="el-icon-search" style="width: 200px;"
                @keyup.enter.native="loadPost"></el-input>
      <el-button type="primary" style="margin-left: 5px;" @click="loadPost">Search</el-button>
      <el-button type="success" @click="resetParam">Reset</el-button>

      <el-button type="primary" style="margin-left: 5px;" @click="add">Add</el-button>
    </div>
    <el-table :data="tableData"
              :header-cell-style="{ background: '#f2f5fc', color: '#555555' }"
              border>
      <el-table-column prop="id" label="ID" width="60">
      </el-table-column>
      <el-table-column prop="name" label="Warehouse name" width="180">
      </el-table-column>
      <el-table-column prop="remark" label="Remark">
      </el-table-column>
      <el-table-column prop="operate" label="Operation">
        <template slot-scope="scope">
          <el-button size="small" type="success" @click="mod(scope.row)">Edit</el-button>
          <el-popconfirm
              title="Are you sure to delete?"
              @confirm="del(scope.row.id)"
              style="margin-left: 5px;">
            <el-button slot="reference" size="small" type="danger">Delete</el-button>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        :current-page="pageNum"
        :page-sizes="[5, 10, 20,30]"
        :page-size="pageSize"
        layout="total, sizes, prev, pager, next, jumper"
        :total="total">
    </el-pagination>

    <el-dialog
        title="Hint"
        :visible.sync="centerDialogVisible"
        width="30%"
        center>

      <el-form ref="form" :rules="rules" :model="form" label-width="80px">
        <el-form-item label="Name" prop="name">
          <el-col :span="20">
            <el-input v-model="form.name"></el-input>
          </el-col>
        </el-form-item>
        <el-form-item label="Remark" prop="remark">
          <el-col :span="20">
            <el-input type="textarea" v-model="form.remark"></el-input>
          </el-col>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
    <el-button @click="centerDialogVisible = false">Cancel</el-button>
    <el-button type="primary" @click="save">Confirm</el-button>
  </span>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: "StorageManage",
  data() {
    return {
      tableData: [],
      pageSize: 5,
      pageNum: 1,
      total: 0,
      name: '',
      centerDialogVisible: false,
      form: {
        id: '',
        name: '',
        remark: ''
      },
      rules: {
        name: [
          {required: true, message: 'Enter warehouse name', trigger: 'blur'}
        ]
      }
    }
  },
  methods: {
    resetForm() {
      this.$refs.form.resetFields();
    },
    del(id) {
      console.log(id)

      this.$axios.get(this.$httpUrl + '/wms/storage/del?id=' + id).then(res => res.data).then(res => {
        console.log(res)
        if (res.code == 200) {

          this.$message({
            message: 'Success',
            type: 'success'
          });
          this.loadPost()
        } else {
          this.$message({
            message: 'Fail',
            type: 'error'
          });
        }

      })
    },
    mod(row) {
      this.centerDialogVisible = true
      this.$nextTick(() => {
        //赋值到表单
        this.form.id = row.id
        this.form.name = row.name
        this.form.remark = row.remark
      })
    },
    add() {
      this.centerDialogVisible = true
      this.$nextTick(() => {
        this.resetForm()
      })

    },
    doSave() {
      this.$axios.post(this.$httpUrl + '/wms/storage/save', this.form).then(res => res.data).then(res => {
        console.log(res)
        if (res.code == 200) {

          this.$message({
            message: 'Success',
            type: 'success'
          });
          this.centerDialogVisible = false
          this.loadPost()
          this.resetForm()
        } else {
          this.$message({
            message: 'Fail',
            type: 'error'
          });
        }

      })
    },
    doMod() {
      this.$axios.post(this.$httpUrl + '/wms/storage/update', this.form).then(res => res.data).then(res => {
        console.log(res)
        if (res.code == 200) {

          this.$message({
            message: 'Success',
            type: 'success'
          });
          this.centerDialogVisible = false
          this.loadPost()
          this.resetForm()
        } else {
          this.$message({
            message: 'Fail',
            type: 'error'
          });
        }

      })
    },
    save() {
      this.$refs.form.validate((valid) => {
        if (valid) {
          if (this.form.id) {
            this.doMod();
          } else {
            this.doSave();
          }
        } else {
          console.log('error submit!!');
          return false;
        }
      });

    },
    handleSizeChange(val) {
      console.log(`Each page ${val} items`);
      this.pageNum = 1
      this.pageSize = val
      this.loadPost()
    },
    handleCurrentChange(val) {
      console.log(`Current page: ${val}`);
      this.pageNum = val
      this.loadPost()
    },
    resetParam() {
      this.name = ''
    },
    loadPost() {
      this.$axios.post(this.$httpUrl + '/wms/storage/listPage', {
        pageSize: this.pageSize,
        pageNum: this.pageNum,
        param: {
          name: this.name
        }
      }).then(res => res.data).then(res => {
        console.log(res)
        if (res.code == 200) {
          this.tableData = res.data
          this.total = res.total
        } else {
          alert('Failed to access data')
        }

      })
    }
  },
  beforeMount() {
    this.loadPost()
  }
}
</script>

<style scoped>

</style>