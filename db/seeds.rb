# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
User.create(email: 'admin@graduate.vn', password: 'quan2910', password_confirmation: 'quan2910', full_name: 'Super Super Admin', account_type: 0, is_superadmin: true)

# Create Roles
unless Role.find_by name: "Sale Member"
  sale_member_role = Role.new name: "Sale Member"
  sale_member_role.permissions.build can_edit: true, can_edit_other: false, can_create: true, can_view: true, can_view_other: false, can_delete: true, can_delete_other: false, can_import: false, change_state: false, name: "Khách hàng"
  sale_member_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Tài khoản nội bộ"
  sale_member_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Chủ đầu tư"
  sale_member_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Tổng thầu"
  sale_member_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Đơn vị phát triển"
  sale_member_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Đơn vị quản lý"
  sale_member_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: true, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Dự án"
  sale_member_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: true, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Bảng hàng sản phẩm"
  sale_member_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: true, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Mặt bằng"
  sale_member_role.permissions.build can_edit: true, can_edit_other: false, can_create: true, can_view: true, can_view_other: false, can_delete: true, can_delete_other: false, can_import: false, change_state: false, name: "Phiếu cọc"
  sale_member_role.permissions.build can_edit: true, can_edit_other: false, can_create: false, can_view: true, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Đăng ký tư vấn"
  sale_member_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Banner"
  sale_member_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Custom Html"
  sale_member_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Tài khoản khách hàng"
  sale_member_role.save
end

unless Role.find_by name: "Sale Leader"
  sale_leader_role = Role.new name: "Sale Leader"
  sale_leader_role.permissions.build can_edit: true, can_edit_other: true, can_create: true, can_view: true, can_view_other: true, can_delete: true, can_delete_other: true, can_import: true, change_state: false, name: "Khách hàng"
  sale_leader_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Tài khoản nội bộ"
  sale_leader_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Chủ đầu tư"
  sale_leader_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Tổng thầu"
  sale_leader_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Đơn vị phát triển"
  sale_leader_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Đơn vị quản lý"
  sale_leader_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: true, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Dự án"
  sale_leader_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: true, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Bảng hàng sản phẩm"
  sale_leader_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: true, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Mặt bằng"
  sale_leader_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Phiếu cọc"
  sale_leader_role.permissions.build can_edit: true, can_edit_other: false, can_create: false, can_view: true, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Đăng ký tư vấn"
  sale_leader_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Banner"
  sale_leader_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Custom Html"
  sale_leader_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Tài khoản khách hàng"
  sale_leader_role.save
end

unless Role.find_by name: "Sale Admin"
  sale_admin_role = Role.new name: "Sale Admin"
  sale_admin_role.permissions.build can_edit: true, can_edit_other: false, can_create: true, can_view: true, can_view_other: false, can_delete: true, can_delete_other: false, can_import: true, change_state: false, name: "Khách hàng"
  sale_admin_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Tài khoản nội bộ"
  sale_admin_role.permissions.build can_edit: true, can_edit_other: true, can_create: true, can_view: true, can_view_other: true, can_delete: true, can_delete_other: true, can_import: true, change_state: false, name: "Chủ đầu tư"
  sale_admin_role.permissions.build can_edit: true, can_edit_other: true, can_create: true, can_view: true, can_view_other: true, can_delete: true, can_delete_other: true, can_import: true, change_state: false, name: "Tổng thầu"
  sale_admin_role.permissions.build can_edit: true, can_edit_other: true, can_create: true, can_view: true, can_view_other: true, can_delete: true, can_delete_other: true, can_import: true, change_state: false, name: "Đơn vị phát triển"
  sale_admin_role.permissions.build can_edit: true, can_edit_other: true, can_create: true, can_view: true, can_view_other: true, can_delete: true, can_delete_other: true, can_import: true, change_state: false, name: "Đơn vị quản lý"
  sale_admin_role.permissions.build can_edit: true, can_edit_other: true, can_create: true, can_view: true, can_view_other: true, can_delete: true, can_delete_other: true, can_import: true, change_state: false, name: "Dự án"
  sale_admin_role.permissions.build can_edit: true, can_edit_other: true, can_create: true, can_view: true, can_view_other: true, can_delete: true, can_delete_other: true, can_import: true, change_state: false, name: "Bảng hàng sản phẩm"
  sale_admin_role.permissions.build can_edit: true, can_edit_other: true, can_create: true, can_view: true, can_view_other: true, can_delete: true, can_delete_other: true, can_import: true, change_state: false, name: "Mặt bằng"
  sale_admin_role.permissions.build can_edit: true, can_edit_other: true, can_create: true, can_view: true, can_view_other: true, can_delete: false, can_delete_other: false, can_import: true, change_state: false, name: "Phiếu cọc"
  sale_admin_role.permissions.build can_edit: true, can_edit_other: false, can_create: false, can_view: true, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Đăng ký tư vấn"
  sale_admin_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Banner"
  sale_admin_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Custom Html"
  sale_admin_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Tài khoản khách hàng"
  sale_admin_role.save
