<template>
  <div style="display: flex;line-height: 60px">
    <div style="margin-top: 8px;">
      <i :class="icon" style="font-size: 20px;cursor: pointer;" @click="collapse"></i>
    </div>
    <div style="flex: 1;text-align: center;font-size: 40px;">
      <span>Sunridge Warehouse Management System</span>
    </div>
    <el-dropdown>
      <span>{{ user.name }}</span>
      <i class="el-icon-arrow-down" style="margin-left: 5px"></i>
      <el-dropdown-menu slot="dropdown">
        <el-dropdown-item @click.native="toUser">Profile</el-dropdown-item>
        <el-dropdown-item @click.native="logout">Logout</el-dropdown-item>
      </el-dropdown-menu>
    </el-dropdown>
  </div>
</template>

<script>
export default {
  name: "Header",
  data() {
    return {
      user: sessionStorage.getItem('CurUser') && JSON.parse(sessionStorage.getItem('CurUser'))
    }
  },
  props: {
    icon: String
  },
  methods: {
    toUser() {
      alert("Profile detail")
      this.$router.push("/Home")
    },
    logout() {
      this.$confirm('Are your sure to log out?', 'Hint', {
        confirmButtonText: 'Confirm',  //确认按钮的文字显示
        type: 'warning',
        center: true, //文字居中显示
      }).then(() => {
        this.$message({
          type: 'success',
          message: 'Logged out successfully...'
        })
        this.$router.push("/")
        sessionStorage.clear()
      }).catch(() => {
        this.$message({
          type: 'info',
          message: 'Cancel the logout '
        })
      })
    },
    collapse() {
      this.$emit('doCollapse')
    }
  },
  created() {
    this.$router.push("/Home")
  }
}
</script>

<style scoped>

</style>