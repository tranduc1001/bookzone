/**
 * File: /public/js/admin-dashboard.js
 * Chức năng: Lấy dữ liệu thống kê từ API và hiển thị lên trang Dashboard,
 * bao gồm các thẻ tổng quan, biểu đồ lợi nhuận, và các bảng xếp hạng.
 */

document.addEventListener('DOMContentLoaded', () => {

    // ==========================================================
    // === BƯỚC 1: KIỂM TRA TOKEN & LẤY CÁC ELEMENT TỪ DOM ===
    // ==========================================================
    const token = localStorage.getItem('token');
    if (!token) {
        alert('Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.');
        window.location.href = '/login';
        return;
    }

    // Bộ lọc
    const startDateInput = document.getElementById('start-date');
    const endDateInput = document.getElementById('end-date');
    const filterBtn = document.getElementById('filter-btn');
    
    // Thẻ thống kê tổng quan
    const totalRevenueCard = document.getElementById('total-revenue-card');
    const totalCostCard = document.getElementById('total-cost-card');
    const profitCard = document.getElementById('profit-card');

    // Biểu đồ
    const chartTitleEl = document.getElementById('chart-title');
    let revenueChartInstance = null; // Biến để lưu trữ instance của biểu đồ, giúp hủy và vẽ lại

    // Bảng xếp hạng
    const topProductsBody = document.getElementById('top-products-body');
    const topCustomersBody = document.getElementById('top-customers-body');

    // ==========================================================
    // === BƯỚC 2: CÁC HÀM TIỆN ÍCH (HELPER FUNCTIONS) ===
    // ==========================================================
    
    // Hàm định dạng số sang tiền tệ Việt Nam
    const formatCurrency = (amount) => {
        if (typeof amount !== 'number' && typeof amount !== 'string') return '0 ₫';
        const numberAmount = parseFloat(amount);
        if (isNaN(numberAmount)) return '0 ₫';
        return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(numberAmount);
    };

    // Hàm hiển thị trạng thái đang tải
    const showLoadingState = () => {
        if (filterBtn) {
            filterBtn.disabled = true;
            filterBtn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Đang tải...';
        }
        // Hiển thị 'Đang tải...' cho các thẻ thống kê và bảng
        if (totalRevenueCard) totalRevenueCard.textContent = 'Đang tải...';
        if (totalCostCard) totalCostCard.textContent = 'Đang tải...';
        if (profitCard) profitCard.textContent = 'Đang tải...';
        const loadingRow = '<tr><td colspan="3" class="text-center">Đang tải...</td></tr>';
        if (topProductsBody) topProductsBody.innerHTML = loadingRow;
        if (topCustomersBody) topCustomersBody.innerHTML = loadingRow;
    };

    // Hàm ẩn trạng thái đang tải
    const hideLoadingState = () => {
        if (filterBtn) {
            filterBtn.disabled = false;
            filterBtn.innerHTML = '<i class="fas fa-filter mr-2"></i>Lọc';
        }
    };


    // ==========================================================
    // === BƯỚC 3: CÁC HÀM RENDER GIAO DIỆN ===
    // ==========================================================

    /**
     * Cập nhật nội dung cho 3 thẻ thống kê tổng quan.
     * @param {object} stats - Đối tượng chứa totalRevenue, totalCost, profit.
     */
    const renderStatCards = (stats) => {
        if (totalRevenueCard) totalRevenueCard.textContent = formatCurrency(stats.totalRevenue);
        if (totalCostCard) totalCostCard.textContent = formatCurrency(stats.totalCost);
        if (profitCard) {
            profitCard.textContent = formatCurrency(stats.profit);
            // Thay đổi màu chữ của Lợi nhuận tùy theo giá trị
            profitCard.classList.remove('text-danger', 'text-success');
            profitCard.classList.add(stats.profit >= 0 ? 'text-success' : 'text-danger');
        }
    };

    /**
     * Vẽ biểu đồ cột cho Doanh thu, Chi phí, và Lợi nhuận.
     * @param {Array} revenueData - Dữ liệu doanh thu theo tháng từ API.
     * @param {Array} costData - Dữ liệu chi phí theo tháng từ API.
     * @param {string} startDateStr - Ngày bắt đầu để tạo nhãn.
     * @param {string} endDateStr - Ngày kết thúc để tạo nhãn.
     */
    const renderProfitChart = (revenueData, costData, startDateStr, endDateStr) => {
        if (revenueChartInstance) {
            revenueChartInstance.destroy(); // Hủy biểu đồ cũ trước khi vẽ mới
        }
        const canvas = document.getElementById('revenue-chart');
        const ctx = canvas?.getContext('2d');
        if (!ctx) return;

        if (chartTitleEl) chartTitleEl.textContent = "Biểu đồ Kinh doanh (Doanh thu - Chi phí - Lợi nhuận)";

        // Gộp dữ liệu doanh thu và chi phí vào một Map để dễ dàng tra cứu
        const dataMap = new Map();
        
        revenueData.forEach(item => {
            const key = `${item.year}-${item.month}`;
            const entry = dataMap.get(key) || { revenue: 0, cost: 0 };
            entry.revenue = parseFloat(item.total);
            dataMap.set(key, entry);
        });
        costData.forEach(item => {
            const key = `${item.year}-${item.month}`;
            const entry = dataMap.get(key) || { revenue: 0, cost: 0 };
            entry.cost = parseFloat(item.totalCost);
            dataMap.set(key, entry);
        });

        const labels = [];
        const revenueValues = [];
        const costValues = [];
        const profitValues = [];

        // Tạo nhãn (labels) và dữ liệu (data) cho từng tháng trong khoảng thời gian đã chọn
        let currentDate = new Date(startDateStr);
        const endDate = new Date(endDateStr);
        // Lặp qua từng tháng để đảm bảo tất cả các tháng đều xuất hiện trên biểu đồ
        while (currentDate <= endDate) {
            const year = currentDate.getFullYear();
            const month = currentDate.getMonth() + 1;
            const key = `${year}-${month}`;
            labels.push(`T${month}/${year}`);
            
            const monthData = dataMap.get(key) || { revenue: 0, cost: 0 };
            const profit = monthData.revenue - monthData.cost;

            revenueValues.push(monthData.revenue);
            costValues.push(monthData.cost);
            profitValues.push(profit);
            
            // Di chuyển đến tháng tiếp theo
            currentDate.setMonth(currentDate.getMonth() + 1);
        }

        // Vẽ biểu đồ bằng Chart.js
        revenueChartInstance = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [
                    { label: "Doanh thu", data: revenueValues, backgroundColor: '#4e73df' },
                    { label: "Chi phí", data: costValues, backgroundColor: '#e74a3b' },
                    { label: "Lợi nhuận", data: profitValues, backgroundColor: '#1cc88a' }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: { callback: (value) => formatCurrency(value) }
                    }
                },
                plugins: {
                    legend: { display: true, position: 'top' },
                    tooltip: {
                        callbacks: {
                            label: (context) => `${context.dataset.label}: ${formatCurrency(context.parsed.y)}`
                        }
                    }
                }
            }
        });
    };

    /**
     * Render bảng Top 5 sản phẩm bán chạy.
     * @param {Array} products - Dữ liệu từ API.
     */
    const renderTopProducts = (products) => {
        if (!topProductsBody) return;
        topProductsBody.innerHTML = '';
        if (!products || products.length === 0) {
            topProductsBody.innerHTML = '<tr><td colspan="3" class="text-center">Không có dữ liệu.</td></tr>';
            return;
        }
        products.forEach((item, index) => {
            const row = `
                <tr>
                    <td><strong>${index + 1}</strong></td>
                    <td>${item.product.ten_sach}</td>
                    <td class="text-right font-weight-bold">${item.total_sold}</td>
                </tr>
            `;
            topProductsBody.insertAdjacentHTML('beforeend', row);
        });
    };

    /**
     * Render bảng Top 5 khách hàng tiềm năng.
     * @param {Array} customers - Dữ liệu từ API.
     */
    const renderTopCustomers = (customers) => {
        if (!topCustomersBody) return;
        topCustomersBody.innerHTML = '';
        if (!customers || customers.length === 0) {
            topCustomersBody.innerHTML = '<tr><td colspan="3" class="text-center">Không có dữ liệu.</td></tr>';
            return;
        }
        customers.forEach((item, index) => {
            const row = `
                <tr>
                    <td><strong>${index + 1}</strong></td>
                    <td>${item.user.ho_ten || 'Khách vãng lai'}</td>
                    <td class="text-right font-weight-bold">${item.order_count}</td>
                </tr>
            `;
            topCustomersBody.insertAdjacentHTML('beforeend', row);
        });
    };


    // ==========================================================
    // === BƯỚC 4: HÀM CHÍNH GỌI API ===
    // ==========================================================

    const fetchAndRenderDashboard = async (startDate, endDate) => {
        showLoadingState();
        
        const params = new URLSearchParams({ startDate, endDate });
        const apiUrl = `/api/dashboard/stats?${params.toString()}`;

        try {
            const response = await fetch(apiUrl, {
                headers: { 'Authorization': `Bearer ${token}` }
            });
            const data = await response.json();
            if (!response.ok) throw new Error(data.message || 'Lỗi không xác định.');

            // Gọi các hàm render với dữ liệu nhận được
            renderStatCards(data.totalStats);
            renderProfitChart(data.revenueByMonth, data.costByMonth, startDate, endDate);
            renderTopProducts(data.topSellingProducts);
            renderTopCustomers(data.topCustomers);

        } catch (error) {
            console.error('Lỗi khi tải dữ liệu dashboard:', error);
            alert(`Đã có lỗi xảy ra: ${error.message}`);
        } finally {
            hideLoadingState();
        }
    };


    // ==========================================================
    // === BƯỚC 5: GẮN EVENT LISTENERS & KHỞI TẠO ===
    // ==========================================================

    if (filterBtn) {
        filterBtn.addEventListener('click', () => {
            const startDate = startDateInput.value;
            const endDate = endDateInput.value;
            if (!startDate || !endDate) {
                alert('Vui lòng chọn cả ngày bắt đầu và ngày kết thúc.');
                return;
            }
            if (new Date(startDate) > new Date(endDate)) {
                alert('Ngày bắt đầu không thể lớn hơn ngày kết thúc.');
                return;
            }
            fetchAndRenderDashboard(startDate, endDate);
        });
    }

    // Thiết lập giá trị mặc định cho bộ lọc (30 ngày gần nhất)
    const today = new Date();
    const thirtyDaysAgo = new Date(new Date().setDate(today.getDate() - 30));
    if (endDateInput) {
        endDateInput.value = today.toISOString().split('T')[0];
    }
    if (startDateInput) {
        startDateInput.value = thirtyDaysAgo.toISOString().split('T')[0];
    }
    
    // Tải dữ liệu lần đầu tiên ngay khi trang được mở
    if(startDateInput.value && endDateInput.value) {
        fetchAndRenderDashboard(startDateInput.value, endDateInput.value);
    }
});