end

unless Role.find_by name: "Kế toán"
  accountant_role = Role.new name: "Kế toán"
  accountant_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Khách hàng"
  accountant_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Tài khoản nội bộ"
  accountant_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Chủ đầu tư"
  accountant_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Tổng thầu"
  accountant_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Đơn vị phát triển"
  accountant_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Đơn vị quản lý"
  accountant_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Dự án"
  accountant_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Bảng hàng sản phẩm"
  accountant_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Mặt bằng"
  accountant_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Phiếu cọc"
  accountant_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Đăng ký tư vấn"
  accountant_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Banner"
  accountant_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Custom Html"
  accountant_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Tài khoản khách hàng"
  accountant_role.save
end

unless Role.find_by name: "Leader Kế toán"
  accountant_role = Role.new name: "Leader Kế toán"
  accountant_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Khách hàng"
  accountant_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Tài khoản nội bộ"
  accountant_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Chủ đầu tư"
  accountant_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Tổng thầu"
  accountant_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Đơn vị phát triển"
  accountant_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Đơn vị quản lý"
  accountant_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Dự án"
  accountant_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Bảng hàng sản phẩm"
  accountant_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Mặt bằng"
  accountant_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Phiếu cọc"
  accountant_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Đăng ký tư vấn"
  accountant_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Banner"
  accountant_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Custom Html"
  accountant_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Tài khoản khách hàng"
  accountant_role.save
end

unless Role.find_by name: "Marketing"
  marketing_role = Role.new name: "Marketing"
  marketing_role.permissions.build can_edit: true, can_edit_other: true, can_create: true, can_view: true, can_view_other: true, can_delete: true, can_delete_other: true, can_import: true, change_state: false, name: "Khách hàng"
  marketing_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Tài khoản nội bộ"
  marketing_role.permissions.build can_edit: true, can_edit_other: true, can_create: true, can_view: true, can_view_other: true, can_delete: true, can_delete_other: true, can_import: true, change_state: false, name: "Chủ đầu tư"
  marketing_role.permissions.build can_edit: true, can_edit_other: true, can_create: true, can_view: true, can_view_other: true, can_delete: true, can_delete_other: true, can_import: true, change_state: false, name: "Tổng thầu"
  marketing_role.permissions.build can_edit: true, can_edit_other: true, can_create: true, can_view: true, can_view_other: true, can_delete: true, can_delete_other: true, can_import: true, change_state: false, name: "Đơn vị phát triển"
  marketing_role.permissions.build can_edit: true, can_edit_other: true, can_create: true, can_view: true, can_view_other: true, can_delete: true, can_delete_other: true, can_import: true, change_state: false, name: "Đơn vị quản lý"
  marketing_role.permissions.build can_edit: true, can_edit_other: true, can_create: true, can_view: true, can_view_other: true, can_delete: true, can_delete_other: true, can_import: true, change_state: false, name: "Dự án"
  marketing_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: true, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Bảng hàng sản phẩm"
  marketing_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: true, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Mặt bằng"
  marketing_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: true, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Phiếu cọc"
  marketing_role.permissions.build can_edit: true, can_edit_other: false, can_create: false, can_view: true, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Đăng ký tư vấn"
  marketing_role.permissions.build can_edit: true, can_edit_other: false, can_create: true, can_view: true, can_view_other: false, can_delete: true, can_delete_other: false, can_import: false, change_state: false, name: "Banner"
  marketing_role.permissions.build can_edit: true, can_edit_other: false, can_create: true, can_view: true, can_view_other: false, can_delete: true, can_delete_other: false, can_import: false, change_state: false, name: "Custom Html"
  marketing_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Tài khoản khách hàng"
  marketing_role.save
end

