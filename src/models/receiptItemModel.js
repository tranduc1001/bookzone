// File: /src/models/receiptItemModel.js

const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/connectDB');

const ReceiptItem = sequelize.define('ReceiptItem', {
    id: {
        type: DataTypes.BIGINT,
        primaryKey: true,
        autoIncrement: true,
    },
    
    receipt_id: {
        type: DataTypes.BIGINT,
        allowNull: false,
    },
    
    product_id: {
        type: DataTypes.BIGINT,
        allowNull: false,
    },
    so_luong_nhap: {
        type: DataTypes.INTEGER,
        allowNull: false,
        defaultValue: 1, 
    },
    gia_nhap: {
        type: DataTypes.DECIMAL(12, 2), 
        allowNull: false,
    },
    chiet_khau: {
        type: DataTypes.DECIMAL(12, 2), 
        allowNull: false,
        defaultValue: 0.00 
    },
    thanh_tien: {
       
        type: DataTypes.DECIMAL(15, 2),
        allowNull: false
    }
    // ==========================================================

}, {
    tableName: 'receipt_items',
    timestamps: true,
    
    hooks: {
        beforeValidate: (receiptItem) => {
            
            const giaSauChietKhau = parseFloat(receiptItem.gia_nhap) - parseFloat(receiptItem.chiet_khau);
            if (giaSauChietKhau < 0) {
                throw new Error("Chiết khấu không thể lớn hơn giá nhập.");
            }
            receiptItem.thanh_tien = giaSauChietKhau * parseInt(receiptItem.so_luong_nhap);
        }
    }
});

ReceiptItem.associate = (models) => {
    // Quan hệ: Một Chi tiết phiếu nhập thuộc về một Phiếu nhập
    ReceiptItem.belongsTo(models.Receipt, {
        foreignKey: 'receipt_id',
        as: 'receipt'
    });

    // Quan hệ: Một Chi tiết phiếu nhập ứng với một Sản phẩm
    ReceiptItem.belongsTo(models.Product, {
        foreignKey: 'product_id',
        as: 'product'
    });
};

module.exports = ReceiptItem;