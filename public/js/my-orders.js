// File: /public/js/my-orders.js (PHIÊN BẢN NÂNG CẤP HOÀN CHỈNH)

document.addEventListener('DOMContentLoaded', () => {
    // === BƯỚC 1: KIỂM TRA TOKEN VÀ LẤY CÁC ELEMENT ===
    const token = localStorage.getItem('token');
    if (!token) {
        window.location.href = '/login';
        return;
    }

    const ordersContainer = document.getElementById('orders-container');
    const filterForm = document.getElementById('filter-form');
    const statusSelect = document.getElementById('status-select');
    const keywordInput = document.getElementById('keyword-input'); 

    // Nếu không tìm thấy các element cần thiết, dừng script
    if (!ordersContainer || !filterForm || !statusSelect || !keywordInput) {
        console.error('Lỗi: Không tìm thấy các element cần thiết trên trang.');
        return;
    }

    // === BƯỚC 2: CÁC HÀM TIỆN ÍCH (HELPER FUNCTIONS) ===

    // Hàm lấy thông tin hiển thị cho trạng thái đơn hàng
    const getStatusInfo = (status) => {
        const map = {
            'pending': { text: 'Chờ xác nhận', className: 'text-bg-secondary' },
            'pending_payment': { text: 'Chờ thanh toán', className: 'text-bg-warning' },
            'confirmed': { text: 'Đã xác nhận', className: 'text-bg-primary' },
            'shipping': { text: 'Đang giao', className: 'text-bg-info' },
            'delivered': { text: 'Hoàn thành', className: 'text-bg-success' },
            'cancelled': { text: 'Đã hủy', className: 'text-bg-danger' }
        };
        return map[status] || { text: status, className: 'text-bg-light' };
    };

    // Hàm lấy thông tin hiển thị cho trạng thái thanh toán
    const getPaymentStatusInfo = (isPaid) => {
        return isPaid 
            ? { text: 'Đã thanh toán', className: 'bg-success' }
            : { text: 'Chưa thanh toán', className: 'bg-warning text-dark' };
    };

    // === BƯỚC 3: HÀM FETCH VÀ RENDER GIAO DIỆN ===

    /**
     * Hàm chính để gọi API và hiển thị danh sách đơn hàng.
     * @param {string} status - Trạng thái cần lọc (ví dụ: 'pending', 'delivered', hoặc '' để lấy tất cả).
     */
    async function fetchAndRenderOrders(keyword = '', status = '') {
        // Hiển thị trạng thái đang tải
        ordersContainer.innerHTML = `<div class="text-center p-5"><div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div><p class="mt-2">Đang tải...</p></div>`;
        
        try {
            // Xây dựng URL động với tham số lọc
            const apiUrl = `/api/orders/myorders?keyword=${keyword}&status=${status}`;
            const response = await fetch(apiUrl, {
                headers: { 'Authorization': `Bearer ${token}` }
            });

             if (!response.ok) throw new Error('Không thể tải lịch sử đơn hàng.');
            
            const orders = await response.json();
            renderOrdersTable(orders);

        } catch (error) {
            ordersContainer.innerHTML = `<div class="alert alert-danger">${error.message}</div>`;
        }
    }


    /**
     * Hàm chỉ chịu trách nhiệm render bảng HTML từ dữ liệu đơn hàng.
     * @param {Array} orders - Mảng các đối tượng đơn hàng.
     */
    function renderOrdersTable(orders) {
        if (!orders || orders.length === 0) {
            ordersContainer.innerHTML = '<p class="text-center p-5">Không tìm thấy đơn hàng nào phù hợp.</p>';
            return;
        }

        // Tạo bảng HTML
        const tableHTML = `
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead>
                        <tr>
                            <th scope="col">Mã ĐH</th>
                            <th scope="col">Ngày Đặt</th>
                            <th scope="col">Tổng Tiền</th>
                            <th scope="col">Trạng thái ĐH</th>
                            <th scope="col">Thanh toán</th>
                            <th scope="col"></th>
                        </tr>
                    </thead>
                    <tbody>
                        ${orders.map(order => {
                            const orderDate = new Date(order.createdAt).toLocaleDateString('vi-VN');
                            const totalAmount = parseFloat(order.tong_thanh_toan).toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
                            const statusInfo = getStatusInfo(order.trang_thai_don_hang);
                            const paymentStatusInfo = getPaymentStatusInfo(order.trang_thai_thanh_toan);
                            const statusBadgeHTML = `<span class="badge rounded-pill ${statusInfo.className}">${statusInfo.text}</span>`;
                            const paymentBadgeHTML = `<span class="badge rounded-pill ${paymentStatusInfo.className}">${paymentStatusInfo.text}</span>`;

                            return `
                                <tr>
                                    <th scope="row">BZ111${order.id}</th>
                                    <td>${orderDate}</td>
                                    <td>${totalAmount}</td>
                                    <td>${statusBadgeHTML}</td> 
                                    <td>${paymentBadgeHTML}</td>
                                    <td class="text-end">
                                        <a href="/orders/BZ111${order.id}" class="btn btn-sm btn-info text-white">Xem chi tiết</a>
                                    </td>
                                </tr>
                            `;
                        }).join('')}
                    </tbody>
                </table>
            </div>
        `;
        ordersContainer.innerHTML = tableHTML;
    }

    // === BƯỚC 4: GẮN EVENT LISTENER ===

    // Lắng nghe sự kiện submit của form lọc
     filterForm.addEventListener('submit', (e) => {
        e.preventDefault();
        const selectedStatus = statusSelect.value;
        const inputKeyword = keywordInput.value.trim(); // Lấy giá trị từ ô tìm kiếm
        fetchAndRenderOrders(inputKeyword, selectedStatus); // Gửi cả 2 giá trị đi
    });
    // === BƯỚC 5: KHỞI CHẠY LẦN ĐẦU TIÊN ===
    fetchAndRenderOrders(); // Gọi lần đầu để tải tất cả đơn hàng
});