unless Role.find_by name: "Giám đốc kinh doanh"
  sale_manager_role = Role.new name: "Giám đốc kinh doanh"
  sale_manager_role.permissions.build can_edit: true, can_edit_other: true, can_create: true, can_view: true, can_view_other: true, can_delete: true, can_delete_other: true, can_import: true, change_state: false, name: "Khách hàng"
  sale_manager_role.permissions.build can_edit: true, can_edit_other: false, can_create: true, can_view: true, can_view_other: false, can_delete: true, can_delete_other: false, can_import: true, change_state: false, name: "Tài khoản nội bộ"
  sale_manager_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Chủ đầu tư"
  sale_manager_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Tổng thầu"
  sale_manager_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Đơn vị phát triển"
  sale_manager_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Đơn vị quản lý"
  sale_manager_role.permissions.build can_edit: true, can_edit_other: true, can_create: true, can_view: true, can_view_other: true, can_delete: true, can_delete_other: true, can_import: true, change_state: false, name: "Dự án"
  sale_manager_role.permissions.build can_edit: true, can_edit_other: true, can_create: true, can_view: true, can_view_other: true, can_delete: true, can_delete_other: true, can_import: true, change_state: true, name: "Bảng hàng sản phẩm"
  sale_manager_role.permissions.build can_edit: true, can_edit_other: true, can_create: true, can_view: true, can_view_other: true, can_delete: true, can_delete_other: true, can_import: true, change_state: false, name: "Mặt bằng"
  sale_manager_role.permissions.build can_edit: true, can_edit_other: true, can_create: true, can_view: true, can_view_other: true, can_delete: true, can_delete_other: true, can_import: true, change_state: true, name: "Phiếu cọc"
  sale_manager_role.permissions.build can_edit: true, can_edit_other: false, can_create: false, can_view: true, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: true, name: "Đăng ký tư vấn"
  sale_manager_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Banner"
  sale_manager_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Custom Html"
  sale_manager_role.permissions.build can_edit: false, can_edit_other: false, can_create: false, can_view: false, can_view_other: false, can_delete: false, can_delete_other: false, can_import: false, change_state: false, name: "Tài khoản khách hàng"
  sale_manager_role.save
end

unless Role.find_by name: "Super Admin"
  super_admin_role = Role.new name: "Super Admin"
  super_admin_role.permissions.build can_edit: true, can_edit_other: true, can_create: true, can_view: true, can_view_other: true, can_delete: true, can_delete_other: true, can_import: true, change_state: false, name: "Khách hàng"
  super_admin_role.permissions.build can_edit: true, can_edit_other: true, can_create: true, can_view: true, can_view_other: true, can_delete: true, can_delete_other: true, can_import: true, change_state: false, name: "Tài khoản nội bộ"
  super_admin_role.permissions.build can_edit: true, can_edit_other: true, can_create: true, can_view: true, can_view_other: true, can_delete: true, can_delete_other: true, can_import: true, change_state: false, name: "Chủ đầu tư"
  super_admin_role.permissions.build can_edit: true, can_edit_other: true, can_create: true, can_view: true, can_view_other: true, can_delete: true, can_delete_other: true, can_import: true, change_state: false, name: "Tổng thầu"
  super_admin_role.permissions.build can_edit: true, can_edit_other: true, can_create: true, can_view: true, can_view_other: true, can_delete: true, can_delete_other: true, can_import: true, change_state: false, name: "Đơn vị phát triển"
  super_admin_role.permissions.build can_edit: true, can_edit_other: true, can_create: true, can_view: true, can_view_other: true, can_delete: true, can_delete_other: true, can_import: true, change_state: false, name: "Đơn vị quản lý"
  super_admin_role.permissions.build can_edit: true, can_edit_other: true, can_create: true, can_view: true, can_view_other: true, can_delete: true, can_delete_other: true, can_import: true, change_state: false, name: "Dự án"
  super_admin_role.permissions.build can_edit: true, can_edit_other: true, can_create: true, can_view: true, can_view_other: true, can_delete: true, can_delete_other: true, can_import: true, change_state: true, name: "Bảng hàng sản phẩm"
  super_admin_role.permissions.build can_edit: true, can_edit_other: true, can_create: true, can_view: true, can_view_other: true, can_delete: true, can_delete_other: true, can_import: true, change_state: false, name: "Mặt bằng"
  super_admin_role.permissions.build can_edit: true, can_edit_other: true, can_create: true, can_view: true, can_view_other: true, can_delete: true, can_delete_other: true, can_import: true, change_state: true, name: "Phiếu cọc"
  super_admin_role.permissions.build can_edit: true, can_edit_other: true, can_create: true, can_view: true, can_view_other: true, can_delete: true, can_delete_other: true, can_import: true, change_state: true, name: "Đăng ký tư vấn"
  super_admin_role.permissions.build can_edit: true, can_edit_other: true, can_create: true, can_view: true, can_view_other: true, can_delete: true, can_delete_other: true, can_import: true, change_state: false, name: "Banner"
  super_admin_role.permissions.build can_edit: true, can_edit_other: true, can_create: true, can_view: true, can_view_other: true, can_delete: true, can_delete_other: true, can_import: true, change_state: false, name: "Custom Html"
  super_admin_role.permissions.build can_edit: true, can_edit_other: true, can_create: true, can_view: true, can_view_other: true, can_delete: true, can_delete_other: true, can_import: true, change_state: true, name: "Tài khoản khách hàng"
  super_admin_role.save
