// File: /public/js/admin-product-form.js

document.addEventListener('DOMContentLoaded', function() {
    // ====================================================================
    // KHAI BÁO BIẾN & LẤY CÁC ELEMENT TỪ DOM
    // ====================================================================
    const token = localStorage.getItem('token');
    if (!token) {
        alert('Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.');
        window.location.href = '/admin/login'; // Chuyển về trang đăng nhập admin
        return;
    }

    const productForm = document.getElementById('product-form');
    const categorySelect = document.getElementById('danh_muc_id'); 
    const priceInput = document.getElementById('gia_bia');

    if (!productForm) {
        console.error('Lỗi nghiêm trọng: Không tìm thấy form#product-form.');
        return;
    }
    if (document.getElementById('mo_ta_ngan')) {
        // Thay 'YOUR_API_KEY' bằng API Key bạn đã lấy được
        tinymce.init({
            selector: '#mo_ta_ngan', // Trỏ đến textarea có id="mo_ta_ngan"
            plugins: 'anchor autolink charmap codesample emoticons image link lists media searchreplace table visualblocks wordcount',
            toolbar: 'undo redo | blocks fontfamily fontsize | bold italic underline strikethrough | link image media table | align lineheight | numlist bullist indent outdent | emoticons charmap | removeformat',
            height: 500,
            image_title: true,
            automatic_uploads: true,
            file_picker_types: 'image',
            file_picker_callback: (cb, value, meta) => {
                const input = document.createElement('input');
                input.setAttribute('type', 'file');
                input.setAttribute('accept', 'image/*');

                input.addEventListener('change', (e) => {
                    const file = e.target.files[0];
                    const reader = new FileReader();
                    reader.addEventListener('load', () => {
                        const id = 'blobid' + (new Date()).getTime();
                        const blobCache =  tinymce.activeEditor.editorUpload.blobCache;
                        const base64 = reader.result.split(',')[1];
                        const blobInfo = blobCache.create(id, file, base64);
                        blobCache.add(blobInfo);
                        cb(blobInfo.blobUri(), { title: file.name });
                    });
                    reader.readAsDataURL(file);
                });
                input.click();
            }
        });
    }
   
    // TÍCH HỢP CLEAVE.JS ĐỂ ĐỊNH DẠNG Ô NHẬP GIÁ
   
    let cleaveInstance = null;
    if (priceInput) {
        cleaveInstance = new Cleave(priceInput, {
            numeral: true,
            numeralThousandsGroupStyle: 'thousand',
            numeralDecimalScale: 0
        });
    }

  
    // LOGIC XỬ LÝ DANH MỤC
    
    async function fetchAllCategories() {
        try {
            const response = await fetch('/api/categories', {
                headers: { 'Authorization': `Bearer ${token}` }
            });
            if (!response.ok) {
                throw new Error('Không thể tải danh sách danh mục từ server.');
            }
            return await response.json();
        } catch (error) {
            console.error(error.message);
            return [];
        }
    }

    function populateCategorySelect(categories, selectedCategoryId = null) {
        if (!categorySelect) return;
        categorySelect.innerHTML = '<option value="">-- Vui lòng chọn danh mục --</option>';
        categories.forEach(function(category) {
            const option = document.createElement('option');
            option.value = category.id;
            option.textContent = category.ten_danh_muc;
            if (category.id == selectedCategoryId) {
                option.selected = true;
            }
            categorySelect.appendChild(option);
        });
    }

    
    // LOGIC XỬ LÝ FORM (THÊM MỚI / CẬP NHẬT)
    
    const pathParts = window.location.pathname.split('/');
    const isEditMode = pathParts.includes('edit');
    const productId = isEditMode ? pathParts[pathParts.length - 1] : null;

    async function loadProductDataForEditing() {
        if (!productId) return;
        try {
            const response = await fetch(`/api/products/${productId}`);
            if (!response.ok) throw new Error('Không thể tải dữ liệu sản phẩm để sửa.');
            
            const product = await response.json();

            // Điền dữ liệu đã có vào các ô input của form
            for (const key in product) {
                if (key === 'img') {
                    continue; 
                }
                if (productForm.elements[key]) {
                    productForm.elements[key].value = product[key];
                }
            }

            // Cập nhật giá trị cho ô giá đã được định dạng bằng Cleave.js
            if (cleaveInstance && product.gia_bia) {
                cleaveInstance.setRawValue(product.gia_bia);
            }
            
            // Tải lại và chọn đúng danh mục cho sản phẩm
            const allCategories = await fetchAllCategories();
            populateCategorySelect(allCategories, product.danh_muc_id);

        } catch (error) {
            Swal.fire('Lỗi!', error.message, 'error');
        }
    }

    productForm.addEventListener('submit', async function(event) {
        event.preventDefault();
        
        const formData = new FormData(productForm);

        // "Làm sạch" giá trị của ô giá trước khi gửi đi
        if (priceInput && cleaveInstance) {
            const rawValue = cleaveInstance.getRawValue();
            formData.set('gia_bia', rawValue);
        }
        
        const method = isEditMode ? 'PUT' : 'POST';
        const apiUrl = isEditMode ? `/api/products/${productId}` : '/api/products';

        try {
            const response = await fetch(apiUrl, {
                method: method,
                headers: {
                    // Không cần 'Content-Type', trình duyệt sẽ tự thêm khi gửi FormData
                    'Authorization': `Bearer ${token}`
                },
                body: formData 
            });

            const result = await response.json();

            if (!response.ok) {
                // Nối các thông báo lỗi từ server lại với nhau nếu có
                if (result.error && Array.isArray(result.error)) {
                    const errorMessages = result.error.map(e => e.message).join('\n');
                    throw new Error(errorMessages);
                }
                throw new Error(result.message || 'Có lỗi không xác định xảy ra.');
            }

            await Swal.fire(
                'Thành công!', 
                isEditMode ? 'Cập nhật sản phẩm thành công!' : 'Thêm sản phẩm thành công!', 
                'success'
            );
            window.location.href = '/admin/products';

        } catch (error) {
            Swal.fire('Thao tác thất bại!', error.message, 'error');
        }
    });

    
    // KHỞI CHẠY CÁC HÀM CẦN THIẾT KHI TẢI TRANG
   
    async function initializePage() {
        if (isEditMode) {
            await loadProductDataForEditing();
        } else {
            // Nếu là trang thêm mới, chỉ cần tải danh sách danh mục
            const allCategories = await fetchAllCategories();
            populateCategorySelect(allCategories);
        }
    }

    initializePage();
});