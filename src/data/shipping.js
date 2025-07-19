// File: /src/data/shippingRates.js

// Đây là nơi ta định nghĩa bảng giá vận chuyển
// Key là tên Tỉnh/Thành phố (cần phải giống hệt với giá trị trong thẻ <option>)
// 'default' là mức phí cho các tỉnh thành khác không được liệt kê.
const shippingRates = {
    "Thành phố Hồ Chí Minh": {
        // Key là tên Quận/Huyện, 'default' là phí cho các quận/huyện khác
        rates: {
            "Quận 1": 15000,
            "Quận 3": 15000,
            "Quận 4": 15000,
            "Quận 5": 15000,
            "Quận 10": 15000,
            "Quận Phú Nhuận": 18000,
            "Quận Bình Thạnh": 18000,
            "Thành phố Thủ Đức": 25000,
            "Huyện Củ Chi": 35000,
            "Huyện Cần Giờ": 35000,
            "default": 22000 // Phí mặc định cho các quận nội thành khác
        },
    },
    "Thành phố Hà Nội": {
        rates: {
            "Quận Hoàn Kiếm": 20000,
            "Quận Ba Đình": 20000,
            "Quận Đống Đa": 20000,
            "Quận Hai Bà Trưng": 20000,
            "Quận Cầu Giấy": 25000,
            "default": 30000 // Phí mặc định cho các quận/huyện khác ở Hà Nội
        },
    },
    // Mức phí mặc định cho tất cả các tỉnh thành khác
    "default": 35000 
};

// Hàm để tính toán phí vận chuyển
const calculateShippingFee = (province, district) => {
    // Tìm thông tin của tỉnh/thành phố được chọn
    const provinceData = shippingRates[province];

    // Nếu tỉnh/thành phố đó có trong bảng giá của chúng ta
    if (provinceData) {
        // Tìm phí của quận/huyện cụ thể, nếu không có thì lấy phí mặc định của tỉnh đó
        const fee = provinceData.rates[district] || provinceData.rates.default;
        return fee;
    }
    
    // Nếu không tìm thấy tỉnh/thành phố, trả về mức phí mặc định toàn quốc
    return shippingRates.default;
};

module.exports = { calculateShippingFee };