end

## Update/create internal user with role & permission
## admin = User.where(email: 'admin@graduate.vn').first
#super_admin_role = Role.find_by name: 'Super Admin'
#admin.update_attributes role: super_admin_role
 
#Create Accounts
sale_member = User.find_by email: 'sale_member@graduate.vn'
unless sale_member.present?
  sale_member_role = Role.find_by name: 'Sale Member'
  User.create(email: 'sale_member@graduate.vn', password: 'vsbgxpFmZzZNlYKX', password_confirmation: 'vsbgxpFmZzZNlYKX', full_name: 'Sale Member', account_type: 0, role_id: sale_member_role&.id)
end

sale_leader = User.find_by email: 'sale_leader@graduate.vn'
unless sale_leader.present?
  sale_leader_role = Role.find_by name: 'Sale Leader'
  User.create(email: 'sale_leader@graduate.vn', password: 'vsbgxpFmZzZNlYKX', password_confirmation: 'vsbgxpFmZzZNlYKX', full_name: 'Sale Leader', account_type: 0, role_id: sale_leader_role&.id)
end

sale_admin = User.find_by email: 'sale_admin@graduate.vn'
unless sale_admin.present?
  sale_admin_role = Role.find_by name: "Sale Admin"
  User.create(email: 'sale_admin@graduate.vn', password: 'vsbgxpFmZzZNlYKX', password_confirmation: 'vsbgxpFmZzZNlYKX', full_name: 'Sale Admin', account_type: 0, role_id: sale_admin_role&.id)
end

accountant = User.find_by email: 'accountant@graduate.vn'
unless accountant.present?
  accountant_role = Role.find_by name: 'Kế toán'
  User.create(email: 'accountant@graduate.vn', password: 'vsbgxpFmZzZNlYKX', password_confirmation: 'vsbgxpFmZzZNlYKX', full_name: 'TMS Accountant', account_type: 0, role_id: accountant_role&.id)
end

marketing = User.find_by email: 'marketing@graduate.vn'
unless marketing.present?
  marketing_role = Role.find_by name: "Marketing"
  User.create(email: 'marketing@graduate.vn', password: 'vsbgxpFmZzZNlYKX', password_confirmation: 'vsbgxpFmZzZNlYKX', full_name: 'TMS Marketing', account_type: 0, role_id: marketing_role&.id)
end

sale_manager = User.find_by email: 'sale_manager@graduate.vn'
unless sale_manager.present?
  sale_manager_role = Role.find_by name: "Giám đốc kinh doanh"
  User.create(email: 'sale_manager@graduate.vn', password: 'vsbgxpFmZzZNlYKX', password_confirmation: 'vsbgxpFmZzZNlYKX', full_name: 'Sale Manager', account_type: 0, role_id: sale_manager_role&.id)
end

# Create investor user with role & permission
investor_admin = User.find_by email: 'investor_admin@graduate.vn'
unless investor_admin.present?
  User.create(email: 'investor_admin@graduate.vn', password: 'vsbgxpFmZzZNlYKX', password_confirmation: 'vsbgxpFmZzZNlYKX', full_name: 'Investor Admin', account_type: 1, role_id: super_admin_role&.id)
end

# Create agent user with role & permission
agent_admin = User.find_by email: 'agent_admin@graduate.vn'
unless agent_admin.present?
  User.create(email: 'agent_admin@graduate.vn', password: 'vsbgxpFmZzZNlYKX', password_confirmation: 'vsbgxpFmZzZNlYKX', full_name: 'Agent Admin', account_type: 2, role_id: super_admin_role&.id)
end