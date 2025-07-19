// File: /src/utils/generateToken.js

const jwt = require('jsonwebtoken');

// **Hàm này phải nhận vào cả id và role_id**
const generateToken = (id, role_id) => {
    // payload là thông tin chúng ta muốn "đóng gói" vào token
    const payload = {
        id: id,
        role_id: role_id, 
    };

    // Tạo token với payload, khóa bí mật (secret key), và thời gian hết hạn
    return jwt.sign(
        payload,
        process.env.JWT_SECRET, // Lấy khóa bí mật từ file .env
        {
            expiresIn: '30d', 
        }
    );
};

module.exports = generateToken;