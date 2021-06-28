# This model will contain all constants of project.
# Can store options for select here if you want.
# Create constant for a model with prefix its name.
# IMPORTANT: You should add comment for each constant!!!
class Constant < ApplicationRecord

  # Constant for Project
  PROJECT_REAL_ESTATE_TYPE = { 0 => 'Apartel', 1 => 'Căn hộ', 2 => 'Condotel', 3 => 'Duplex', 4 => 'Penthouse', 5 => 'Sky villa',
                               6 => 'Hometel', 7 => 'Officetel', 8 => 'Sàn thương mại', 9 => 'Biệt thự', 10 => 'Bungalow', 11 => 'Đất nền',
                               12 => 'Liền kề', 13 => 'Shophouse', 14 => 'Shoptel', 15 => 'Đất TMDV', 16 => 'Mini Hotel' } # Loại hình BĐS
  PROJECT_FEATURES = { 0 => 'Mới', 1 => 'Độc quyền', 2 => 'Nổi bật', 3 => 'Flash sale', 4 => 'Sắp mở bán', 5 => 'Đang mở bán' } # Đặc tính dự án
  PROJECT_INTERNAL_UTILITIES = { 0 => 'Bệnh viện', 1 => 'Trung tâm thương mại', 2 => 'Gym', 3 => 'Spa', 4 => 'Bể bơi',
                                 5 => 'Công viên', 6 => 'Khu vui chơi trẻ em', 7 => 'Trường học', 8 => 'Vườn BBQ',
                                 9 => 'Rạp chiếu phim', 10 => 'Khu vui chơi giải trí' } # Tiện ích nội khu
  PROJECT_OWNERSHIP_PERIOD = { 0 => 'Có thời hạn', 1 => 'Lâu dài' } # Thời hạn sở hữu
  PROJECT_BANK = { 0 => 'NH An Bình - ABBANK', 1 => 'NH Á Châu - ACB', 2 => 'NH NN&PT Nông thôn Việt Nam - Agribank', 3 => 'NH Bắc Á - Bac A Bank',
                   4 => 'NH Bảo Việt - BAOVIET Bank', 5 => 'NH Đầu tư và Phát triển Việt Nam - BIDV', 6 => 'NH Xây dựng - CB', 7 => 'NH Đông Á - DongA Bank',
                   8 => 'NH Xuất Nhập Khẩu - Eximbank', 9 => 'NH Dầu khí toàn cầu - GPBank', 10 => 'NH Phát triển TP.Hồ Chí Minh - HDBank',
                   11 => 'NH Bưu điện Liên Việt - LienVietPostBank', 12 => 'NH Quân Đội - MB', 13 => 'NH Hàng Hải - MSB', 14 => 'NH Nam Á - Nam A Bank',
                   15 => 'NH Quốc dân - NCB',
                   16 => 'NH Phương Đông - OCB', 17 => 'NH Đại Dương - OceanBank', 18 => 'NH Public Bank Việt Nam - PBVN', 19 => 'NH Xăng dầu Petrolimex - PG Bank',
                   20 => 'NH Đại Chúng Việt Nam - PVcomBank', 21 => 'NH Sài Gòn Thương Tín - Sacombank', 22 => 'NH Sài Gòn Công Thương - SAIGONBANK',
                   23 => 'NH Sài Gòn - SCB', 24 => 'NH Đông Nam Á - SeABank', 25 => 'NH Sài Gòn Hà Nội - SHB', 26 => 'NH Shinhan Việt Nam - SHBVN',
                   27 => 'NH Kỹ Thương - Techcombank', 28 => 'NH Tiên Phong - TPBank', 29 => 'NH Quốc tế - VIB', 30 => 'NH Bản Việt - Viet Capital Bank',
                   31 => 'NH Việt Á - VietABank', 32 => 'NH Việt Nam Thương Tín - Vietbank', 33 => 'NH Ngoại Thương Việt Nam - Vietcombank',
                   34 => 'NH Công Thương Việt Nam - Vietinbank', 35 => 'NH Việt Nam Thịnh Vượng - VPBank' } # Ngân hàng hỗ trợ vay
  PROJECT_COMMISSION_TYPE = { 0 => 'Cố định', 1 => '%' } # Hình thức tính phí môi giới
  PROJECT_LEGAL_DOCUMENTS = { 0 => 'VB Tư cách pháp lý/chứng chỉ hành nghề của CĐT', 1 => 'Quy hoạch chi tiết tỉ lệ 1/500 được phê duyệt', 2 => 'QĐ giao đất/cho thuê đất',
                              3 => 'QĐ phê duyệt chủ trương đầu tư dự án', 4 => 'Giấy tờ về quyền sử dụng đất', 5 => 'Giấy phép xây dựng' } # Pháp lý dự án

  # Constant for Product
  PRODUCT_LEVELS = {
      0 => 'Cao tầng',
      1 => 'Thấp tầng'
    }

  PRODUCT_DIVISION_TYPES = {
      0 => 'Phân khu',
      1 => 'Toà',
      2 => 'Đường/Dãy',
      3 => 'Tầng'
    }

  PRODUCT_REAL_ESTATE_TYPES = {
      0 => {
        0 => 'Apartel',
        1 => 'Căn hộ',
        2 => 'Condotel',
        3 => 'Duplex',
        4 => 'Penthouse',
        5 => 'Sky villa',
        6 => 'Hometel',
        7 => 'Officetel',
        8 => 'Sàn thương mại'
      },
      1 => {
        9 => 'Biệt thự',
        10 => 'Bungalow',
        11 => 'Đất nền',
        12 => 'Liền kề',
        13 => 'Shophouse',
        14 => 'Shoptel',
        15 => 'Đất TMDV',
        16 => 'Mini Hotel'
      }
    }

  PRODUCT_TYPES = {
      0 => {
        0 => '1 PN',
        1 => '2 PN',
        2 => '3 PN',
        3 => '4 PN',
        4 => 'Studio',
        5 => 'Không chia phòng'
      },
      1 => {
        6 => 'Đơn lập',
        7 => 'Song lập',
        8 => 'Tứ lập'
      }
    }

  PRODUCT_DIRECTIONS = {
      0 => 'Đông',
      1 => 'Tây',
      2 => 'Nam',
      3 => 'Bắc',
      4 => 'Đông Nam',
      5 => 'Tây Nam',
      6 => 'Đông Bắc',
      7 => 'Tây Bắc'
    }

  PRODUCT_CERTIFICATES = {
      0 => 'Sổ hồng',
      1 => 'Sổ đỏ'
    }

  PRODUCT_UNITS = {
      0 => 'Tỷ',
      1 => 'Triệu',
      2 => 'Nghìn'
    }

  PRODUCT_CURRENCIES = {
      0 => 'VNĐ',
      1 => 'USD',
      2 => 'EUR'
    }

  PRODUCT_USE_TERMS = {
      0 => '50 năm',
      1 => '70 năm',
      2 => 'Lâu dài'
    }

  PRODUCT_FURNITURES = {
      0 => 'Thô',
      1 => 'Đính tường',
      2 => 'Toàn bộ'
    }

  PRODUCT_FURN_QUALITIES = {
      0 => 'Cao cấp',
      1 => 'Trung cấp',
      2 => 'Bình dân'
    }

  # Constant for Customer
  CUSTOMER_GENDER = { 0 => 'Nam', 1 => 'Nữ', 2 => 'Khác' }
  CUSTOMER_DATA_SOURCE = { 0 => 'Data import', 1 => 'Kinh doanh', 2 => 'Facebook', 3 => 'Google', 4 => 'Event',
                           5 => 'SMS brandname', 6 => 'Viber', 7 => 'Zalo', 8 => 'Messenger',
                           9 => 'Email MKT', 10 => 'Ad-network', 11 => 'PR' }
  CUSTOMER_CUSTOMER_CHARACTERISTIC = { 0 => 'Khách hàng có thu nhập cao' }
  CUSTOMER_MARITAL_STATUS = {
    0 => 'Độc thân',
    1 => 'Đã đính hôn',
    2 => 'Đã kết hôn',
    3 => 'Ly thân',
    4 => 'Ly hôn',
    5 => 'Góa'
  }
  LABEL_PAYMENT_SCHEDULE = { 0 => 'Chính sách thanh toán khối Cao tầng',
                             1 => 'Chính sách thanh toán khối Thấp tầng',
                             2 => 'Tiến độ thanh toán khối Cao tầng',
                             3 => 'Tiến độ thanh toán khối Thấp tầng' }
  ICONS = {
    0 => 'fa-info-circle', # info
    1 => 'fa-exclamation-circle', # warning
    2 => 'fa-times-circle-o', # error
    3 => 'fa-check-circle', # success
    4 => 'fa-question-circle' # question
  }
  TICKET_TYPE = {
    0 => "Đăng ký tư vấn",
    1 => "Đăng ký xem nhà mẫu",
    2 => "Tính thử giá",
    3 => "Quan tâm dự án"
  }
  TICKET_SOURCE = {
    0 => "Form liên hệ tại footer",
    1 => "Trang Dự án",
    2 => "Trang Sản phẩm"
  }
  BANNER_TYPE = {
    0 => "Top banner",
    1 => "Sub banner",
  }
  CUSTOM_HTML_TYPES = {
    0 => 'home-newspaper-feedback'
  }

  ## Phân loại giao dịch
  DEAL_SUB_SOURCE_GROUP = {
    'Nhận khách từ Công ty' => ['Facebook'],
    'Hotline' => ['Hotline FB', 'Hotline SMS'],
    'Tổng đài CSKH' => ['Telemarketing'],
    'Hoạt động của NVKD' => ['Seeding', 'Đăng tin', 'Telesale', 'Quảng cáo của NVKD', 'Trực dự án', 'Khác'],
    'Giới thiệu' => ['Người quen của NVKD giới thiệu', 'Người quen (Nguồn Công ty) giới thiệu', 'Khách cũ giới thiệu'],
    'Chiến dịch khác' => ['Chiến dịch khác'],
    'Website & Hoạt động Marketing' => ['Paid Social', 'Social Media', 'Email Marketing', 'Paid Search', 'Organic Search', 'Direct Booking', 'Direct Traffic', 'Other Campaign', 'Referral', 'Display']
  }

  SOURCE_FB_MESSENGER = 0
  SOURCE_FB_COMMENT = 24
  SOURCE_HOTLINE_FB = 1
  SOURCE_HOTLINE_SMS = 2
  SOURCE_TELEMARKETING = 3
  SOURCE_SEEDING = 4
  SOURCE_DANG_TIN = 5
  SOURCE_TELESALE = 6
  SOURCE_QCNVKD = 7
  SOURCE_TRUC_DU_AN = 8
  SOURCE_KHAC = 9
  SOURCE_NQNVKD = 10
  SOURCE_NQCT = 11
  SOURCE_KCGT = 12
  SOURCE_CHIEN_DICH_KHAC = 13
  SOURCE_PAID_SOCIAL = 14
  SOURCE_SOCIAL_MEDIA = 15
  SOURCE_EMAIL_MARKETING = 16
  SOURCE_PAID_SEARCH = 17
  SOURCE_ORGANIC_SEARCH = 18
  SOURCE_DIRECT_BOOKING = 19
  SOURCE_DIRECT_TRAFFIC = 20
  SOURCE_OTHER_CAMPAIGN = 21
  SOURCE_REFERRAL = 22
  SOURCE_DISPLAY = 23

  DEAL_SOURCE_GROUP = {
    'Nhận khách từ Công ty' => [['Facebook messenger', SOURCE_FB_MESSENGER, {'title' => 'KH liên hệ qua trang facebook của công ty'}],
                                ['Facebook comment', SOURCE_FB_COMMENT, {'title' => 'KH để lại bình luận qua trang facebook của công ty'}]],
    'Hotline' => [['Hotline FB', SOURCE_HOTLINE_FB, {'title' => 'KH liên hệ qua Hotline FB của công ty'}],
                  ['Hotline SMS', SOURCE_HOTLINE_SMS, {'title' => 'KH liên hệ qua Hotline SMS của công ty'}]],
    'Tổng đài CSKH' => [['Telemarketing', SOURCE_TELEMARKETING, {'title' => 'KH liên hệ qua tổng đài CSKH của công ty hoặc do KH do bộ phận CSKH của Công ty khai thác'}]],
    'Hoạt động của NVKD' => [['Seeding', SOURCE_SEEDING, {'title' => 'KH đến từ việc seeding của NVKD trên các hội nhóm (bài đăng không mất phí)'}],
                             ['Đăng tin', SOURCE_DANG_TIN, {'title' => 'KH đến từ việc đăng tin của NVKD trên các web mất phí (ví dụ batdongsan.com.vn...)'}],
                             ['Telesale', SOURCE_TELESALE, {'title' => 'KH đến từ telesale do NVKD khai thác'}],
                             ['Quảng cáo của NVKD', SOURCE_QCNVKD, {'title' => 'KH đến từ quảng cáo của NVKD'}],
                             ['Trực dự án', SOURCE_TRUC_DU_AN, {'title' => 'KH do NVKD tiếp cận tại dự án'}],
                             ['Khác', SOURCE_KHAC, {'title' => 'KH từ các nguồn khác của NVKD'}]],
    'Giới thiệu' => [['Người quen của NVKD giới thiệu', SOURCE_NQNVKD, {'title' => 'KH là người quen của NVKD/do người quen của NVKD giới thiệu'}],
                     ['Người quen (Nguồn Công ty) giới thiệu', SOURCE_NQCT, {'title' => 'KH là người quen do công ty giới thiệu'}],
                     ['Khách cũ giới thiệu', SOURCE_KCGT, {'title' => 'KH do khách cũ giới thiệu'}]],
    'Chiến dịch khác' => [['Chiến dịch khác', SOURCE_CHIEN_DICH_KHAC, {'title' => 'KH đến từ các chiến dịch khác của công ty'}]],
    'Website & Hoạt động Marketing' => [['Paid Social', SOURCE_PAID_SOCIAL, {'title' => 'KH đến từ các mạng xã hội ((facebook, instagram, google+...) thông qua các chiến dịch quảng cáo của công ty'}],
                                        ['Social Media', SOURCE_SOCIAL_MEDIA, {'title' => 'KH miễn phí đến từ các mạng xã hội (facebook, instagram, google+...)'}],
                                        ['Email Marketing', SOURCE_EMAIL_MARKETING, {'title' => 'KH đến từ các chiến dịch email marketing'}],
                                        ['Paid Search', SOURCE_PAID_SEARCH, {'title' => 'KH đến từ các phương tiện tìm kiếm mất phí'}],
                                        ['Organic Search', SOURCE_ORGANIC_SEARCH, {'title' => 'KH đến từ các phương tiện tìm kiếm không mất phí'}],
                                        ['Direct Booking', SOURCE_DIRECT_BOOKING, {'title' => 'KH truy cập và booking trực tiếp website reti.vn từ trình duyệt'}],
                                        ['Direct Traffic', SOURCE_DIRECT_TRAFFIC, {'title' => 'KH truy cập và để lại thông tin nhận tư vấn, báo giá (các trang ngoại trừ trang booking sp) trực tiếp website reti.vn từ trình duyệt'}],
                                        ['Other Campaign', SOURCE_OTHER_CAMPAIGN, {'title' => 'KH vào từ đường dẫn có UTM chứa thông số của Paid social hoặc Paid search nhưng không định nghĩa được trường campaign'}],
                                        ['Referral', SOURCE_REFERRAL, {'title' => 'KH đến từ các website bên ngoài reti.vn'}],
                                        ['Display', SOURCE_DISPLAY, {'title' => 'KH đến từ quảng cáo thông qua GDN'}]],
  }
  DEAL_SOURCES = {
    SOURCE_FB_MESSENGER => 'Facebook messenger',
    SOURCE_FB_COMMENT => 'Facebook comment',
    SOURCE_HOTLINE_FB => 'Hotline FB',
    SOURCE_HOTLINE_SMS => 'Hotline SMS',
    SOURCE_TELEMARKETING => 'Telemarketing',
    SOURCE_SEEDING => 'Seeding',
    SOURCE_DANG_TIN => 'Đăng tin',
    SOURCE_TELESALE => 'Telesale',
    SOURCE_QCNVKD => 'Quảng cáo của NVKD',
    SOURCE_TRUC_DU_AN => 'Trực dự án',
    SOURCE_KHAC => 'Khác',
    SOURCE_NQNVKD => 'Người quen của NVKD giới thiệu',
    SOURCE_NQCT => 'Người quen (Nguồn Công ty) giới thiệu',
    SOURCE_KCGT => 'Khách cũ giới thiệu',
    SOURCE_CHIEN_DICH_KHAC => 'Chiến dịch khác',
    SOURCE_PAID_SOCIAL => 'Paid Social',
    SOURCE_SOCIAL_MEDIA => 'Social Media',
    SOURCE_EMAIL_MARKETING => 'Email Marketing',
    SOURCE_PAID_SEARCH => 'Paid Search',
    SOURCE_ORGANIC_SEARCH => 'Organic Search',
    SOURCE_DIRECT_BOOKING => 'Direct Booking',
    SOURCE_DIRECT_TRAFFIC => 'Direct Traffic',
    SOURCE_OTHER_CAMPAIGN => 'Other Campaign',
    SOURCE_REFERRAL => 'Referral',
    SOURCE_DISPLAY => 'Display',
  }
  ## Chờ xử lý
  # Trạng thái liên hệ
  CONTACT_STATUSES = {
    0 => 'Chưa gọi',
    1 => 'Sai số',
    2 => 'Bận máy/Không nghe máy',
    3 => 'Bận máy/Không nghe máy L2',
    4 => 'Bận máy/Không nghe máy L3',
    5 => 'Thuê bao',
    6 => 'Thuê bao L2',
    7 => 'Thuê bao L3',
    8 => 'Đã liên hệ',
    9 => 'Không quan tâm'
  }

  ## Đang quan tâm
  # Mức độ quan tâm
  INTEREST_LEVELS = {
    0 => 'Chỉ tham khảo thông tin',
    1 => 'Không đủ tài chính',
    2 => 'Có quan tâm, thiện chí tương tác nhưng chưa khai thác được sâu',
    3 => 'Rất quan tâm nhưng còn lăn tăn',
    4 => 'Rất quan tâm'
  }

  # Trạng thái tương tác
  INTERACTION_STATUSES = {
    0 => 'Đã gửi thông tin',
    1 => 'Đang tương tác',
    2 => 'Đã hẹn gặp'
  }

  # Các bước tương tác
  INTERACTION_CHECKLIST = {
    0 => 'Tư vấn tổng quan dự án (Chủ đầu tư, Vị trí)',
    1 => 'Tư vấn loại hình',
    2 => 'Tư vấn pháp lý',
    3 => 'Tư vấn tiến độ',
    4 => 'Tư vấn tài chính'
  }

  PROBLEMS = {
    0 => 'Vị trí',
    1 => 'Giá cả',
    2 => 'Dự án khác',
    3 => 'Pháp lý',
    4 => 'Tiềm năng đầu tư',
    5 => 'Khác'
  }

  ONLINE_FEEDBACKS = {
    0 => 'Email',
    1 => 'SMS'
  }

  CANCELED_REASON = {
    0 => 'Không đủ tài chính',
    1 => 'Khách không quan tâm',
    2 => 'Quan tâm sản phẩm khác',
    3 => 'Khách thay đổi nhu cầu',
    4 => 'Sai số điện thoại',
    5 => 'Thuê bao không liên lạc được',
    6 => 'Khác', #⇒ Hệ thống hiển thị text box để sale note lý do
    7 => 'Môi giới',
  }

  APPOINTMENT_STATE = {
    0 => 'Đã gặp',
    1 => 'Hủy hẹn',
  }

  FILTER_RESULTS = {
    0 => 'Nhãn',
    1 => 'Mức độ quan tâm',
    2 => 'Nhóm kinh doanh',
    3 => 'Ngày tạo',
    4 => 'Ngày cập nhật mới nhất',
    5 => 'Mục đích mua',
    6 => 'Loại hình sản phẩm',
    7 => 'Hướng cửa',
    8 => 'Hướng ban công'
  }

  # Mục đích mua
  PURCHASE_PURPOSE = {
    0 => 'Mua để ở',
    1 => 'Mua đầu tư kinh doanh',
    2 => 'Mua đầu tư lướt sóng',
    3 => 'Mua cho bố/mẹ',
    4 => 'Mua cho con'
  }
end
