--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-07-10 22:57:54

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 5 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: cuduc
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO cuduc;

--
-- TOC entry 919 (class 1247 OID 19307)
-- Name: enum_orders_trang_thai_don_hang; Type: TYPE; Schema: public; Owner: cuduc
--

CREATE TYPE public.enum_orders_trang_thai_don_hang AS ENUM (
    'pending',
    'pending_payment',
    'confirmed',
    'shipping',
    'delivered',
    'cancelled'
);


ALTER TYPE public.enum_orders_trang_thai_don_hang OWNER TO cuduc;

--
-- TOC entry 925 (class 1247 OID 19330)
-- Name: enum_promotions_loai_giam_gia; Type: TYPE; Schema: public; Owner: cuduc
--

CREATE TYPE public.enum_promotions_loai_giam_gia AS ENUM (
    'percentage',
    'fixed_amount'
);


ALTER TYPE public.enum_promotions_loai_giam_gia OWNER TO cuduc;

--
-- TOC entry 928 (class 1247 OID 19336)
-- Name: enum_promotions_pham_vi_ap_dung; Type: TYPE; Schema: public; Owner: cuduc
--

CREATE TYPE public.enum_promotions_pham_vi_ap_dung AS ENUM (
    'all',
    'category',
    'product'
);


ALTER TYPE public.enum_promotions_pham_vi_ap_dung OWNER TO cuduc;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 238 (class 1259 OID 19250)
-- Name: cart_items; Type: TABLE; Schema: public; Owner: cuduc
--

CREATE TABLE public.cart_items (
    id bigint NOT NULL,
    cart_id bigint NOT NULL,
    product_id bigint NOT NULL,
    so_luong integer DEFAULT 1 NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.cart_items OWNER TO cuduc;

--
-- TOC entry 237 (class 1259 OID 19249)
-- Name: cart_items_id_seq; Type: SEQUENCE; Schema: public; Owner: cuduc
--

CREATE SEQUENCE public.cart_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cart_items_id_seq OWNER TO cuduc;

--
-- TOC entry 5172 (class 0 OID 0)
-- Dependencies: 237
-- Name: cart_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cuduc
--

ALTER SEQUENCE public.cart_items_id_seq OWNED BY public.cart_items.id;


--
-- TOC entry 232 (class 1259 OID 19206)
-- Name: carts; Type: TABLE; Schema: public; Owner: cuduc
--

CREATE TABLE public.carts (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.carts OWNER TO cuduc;

--
-- TOC entry 231 (class 1259 OID 19205)
-- Name: carts_id_seq; Type: SEQUENCE; Schema: public; Owner: cuduc
--

CREATE SEQUENCE public.carts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.carts_id_seq OWNER TO cuduc;

--
-- TOC entry 5173 (class 0 OID 0)
-- Dependencies: 231
-- Name: carts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cuduc
--

ALTER SEQUENCE public.carts_id_seq OWNED BY public.carts.id;


--
-- TOC entry 234 (class 1259 OID 19220)
-- Name: categories; Type: TABLE; Schema: public; Owner: cuduc
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    ten_danh_muc character varying(255) NOT NULL,
    mo_ta text,
    danh_muc_cha_id bigint,
    img character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.categories OWNER TO cuduc;

--
-- TOC entry 233 (class 1259 OID 19219)
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: cuduc
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO cuduc;

--
-- TOC entry 5174 (class 0 OID 0)
-- Dependencies: 233
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cuduc
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- TOC entry 240 (class 1259 OID 19268)
-- Name: combo_items; Type: TABLE; Schema: public; Owner: cuduc
--

CREATE TABLE public.combo_items (
    id bigint NOT NULL,
    combo_id bigint NOT NULL,
    product_id bigint NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.combo_items OWNER TO cuduc;

--
-- TOC entry 239 (class 1259 OID 19267)
-- Name: combo_items_id_seq; Type: SEQUENCE; Schema: public; Owner: cuduc
--

CREATE SEQUENCE public.combo_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.combo_items_id_seq OWNER TO cuduc;

--
-- TOC entry 5175 (class 0 OID 0)
-- Dependencies: 239
-- Name: combo_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cuduc
--

ALTER SEQUENCE public.combo_items_id_seq OWNED BY public.combo_items.id;


--
-- TOC entry 242 (class 1259 OID 19275)
-- Name: combos; Type: TABLE; Schema: public; Owner: cuduc
--

CREATE TABLE public.combos (
    id bigint NOT NULL,
    ten_combo character varying(255) NOT NULL,
    mo_ta text,
    img character varying(255),
    gia_combo numeric(15,2) NOT NULL,
    trang_thai boolean DEFAULT true,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.combos OWNER TO cuduc;

--
-- TOC entry 5176 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN combos.img; Type: COMMENT; Schema: public; Owner: cuduc
--

COMMENT ON COLUMN public.combos.img IS 'Ảnh đại diện cho gói combo';


--
-- TOC entry 5177 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN combos.gia_combo; Type: COMMENT; Schema: public; Owner: cuduc
--

COMMENT ON COLUMN public.combos.gia_combo IS 'Giá bán của cả gói sản phẩm này';


--
-- TOC entry 241 (class 1259 OID 19274)
-- Name: combos_id_seq; Type: SEQUENCE; Schema: public; Owner: cuduc
--

CREATE SEQUENCE public.combos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.combos_id_seq OWNER TO cuduc;

--
-- TOC entry 5178 (class 0 OID 0)
-- Dependencies: 241
-- Name: combos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cuduc
--

ALTER SEQUENCE public.combos_id_seq OWNED BY public.combos.id;


--
-- TOC entry 244 (class 1259 OID 19285)
-- Name: ebook_download_links; Type: TABLE; Schema: public; Owner: cuduc
--

CREATE TABLE public.ebook_download_links (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    product_id bigint NOT NULL,
    order_id bigint NOT NULL,
    download_token character varying(255) NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    is_used boolean DEFAULT false,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.ebook_download_links OWNER TO cuduc;

--
-- TOC entry 243 (class 1259 OID 19284)
-- Name: ebook_download_links_id_seq; Type: SEQUENCE; Schema: public; Owner: cuduc
--

CREATE SEQUENCE public.ebook_download_links_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ebook_download_links_id_seq OWNER TO cuduc;

--
-- TOC entry 5179 (class 0 OID 0)
-- Dependencies: 243
-- Name: ebook_download_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cuduc
--

ALTER SEQUENCE public.ebook_download_links_id_seq OWNED BY public.ebook_download_links.id;


--
-- TOC entry 246 (class 1259 OID 19295)
-- Name: order_items; Type: TABLE; Schema: public; Owner: cuduc
--

CREATE TABLE public.order_items (
    id bigint NOT NULL,
    order_id bigint NOT NULL,
    product_id bigint NOT NULL,
    so_luong_dat integer NOT NULL,
    don_gia numeric(15,2) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.order_items OWNER TO cuduc;

--
-- TOC entry 245 (class 1259 OID 19294)
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: cuduc
--

CREATE SEQUENCE public.order_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_id_seq OWNER TO cuduc;

--
-- TOC entry 5180 (class 0 OID 0)
-- Dependencies: 245
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cuduc
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- TOC entry 248 (class 1259 OID 19318)
-- Name: orders; Type: TABLE; Schema: public; Owner: cuduc
--

CREATE TABLE public.orders (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    ten_nguoi_nhan character varying(255) NOT NULL,
    email_nguoi_nhan character varying(255) NOT NULL,
    sdt_nguoi_nhan character varying(20) NOT NULL,
    dia_chi_giao_hang character varying(255) NOT NULL,
    ghi_chu_khach_hang text,
    tong_tien_hang numeric(15,2) NOT NULL,
    phi_van_chuyen numeric(10,2) DEFAULT 0,
    tong_thanh_toan numeric(15,2) NOT NULL,
    phuong_thuc_thanh_toan character varying(50) NOT NULL,
    trang_thai_don_hang public.enum_orders_trang_thai_don_hang DEFAULT 'pending'::public.enum_orders_trang_thai_don_hang NOT NULL,
    trang_thai_thanh_toan boolean DEFAULT false,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    ma_khuyen_mai_da_ap_dung character varying(255),
    so_tien_giam_gia numeric(15,2) DEFAULT 0 NOT NULL
);


ALTER TABLE public.orders OWNER TO cuduc;

--
-- TOC entry 247 (class 1259 OID 19317)
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: cuduc
--

CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO cuduc;

--
-- TOC entry 5181 (class 0 OID 0)
-- Dependencies: 247
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cuduc
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- TOC entry 260 (class 1259 OID 20812)
-- Name: posts; Type: TABLE; Schema: public; Owner: cuduc
--

CREATE TABLE public.posts (
    id integer NOT NULL,
    tieu_de character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    tom_tat text,
    noi_dung text NOT NULL,
    anh_dai_dien character varying(255),
    trang_thai boolean DEFAULT true,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.posts OWNER TO cuduc;

--
-- TOC entry 5182 (class 0 OID 0)
-- Dependencies: 260
-- Name: COLUMN posts.anh_dai_dien; Type: COMMENT; Schema: public; Owner: cuduc
--

COMMENT ON COLUMN public.posts.anh_dai_dien IS 'URL ảnh đại diện cho bài viết';


--
-- TOC entry 259 (class 1259 OID 20811)
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: cuduc
--

CREATE SEQUENCE public.posts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.posts_id_seq OWNER TO cuduc;

--
-- TOC entry 5183 (class 0 OID 0)
-- Dependencies: 259
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cuduc
--

ALTER SEQUENCE public.posts_id_seq OWNED BY public.posts.id;


--
-- TOC entry 236 (class 1259 OID 19234)
-- Name: products; Type: TABLE; Schema: public; Owner: cuduc
--

CREATE TABLE public.products (
    id integer NOT NULL,
    ten_sach character varying(255) NOT NULL,
    mo_ta_ngan text,
    gia_bia numeric(12,2) NOT NULL,
    so_luong_ton_kho integer DEFAULT 0 NOT NULL,
    tac_gia character varying(255),
    nha_xuat_ban character varying(255),
    nam_xuat_ban integer,
    img character varying(255),
    product_type character varying(255) DEFAULT 'print_book'::character varying NOT NULL,
    ebook_url character varying(255),
    danh_muc_id bigint NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    so_trang integer
);


ALTER TABLE public.products OWNER TO cuduc;

--
-- TOC entry 5184 (class 0 OID 0)
-- Dependencies: 236
-- Name: COLUMN products.img; Type: COMMENT; Schema: public; Owner: cuduc
--

COMMENT ON COLUMN public.products.img IS 'URL đến hình ảnh đại diện của sản phẩm';


--
-- TOC entry 5185 (class 0 OID 0)
-- Dependencies: 236
-- Name: COLUMN products.product_type; Type: COMMENT; Schema: public; Owner: cuduc
--

COMMENT ON COLUMN public.products.product_type IS 'Loại sản phẩm: sách in (print_book) hoặc ebook';


--
-- TOC entry 5186 (class 0 OID 0)
-- Dependencies: 236
-- Name: COLUMN products.ebook_url; Type: COMMENT; Schema: public; Owner: cuduc
--

COMMENT ON COLUMN public.products.ebook_url IS 'Đường dẫn gốc đến file ebook';


--
-- TOC entry 235 (class 1259 OID 19233)
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: cuduc
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO cuduc;

--
-- TOC entry 5187 (class 0 OID 0)
-- Dependencies: 235
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cuduc
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- TOC entry 250 (class 1259 OID 19344)
-- Name: promotions; Type: TABLE; Schema: public; Owner: cuduc
--

CREATE TABLE public.promotions (
    id bigint NOT NULL,
    ma_khuyen_mai character varying(255) NOT NULL,
    mo_ta text NOT NULL,
    loai_giam_gia public.enum_promotions_loai_giam_gia NOT NULL,
    gia_tri_giam numeric(15,2) NOT NULL,
    dieu_kien_don_hang_toi_thieu numeric(15,2) DEFAULT 0 NOT NULL,
    ngay_bat_dau timestamp with time zone NOT NULL,
    ngay_ket_thuc timestamp with time zone NOT NULL,
    so_luong_gioi_han integer,
    so_luong_da_su_dung integer DEFAULT 0 NOT NULL,
    pham_vi_ap_dung public.enum_promotions_pham_vi_ap_dung DEFAULT 'all'::public.enum_promotions_pham_vi_ap_dung NOT NULL,
    trang_thai boolean DEFAULT true NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    danh_sach_id_ap_dung text,
    giam_toi_da numeric(15,2)
);


ALTER TABLE public.promotions OWNER TO cuduc;

--
-- TOC entry 5188 (class 0 OID 0)
-- Dependencies: 250
-- Name: COLUMN promotions.ma_khuyen_mai; Type: COMMENT; Schema: public; Owner: cuduc
--

COMMENT ON COLUMN public.promotions.ma_khuyen_mai IS 'Mã code người dùng sẽ nhập, ví dụ: "TET2024", "FREESHIP"';


--
-- TOC entry 5189 (class 0 OID 0)
-- Dependencies: 250
-- Name: COLUMN promotions.gia_tri_giam; Type: COMMENT; Schema: public; Owner: cuduc
--

COMMENT ON COLUMN public.promotions.gia_tri_giam IS 'Nếu loai_giam_gia là "percentage" thì đây là %, nếu là "fixed_amount" thì đây là số tiền';


--
-- TOC entry 5190 (class 0 OID 0)
-- Dependencies: 250
-- Name: COLUMN promotions.dieu_kien_don_hang_toi_thieu; Type: COMMENT; Schema: public; Owner: cuduc
--

COMMENT ON COLUMN public.promotions.dieu_kien_don_hang_toi_thieu IS 'Giá trị đơn hàng tối thiểu để áp dụng mã';


--
-- TOC entry 249 (class 1259 OID 19343)
-- Name: promotions_id_seq; Type: SEQUENCE; Schema: public; Owner: cuduc
--

CREATE SEQUENCE public.promotions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.promotions_id_seq OWNER TO cuduc;

--
-- TOC entry 5191 (class 0 OID 0)
-- Dependencies: 249
-- Name: promotions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cuduc
--

ALTER SEQUENCE public.promotions_id_seq OWNED BY public.promotions.id;


--
-- TOC entry 258 (class 1259 OID 19434)
-- Name: receipt_items; Type: TABLE; Schema: public; Owner: cuduc
--

CREATE TABLE public.receipt_items (
    id bigint NOT NULL,
    receipt_id bigint NOT NULL,
    product_id bigint NOT NULL,
    so_luong_nhap integer DEFAULT 1 NOT NULL,
    gia_nhap numeric(12,2) NOT NULL,
    chiet_khau numeric(12,2) DEFAULT 0 NOT NULL,
    thanh_tien numeric(15,2) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.receipt_items OWNER TO cuduc;

--
-- TOC entry 257 (class 1259 OID 19433)
-- Name: receipt_items_id_seq; Type: SEQUENCE; Schema: public; Owner: cuduc
--

CREATE SEQUENCE public.receipt_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.receipt_items_id_seq OWNER TO cuduc;

--
-- TOC entry 5192 (class 0 OID 0)
-- Dependencies: 257
-- Name: receipt_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cuduc
--

ALTER SEQUENCE public.receipt_items_id_seq OWNED BY public.receipt_items.id;


--
-- TOC entry 256 (class 1259 OID 19415)
-- Name: receipts; Type: TABLE; Schema: public; Owner: cuduc
--

CREATE TABLE public.receipts (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    ngay_nhap timestamp with time zone,
    tong_tien_phieu_nhap numeric(15,2) NOT NULL,
    ghi_chu text,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    ten_nha_cung_cap character varying(255) NOT NULL
);


ALTER TABLE public.receipts OWNER TO cuduc;

--
-- TOC entry 255 (class 1259 OID 19414)
-- Name: receipts_id_seq; Type: SEQUENCE; Schema: public; Owner: cuduc
--

CREATE SEQUENCE public.receipts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.receipts_id_seq OWNER TO cuduc;

--
-- TOC entry 5193 (class 0 OID 0)
-- Dependencies: 255
-- Name: receipts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cuduc
--

ALTER SEQUENCE public.receipts_id_seq OWNED BY public.receipts.id;


--
-- TOC entry 252 (class 1259 OID 19359)
-- Name: reviews; Type: TABLE; Schema: public; Owner: cuduc
--

CREATE TABLE public.reviews (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    product_id bigint NOT NULL,
    rating integer,
    comment text,
    parent_id bigint,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.reviews OWNER TO cuduc;

--
-- TOC entry 251 (class 1259 OID 19358)
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: cuduc
--

CREATE SEQUENCE public.reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reviews_id_seq OWNER TO cuduc;

--
-- TOC entry 5194 (class 0 OID 0)
-- Dependencies: 251
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cuduc
--

ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;


--
-- TOC entry 228 (class 1259 OID 19177)
-- Name: roles; Type: TABLE; Schema: public; Owner: cuduc
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    ten_quyen character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.roles OWNER TO cuduc;

--
-- TOC entry 227 (class 1259 OID 19176)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: cuduc
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO cuduc;

--
-- TOC entry 5195 (class 0 OID 0)
-- Dependencies: 227
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cuduc
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- TOC entry 254 (class 1259 OID 19383)
-- Name: slideshows; Type: TABLE; Schema: public; Owner: cuduc
--

CREATE TABLE public.slideshows (
    id bigint NOT NULL,
    image_url character varying(255) NOT NULL,
    tieu_de character varying(255),
    phu_de character varying(255),
    link_to character varying(255),
    thu_tu_hien_thi integer DEFAULT 0,
    trang_thai boolean DEFAULT true,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.slideshows OWNER TO cuduc;

--
-- TOC entry 5196 (class 0 OID 0)
-- Dependencies: 254
-- Name: COLUMN slideshows.image_url; Type: COMMENT; Schema: public; Owner: cuduc
--

COMMENT ON COLUMN public.slideshows.image_url IS 'Đường dẫn đến ảnh của slide, ';


--
-- TOC entry 5197 (class 0 OID 0)
-- Dependencies: 254
-- Name: COLUMN slideshows.tieu_de; Type: COMMENT; Schema: public; Owner: cuduc
--

COMMENT ON COLUMN public.slideshows.tieu_de IS 'Tiêu đề chính trên slide, ví dụ: "Sách Mới Ra Mắt"';


--
-- TOC entry 5198 (class 0 OID 0)
-- Dependencies: 254
-- Name: COLUMN slideshows.phu_de; Type: COMMENT; Schema: public; Owner: cuduc
--

COMMENT ON COLUMN public.slideshows.phu_de IS 'Tiêu đề phụ hoặc mô tả ngắn, ví dụ: "Giảm giá đến 50%"';


--
-- TOC entry 5199 (class 0 OID 0)
-- Dependencies: 254
-- Name: COLUMN slideshows.link_to; Type: COMMENT; Schema: public; Owner: cuduc
--

COMMENT ON COLUMN public.slideshows.link_to IS 'Đường dẫn khi click vào slide, ví dụ: /products/123 hoặc /categories/4';


--
-- TOC entry 5200 (class 0 OID 0)
-- Dependencies: 254
-- Name: COLUMN slideshows.thu_tu_hien_thi; Type: COMMENT; Schema: public; Owner: cuduc
--

COMMENT ON COLUMN public.slideshows.thu_tu_hien_thi IS 'Dùng để sắp xếp thứ tự các slide, số nhỏ hơn hiển thị trước';


--
-- TOC entry 253 (class 1259 OID 19382)
-- Name: slideshows_id_seq; Type: SEQUENCE; Schema: public; Owner: cuduc
--

CREATE SEQUENCE public.slideshows_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.slideshows_id_seq OWNER TO cuduc;

--
-- TOC entry 5201 (class 0 OID 0)
-- Dependencies: 253
-- Name: slideshows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cuduc
--

ALTER SEQUENCE public.slideshows_id_seq OWNED BY public.slideshows.id;


--
-- TOC entry 230 (class 1259 OID 19186)
-- Name: users; Type: TABLE; Schema: public; Owner: cuduc
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    ten_dang_nhap character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    mat_khau character varying(255) NOT NULL,
    ho_ten character varying(255),
    phone character varying(20),
    img character varying(255),
    dia_chi character varying(255),
    trang_thai boolean DEFAULT true,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "resetPasswordToken" character varying(255),
    "resetPasswordExpire" timestamp with time zone,
    role_id bigint DEFAULT 2 NOT NULL
);


ALTER TABLE public.users OWNER TO cuduc;

--
-- TOC entry 229 (class 1259 OID 19185)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: cuduc
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO cuduc;

--
-- TOC entry 5202 (class 0 OID 0)
-- Dependencies: 229
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cuduc
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4749 (class 2604 OID 19253)
-- Name: cart_items id; Type: DEFAULT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.cart_items ALTER COLUMN id SET DEFAULT nextval('public.cart_items_id_seq'::regclass);


--
-- TOC entry 4744 (class 2604 OID 19209)
-- Name: carts id; Type: DEFAULT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.carts ALTER COLUMN id SET DEFAULT nextval('public.carts_id_seq'::regclass);


--
-- TOC entry 4745 (class 2604 OID 19223)
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- TOC entry 4751 (class 2604 OID 19271)
-- Name: combo_items id; Type: DEFAULT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.combo_items ALTER COLUMN id SET DEFAULT nextval('public.combo_items_id_seq'::regclass);


--
-- TOC entry 4752 (class 2604 OID 19278)
-- Name: combos id; Type: DEFAULT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.combos ALTER COLUMN id SET DEFAULT nextval('public.combos_id_seq'::regclass);


--
-- TOC entry 4754 (class 2604 OID 19288)
-- Name: ebook_download_links id; Type: DEFAULT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.ebook_download_links ALTER COLUMN id SET DEFAULT nextval('public.ebook_download_links_id_seq'::regclass);


--
-- TOC entry 4756 (class 2604 OID 19298)
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- TOC entry 4757 (class 2604 OID 19321)
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- TOC entry 4775 (class 2604 OID 20815)
-- Name: posts id; Type: DEFAULT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.posts ALTER COLUMN id SET DEFAULT nextval('public.posts_id_seq'::regclass);


--
-- TOC entry 4746 (class 2604 OID 19237)
-- Name: products id; Type: DEFAULT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- TOC entry 4762 (class 2604 OID 19347)
-- Name: promotions id; Type: DEFAULT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.promotions ALTER COLUMN id SET DEFAULT nextval('public.promotions_id_seq'::regclass);


--
-- TOC entry 4772 (class 2604 OID 19437)
-- Name: receipt_items id; Type: DEFAULT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.receipt_items ALTER COLUMN id SET DEFAULT nextval('public.receipt_items_id_seq'::regclass);


--
-- TOC entry 4771 (class 2604 OID 19418)
-- Name: receipts id; Type: DEFAULT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.receipts ALTER COLUMN id SET DEFAULT nextval('public.receipts_id_seq'::regclass);


--
-- TOC entry 4767 (class 2604 OID 19362)
-- Name: reviews id; Type: DEFAULT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);


--
-- TOC entry 4740 (class 2604 OID 19180)
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- TOC entry 4768 (class 2604 OID 19386)
-- Name: slideshows id; Type: DEFAULT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.slideshows ALTER COLUMN id SET DEFAULT nextval('public.slideshows_id_seq'::regclass);


--
-- TOC entry 4741 (class 2604 OID 19189)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 5144 (class 0 OID 19250)
-- Dependencies: 238
-- Data for Name: cart_items; Type: TABLE DATA; Schema: public; Owner: cuduc
--

COPY public.cart_items (id, cart_id, product_id, so_luong, "createdAt", "updatedAt") FROM stdin;
167	1	15	6	2025-07-09 17:00:45.027+07	2025-07-10 22:23:34.657+07
\.


--
-- TOC entry 5138 (class 0 OID 19206)
-- Dependencies: 232
-- Data for Name: carts; Type: TABLE DATA; Schema: public; Owner: cuduc
--

COPY public.carts (id, user_id, "createdAt", "updatedAt") FROM stdin;
1	1	2025-06-19 16:05:10.258+07	2025-06-19 16:05:10.258+07
2	2	2025-06-20 13:28:09.818+07	2025-06-20 13:28:09.818+07
3	5	2025-06-29 13:31:13.24+07	2025-06-29 13:31:13.24+07
4	7	2025-06-29 15:08:18.952+07	2025-06-29 15:08:18.952+07
\.


--
-- TOC entry 5140 (class 0 OID 19220)
-- Dependencies: 234
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: cuduc
--

COPY public.categories (id, ten_danh_muc, mo_ta, danh_muc_cha_id, img, "createdAt", "updatedAt") FROM stdin;
3	Phát triển bản thân	\N	\N	\N	2025-06-19 16:02:51.364+07	2025-06-19 16:02:51.364+07
27	Sách Kinh Doanh - Bán Hàng		\N		2025-06-23 16:54:03.182+07	2025-06-23 16:54:03.182+07
28	Quản Trị - Lãnh Đạo		\N		2025-06-23 16:54:42.106+07	2025-06-23 16:54:42.106+07
31	Văn Học Việt Nam		\N		2025-06-23 16:55:49.063+07	2025-06-23 16:55:49.063+07
32	Sách Tiểu Học Cơ Sở		\N		2025-06-23 16:56:31.877+07	2025-06-23 16:56:31.877+07
33	Sách Trung Học Cơ Sở 		\N		2025-06-23 16:56:58.975+07	2025-06-23 16:56:58.975+07
34	Sách Trung Học Phổ Thông		\N		2025-06-23 16:57:26.367+07	2025-06-23 16:57:26.367+07
36	Kĩ Năng Sống		3		2025-06-26 14:51:21.024+07	2025-06-26 14:51:21.024+07
29	Đầu Tư Tài Chính 		\N		2025-06-23 16:54:56.333+07	2025-07-02 18:06:21.554+07
30	Văn Học Nước Ngoài 		\N		2025-06-23 16:55:23.595+07	2025-07-02 18:06:26.486+07
39	Kĩ Năng Văn Phòng Công Sở		\N		2025-07-02 18:06:37.934+07	2025-07-02 18:06:37.934+07
\.


--
-- TOC entry 5146 (class 0 OID 19268)
-- Dependencies: 240
-- Data for Name: combo_items; Type: TABLE DATA; Schema: public; Owner: cuduc
--

COPY public.combo_items (id, combo_id, product_id, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 5148 (class 0 OID 19275)
-- Dependencies: 242
-- Data for Name: combos; Type: TABLE DATA; Schema: public; Owner: cuduc
--

COPY public.combos (id, ten_combo, mo_ta, img, gia_combo, trang_thai, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 5150 (class 0 OID 19285)
-- Dependencies: 244
-- Data for Name: ebook_download_links; Type: TABLE DATA; Schema: public; Owner: cuduc
--

COPY public.ebook_download_links (id, user_id, product_id, order_id, download_token, expires_at, is_used, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 5152 (class 0 OID 19295)
-- Dependencies: 246
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: cuduc
--

COPY public.order_items (id, order_id, product_id, so_luong_dat, don_gia, "createdAt", "updatedAt") FROM stdin;
10	9	15	1	10000.00	2025-06-23 19:42:18.189+07	2025-06-23 19:42:18.189+07
11	10	16	1	100000.00	2025-06-23 19:44:01.81+07	2025-06-23 19:44:01.81+07
14	12	14	1	10000.00	2025-06-29 13:46:39.002+07	2025-06-29 13:46:39.002+07
15	12	15	1	10000.00	2025-06-29 13:46:39.002+07	2025-06-29 13:46:39.002+07
16	12	13	1	81600.00	2025-06-29 13:46:39.002+07	2025-06-29 13:46:39.002+07
17	13	13	1	81600.00	2025-06-29 15:09:16.384+07	2025-06-29 15:09:16.384+07
18	13	11	1	57600.00	2025-06-29 15:09:16.384+07	2025-06-29 15:09:16.384+07
19	13	10	1	172500.00	2025-06-29 15:09:16.384+07	2025-06-29 15:09:16.384+07
20	14	13	1	81600.00	2025-06-29 15:27:10.751+07	2025-06-29 15:27:10.751+07
21	14	16	1	100000.00	2025-06-29 15:27:10.751+07	2025-06-29 15:27:10.751+07
22	14	11	1	57600.00	2025-06-29 15:27:10.751+07	2025-06-29 15:27:10.751+07
23	15	13	1	81600.00	2025-06-30 15:36:00.326+07	2025-06-30 15:36:00.326+07
24	15	16	1	100000.00	2025-06-30 15:36:00.326+07	2025-06-30 15:36:00.326+07
25	15	15	1	10000.00	2025-06-30 15:36:00.326+07	2025-06-30 15:36:00.326+07
26	15	14	1	10000.00	2025-06-30 15:36:00.326+07	2025-06-30 15:36:00.326+07
27	15	10	1	172500.00	2025-06-30 15:36:00.326+07	2025-06-30 15:36:00.326+07
28	16	15	1	10000.00	2025-06-30 15:36:34.08+07	2025-06-30 15:36:34.08+07
29	16	16	1	100000.00	2025-06-30 15:36:34.08+07	2025-06-30 15:36:34.08+07
30	16	14	1	10000.00	2025-06-30 15:36:34.08+07	2025-06-30 15:36:34.08+07
31	16	11	1	57600.00	2025-06-30 15:36:34.08+07	2025-06-30 15:36:34.08+07
32	17	8	1	133500.00	2025-06-30 15:36:58.603+07	2025-06-30 15:36:58.603+07
34	17	10	1	172500.00	2025-06-30 15:36:58.603+07	2025-06-30 15:36:58.603+07
35	18	9	1	76000.00	2025-06-30 15:37:21.559+07	2025-06-30 15:37:21.559+07
36	18	13	1	81600.00	2025-06-30 15:37:21.559+07	2025-06-30 15:37:21.559+07
37	18	16	1	100000.00	2025-06-30 15:37:21.559+07	2025-06-30 15:37:21.559+07
38	18	10	1	172500.00	2025-06-30 15:37:21.559+07	2025-06-30 15:37:21.559+07
39	20	15	2	10000.00	2025-06-30 20:52:00.198+07	2025-06-30 20:52:00.198+07
40	20	14	1	10000.00	2025-06-30 20:52:00.205+07	2025-06-30 20:52:00.205+07
41	20	11	1	57600.00	2025-06-30 20:52:00.207+07	2025-06-30 20:52:00.207+07
42	20	16	2	100000.00	2025-06-30 20:52:00.21+07	2025-06-30 20:52:00.21+07
43	21	16	1	100000.00	2025-07-02 12:41:28.322+07	2025-07-02 12:41:28.322+07
44	21	15	1	10000.00	2025-07-02 12:41:28.334+07	2025-07-02 12:41:28.334+07
45	21	10	1	172500.00	2025-07-02 12:41:28.335+07	2025-07-02 12:41:28.335+07
46	21	9	1	76000.00	2025-07-02 12:41:28.336+07	2025-07-02 12:41:28.336+07
47	22	25	1	70000.00	2025-07-02 21:41:20.3+07	2025-07-02 21:41:20.3+07
48	22	15	1	10000.00	2025-07-02 21:41:20.304+07	2025-07-02 21:41:20.304+07
49	22	16	1	100000.00	2025-07-02 21:41:20.307+07	2025-07-02 21:41:20.307+07
50	23	10	1	172500.00	2025-07-04 10:40:33.225+07	2025-07-04 10:40:33.225+07
51	23	14	1	45000.00	2025-07-04 10:40:33.231+07	2025-07-04 10:40:33.231+07
52	23	11	2	57600.00	2025-07-04 10:40:33.233+07	2025-07-04 10:40:33.233+07
53	23	15	1	68000.00	2025-07-04 10:40:33.235+07	2025-07-04 10:40:33.235+07
54	23	16	1	40000.00	2025-07-04 10:40:33.236+07	2025-07-04 10:40:33.236+07
55	24	15	5	68000.00	2025-07-04 10:50:16.797+07	2025-07-04 10:50:16.797+07
56	25	22	2	52000.00	2025-07-04 15:20:58.597+07	2025-07-04 15:20:58.597+07
61	27	10	1	172500.00	2025-07-06 18:25:03.345+07	2025-07-06 18:25:03.345+07
62	27	11	1	57600.00	2025-07-06 18:25:03.352+07	2025-07-06 18:25:03.352+07
63	27	22	1	52000.00	2025-07-06 18:25:03.355+07	2025-07-06 18:25:03.355+07
64	27	16	2	40000.00	2025-07-06 18:25:03.357+07	2025-07-06 18:25:03.357+07
78	32	11	1	57600.00	2025-07-06 19:37:01.356+07	2025-07-06 19:37:01.356+07
79	32	10	1	172500.00	2025-07-06 19:37:01.36+07	2025-07-06 19:37:01.36+07
80	32	22	1	52000.00	2025-07-06 19:37:01.362+07	2025-07-06 19:37:01.362+07
81	32	15	1	68000.00	2025-07-06 19:37:01.364+07	2025-07-06 19:37:01.364+07
82	32	16	1	40000.00	2025-07-06 19:37:01.365+07	2025-07-06 19:37:01.365+07
83	33	11	1	57600.00	2025-07-06 21:18:02.794+07	2025-07-06 21:18:02.794+07
84	33	15	1	68000.00	2025-07-06 21:18:02.802+07	2025-07-06 21:18:02.802+07
85	33	35	1	64000.00	2025-07-06 21:18:02.804+07	2025-07-06 21:18:02.804+07
86	33	16	1	40000.00	2025-07-06 21:18:02.805+07	2025-07-06 21:18:02.805+07
87	34	10	1	172500.00	2025-07-07 22:57:11+07	2025-07-07 22:57:11+07
88	34	15	1	68000.00	2025-07-07 22:57:11.005+07	2025-07-07 22:57:11.005+07
89	34	11	1	57600.00	2025-07-07 22:57:11.007+07	2025-07-07 22:57:11.007+07
90	34	16	1	40000.00	2025-07-07 22:57:11.008+07	2025-07-07 22:57:11.008+07
91	35	15	102	68000.00	2025-07-08 09:53:22.571+07	2025-07-08 09:53:22.571+07
92	36	35	1	64000.00	2025-07-08 09:59:27.337+07	2025-07-08 09:59:27.337+07
93	36	34	1	48000.00	2025-07-08 09:59:27.348+07	2025-07-08 09:59:27.348+07
94	36	36	1	36000.00	2025-07-08 09:59:27.351+07	2025-07-08 09:59:27.351+07
95	37	14	10	45000.00	2025-07-08 10:04:58.29+07	2025-07-08 10:04:58.29+07
96	37	36	10	36000.00	2025-07-08 10:04:58.3+07	2025-07-08 10:04:58.3+07
97	37	35	10	64000.00	2025-07-08 10:04:58.303+07	2025-07-08 10:04:58.303+07
98	37	34	10	48000.00	2025-07-08 10:04:58.307+07	2025-07-08 10:04:58.307+07
99	38	14	1	45000.00	2025-07-08 10:09:28.952+07	2025-07-08 10:09:28.952+07
100	38	34	1	48000.00	2025-07-08 10:09:28.962+07	2025-07-08 10:09:28.962+07
101	38	35	6	64000.00	2025-07-08 10:09:28.965+07	2025-07-08 10:09:28.965+07
102	39	15	11	68000.00	2025-07-09 15:52:56.773+07	2025-07-09 15:52:56.773+07
103	40	13	1	81600.00	2025-07-09 23:55:03.051+07	2025-07-09 23:55:03.051+07
104	40	35	1	64000.00	2025-07-09 23:55:03.056+07	2025-07-09 23:55:03.056+07
105	40	16	1	40000.00	2025-07-09 23:55:03.057+07	2025-07-09 23:55:03.057+07
106	40	34	2	48000.00	2025-07-09 23:55:03.058+07	2025-07-09 23:55:03.058+07
107	41	15	6	68000.00	2025-07-10 22:24:38.958+07	2025-07-10 22:24:38.958+07
\.


--
-- TOC entry 5154 (class 0 OID 19318)
-- Dependencies: 248
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: cuduc
--

COPY public.orders (id, user_id, ten_nguoi_nhan, email_nguoi_nhan, sdt_nguoi_nhan, dia_chi_giao_hang, ghi_chu_khach_hang, tong_tien_hang, phi_van_chuyen, tong_thanh_toan, phuong_thuc_thanh_toan, trang_thai_don_hang, trang_thai_thanh_toan, "createdAt", "updatedAt", ma_khuyen_mai_da_ap_dung, so_tien_giam_gia) FROM stdin;
18	7	Trần Anh Đức	tranhduc1001@gmail.com	0339952573	250 Lê Hồng Phong	hi	430100.00	30000.00	460100.00	COD	confirmed	f	2025-06-30 15:37:21.552+07	2025-06-30 15:38:19.653+07	\N	0.00
4	2	Trần Anh Đức	tranduc123@gmail.com	0339952573	250 Lê Hồng Phong	hi	1221.00	30000.00	31221.00	COD	cancelled	f	2025-06-20 14:14:27.774+07	2025-06-22 16:22:36.155+07	\N	0.00
16	7	Trần Đức	tranhduc1001@gmail.com	0339956475	250 Lê Hồng Phong	hi	177600.00	30000.00	207600.00	COD	shipping	f	2025-06-30 15:36:34.07+07	2025-06-30 15:38:55.596+07	\N	0.00
17	7	Trần Anh Đức	tranhduc1001@gmail.com	0339952573	250 Lê Hồng Phong	hi	417111.00	30000.00	447111.00	COD	delivered	t	2025-06-30 15:36:58.598+07	2025-06-30 15:40:00.402+07	\N	0.00
9	2	Trần Anh Đức	tranduc123@gmail.com	0339952573	250 Lê Hồng Phong	hihi	10000.00	30000.00	40000.00	COD	cancelled	f	2025-06-23 19:42:18.176+07	2025-06-23 20:08:43.749+07	\N	0.00
10	2	Trần Anh Đức	tranvanquockhanh123@gmail.com	0339952573	510 Lê Hồng Phong		100000.00	30000.00	130000.00	COD	cancelled	f	2025-06-23 19:44:01.802+07	2025-06-24 16:16:55.996+07	\N	0.00
12	5	Trần Anh Tài	trantai123@gmail.com	0339956475	251 Lê Hồng Phong	hiii	101600.00	30000.00	131600.00	COD	cancelled	f	2025-06-29 13:46:38.956+07	2025-06-29 14:07:35.902+07	\N	0.00
32	7	Trần Đức	tranhduc1001@gmail.com	0339952573	520 Lê Hồng Phong, Xã Đình Phùng, Huyện Bảo Lạc, Tỉnh Cao Bằng	hi	390100.00	30000.00	400100.00	COD	pending	f	2025-07-06 19:37:01.352+07	2025-07-06 19:37:01.352+07	SALE7/7	20000.00
20	7	Trần Anh Đức	tranhduc1001@gmail.com	0339952573	250 Lê Hồng Phong	hiii	287600.00	30000.00	317600.00	COD	delivered	t	2025-06-30 20:52:00.193+07	2025-06-30 22:37:11.749+07	\N	0.00
21	7	Trần Anh Đức	tranhduc1001@gmail.com	0339952573	250 Lê Hồng Phong	hiii	358500.00	30000.00	388500.00	COD	delivered	t	2025-07-02 12:41:28.317+07	2025-07-02 12:42:19.576+07	\N	0.00
13	7	Trần Đức	tranhduc1001@gmail.com	0339985777	113 Lê Hông Phong	hiii	311700.00	30000.00	341700.00	COD	cancelled	f	2025-06-29 15:09:16.372+07	2025-06-29 15:10:39.89+07	\N	0.00
34	7	Trần Đức	tranhduc1001@gmail.com	0339952573	520 Lê Hồng Phong, Thị trấn An Phú, Huyện An Phú, Tỉnh An Giang	hi	338100.00	30000.00	348100.00	COD	confirmed	f	2025-07-07 22:57:10.997+07	2025-07-07 23:07:00.644+07	SALE7/7	20000.00
14	7	Trần Đức	tranhduc1001@gmail.com	0339952573	251 Lê Hồng Phong	hi	239200.00	30000.00	269200.00	COD	delivered	t	2025-06-29 15:27:10.74+07	2025-06-29 15:30:18.007+07	\N	0.00
3	2	Trần Anh Đức	tranduc123@gmail.com	0339952573	250 Lê Hồng Phong	hi	1212.00	30000.00	31212.00	COD	delivered	t	2025-06-20 14:13:11.668+07	2025-06-29 15:30:40.925+07	\N	0.00
15	7	Trần Anh Đức	tranhduc1001@gmail.com	0339952573	250 Lê Hồng Phong	hi	374100.00	30000.00	404100.00	COD	pending	f	2025-06-30 15:36:00.313+07	2025-06-30 15:36:00.313+07	\N	0.00
24	7	Trần Đức	tranhduc1001@gmail.com	0339952573	250 Lê Hồng Phong	hiiii	340000.00	30000.00	350000.00	COD	delivered	t	2025-07-04 10:50:16.793+07	2025-07-04 12:16:44.195+07	SALE7/7	20000.00
35	7	Trần Đức	tranhduc1001@gmail.com	0339952573	520 Lê Hồng Phong, Xã Tự Do, Huyện Quảng Hòa, Tỉnh Cao Bằng	hi	6936000.00	30000.00	6966000.00	COD	cancelled	f	2025-07-08 09:53:22.56+07	2025-07-08 09:58:22.649+07	\N	0.00
25	7	Trần Đức	tranhduc1001@gmail.com	0339952573	520 Lê Hồng Phong, Phường 10, Quận 10, Thành phố Hồ Chí Minh	hi	104000.00	30000.00	114000.00	COD	delivered	t	2025-07-04 15:20:58.59+07	2025-07-04 15:22:11.105+07	SALE7/7	20000.00
23	7	Trần Đức	tranhduc1001@gmail.com	0339952573	250 Lê Hồng Phong	hi	440700.00	30000.00	450700.00	COD	cancelled	f	2025-07-04 10:40:33.218+07	2025-07-04 15:22:44.73+07	SALE7/7	20000.00
22	7	Trần Anh Đức	tranhduc1001@gmail.com	0339952573	250 Lê Hồng Phong	hii	180000.00	30000.00	210000.00	COD	confirmed	f	2025-07-02 21:41:20.296+07	2025-07-04 15:23:17.043+07	\N	0.00
27	7	Trần Đức	tranhduc1001@gmail.com	0339952573	520 Lê Hồng Phong, Thị trấn An Phú, Huyện An Phú, Tỉnh An Giang	hi	362100.00	30000.00	372100.00	momo	pending_payment	f	2025-07-06 18:25:03.339+07	2025-07-06 18:25:03.339+07	SALE7/7	20000.00
37	7	Trần Đức	tranhduc1001@gmail.com	0339952573	198 lê hồng phong, Xã Đức Đồng, Huyện Đức Thọ, Tỉnh Hà Tĩnh	hi	1930000.00	30000.00	1890000.00	COD	delivered	t	2025-07-08 10:04:58.282+07	2025-07-08 10:05:36.371+07	BOOKZONE	70000.00
36	7	Trần Đức	tranhduc1001@gmail.com	0339952573	198 lê hồng phong, Xã Thượng Hà, Huyện Bảo Lạc, Tỉnh Cao Bằng	hi	148000.00	30000.00	178000.00	COD	cancelled	f	2025-07-08 09:59:27.334+07	2025-07-08 10:02:54.55+07	\N	0.00
38	7	Trần Đức	tranhduc1001@gmail.com	0339952573	198 lê hồng phong, Xã Đức Đồng, Huyện Đức Thọ, Tỉnh Hà Tĩnh	hi	477000.00	30000.00	457000.00	COD	confirmed	f	2025-07-08 10:09:28.945+07	2025-07-08 10:10:17.49+07	BOOKZONE111	50000.00
39	7	Trần Đức	tranhduc1001@gmail.com	0339952573	198 lê hồng phong, Xã Đức Đồng, Huyện Đức Thọ, Tỉnh Hà Tĩnh	hi	748000.00	30000.00	708000.00	momo	pending_payment	f	2025-07-09 15:52:56.769+07	2025-07-09 15:52:56.769+07	BOOKZONE	70000.00
33	7	Trần Đức	tranhduc1001@gmail.com	0339952573	520 Lê Hồng Phong, Xã Hoà Long, Thành phố Bà Rịa, Tỉnh Bà Rịa - Vũng Tàu	hi	229600.00	30000.00	239600.00	COD	confirmed	f	2025-07-06 21:18:02.79+07	2025-07-09 23:14:14.604+07	SALE7/7	20000.00
40	7	Trần Đức	tranhduc1001@gmail.com	0339952573	198 lê hồng phong, Xã Đồng Quang, Huyện Quốc Oai, Thành phố Hà Nội	hi	281600.00	30000.00	291600.00	COD	pending	f	2025-07-09 23:55:03.046+07	2025-07-09 23:55:03.046+07	SALE7/7	20000.00
41	7	Trần Đức	tranhduc1001@gmail.com	0339952573	198 lê hồng phong, Phường 10, Quận 5, Thành phố Hồ Chí Minh	hi	408000.00	30000.00	368000.00	COD	pending	f	2025-07-10 22:24:38.953+07	2025-07-10 22:24:38.953+07	BOOKZONE	70000.00
\.


--
-- TOC entry 5166 (class 0 OID 20812)
-- Dependencies: 260
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: cuduc
--

COPY public.posts (id, tieu_de, slug, tom_tat, noi_dung, anh_dai_dien, trang_thai, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 5142 (class 0 OID 19234)
-- Dependencies: 236
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: cuduc
--

COPY public.products (id, ten_sach, mo_ta_ngan, gia_bia, so_luong_ton_kho, tac_gia, nha_xuat_ban, nam_xuat_ban, img, product_type, ebook_url, danh_muc_id, "createdAt", "updatedAt", so_trang) FROM stdin;
10	Combo Nghìn Lẻ Một Ngày (Hộp 2 Tập)		172500.00	4	François Pétis de La Croix	Văn học	2017	/images/img-1751456844772-575368079.png	print_book	\N	30	2025-06-23 17:41:18.717+07	2025-07-07 22:57:11.004+07	200
14	Gió Lạnh Đầu Mùa - Thạch Lam (Tái Bản)	Tuyển tập truyện ngắn Gió lạnh đầu mùa\r\n\r\n \r\n\r\nVài nét về tác giả Thạch Lam Thạch Lam \r\n\r\nTên thật là Nguyễn Tường Vinh, sau đổi là Nguyễn Tường Lân, bút danh khác là Việt Sinh, Thiện Sỹ. Thạch Lam là thành viên quan trọng của nhóm Tự lực văn đoàn. Ông tham gia biên tập các báo Phong hóa, Ngày nay. Thạch Lam sáng tác nhiều thể loại văn học khác nhau như truyện ngắn, tiểu thuyết, bút kí, tiểu luận, hầu như tất cả đều được đăng báo trước khi in thành sách. \r\n\r\n \r\n\r\nTác phẩm chính: Các tập truyện ngắn Gió đầu mùa – Đời nay, Hà Nội, 1937; Nắng trong vườn – Đời nay, Hà Nội, 1938; Sợi tóc – Đời nay, Hà Nội, 1942; Tiểu thuyết Ngày mới – Đời nay, Hà Nội, 1939; Tập tiểu luận Theo giòng – Đời nay, Hà Nội, 1941; Tập kí Hà Nội 36 phố phường – Đời nay, Hà Nội, 1943. Trong văn học Việt Nam trước Cách mạng 1945, Thạch Lam là một trong số những nhà văn được nhiều cảm tình của người đọc. Lời văn Thạch Lam nhiều hình ảnh, nhiều tìm tòi, có một cách điệu thanh thản, bình dị và sâu sắc. Văn Thạch Lam đọng nhiều suy nghiệm, nó là cái kết tinh của một tâm hồn nhạy cảm và từng trải về sự đời. Thạch Lam có những nhận xét tinh tế về cuộc sống hằng ngày. Xúc cảm của nhà văn Thạch Lam thường bắt nguồn và nảy nở lên từ những chân cảm đối với những con người ở tầng lớp dân nghèo thành thị và thôn quê. Thạch Lam là một nhà văn quý mến cuộc sống, trang trọng trước sự sống của mọi người chung quanh. Ngày nay đọc lại Thạch Lam, vẫn thấy đầy đủ cái dư vị và cái nhã thú của những tác phẩm có cốt cách và phẩm chất văn học. Nhưng đứng về mặt góp phần vào việc xây dựng tiếng nói và nhất là góp phần vào công cuộc xây dựng một nền văn xuôi Việt Nam hãy còn trẻ tuổi, đứng trên chỗ đó mà bàn về Thạch Lam thì cũng dễ có sự đồng tình của tất cả. Bằng sáng tác văn học, Thạch Lam đã làm cho tiếng nói Việt Nam gọn ghẽ đi, co duỗi thêm, mềm mại ra, và tươi đặm hơn.\r\n\r\n \r\n\r\nVề tuyển tập truyện ngắn Gió lạnh đầu mùa \r\n\r\nGió lạnh đầu mùa tập hợp toàn bộ những tác phẩm trong tập truyện ngắn Gió đầu mùa của nhà văn Thạch Lam, cuốn sách bao gồm các truyện: Đứa con đầu lòng, Nhà mẹ Lê, Trở về…Trong những truyện ngắn của ông người ta thấm thía nỗi khổ đau, bất hạnh, hoàn cảnh éo le của những con người nghèo khổ vừa cảm nhận sâu sắc tình người ấm nồng, cao quý, thiêng liêng.\r\n\r\n \r\n\r\nKhi giới thiệu về tập truyện ngắn Gió đầu mùa, Thạch Lam viết rằng: "Đối với tôi văn chương không phải là một cách đem đến cho người đọc sự thoát ly trong sự quên, trái lại văn chương là một thứ khí giới thanh cao và đắc lực mà chúng ta có, để vừa tố cáo và thay đổi một cái thế giới giả dối và tàn ác, làm cho lòng người được thêm trong sạch và phong phú hơn". Quả thực Thạch Lam đã rất trung thành với triết lý viết văn này và từng trang truyện của ông đều hướng về lớp người lao động bần cùng trong những khung cảnh ảm đạm, heo hút. Một mẹ Lê góa bụa, nghèo khổ phải nuôi một đàn con đông đúc, một bác Dư làm phu xe ở phố hàng Bột, cô Tâm hàng xén trong buổi hoàng hôn... Thạch Lam không gắn nhân vật với những sự kiện bi thảm hóa hoàn cảnh của họ nhưng cũng không khoác lên họ "một thứ ánh trăng lừa dối". Chính vì vậy, tác phẩm của Thạch Lam giữ được chất hiện thực nhưng không quá bi kịch như Lão Hạc, Chí Phèo... của Nam Cao.	45000.00	25	Thạch Lam	Văn học	2022	/images/img-1751456657897-311128063.webp	print_book	\N	30	2025-06-23 17:45:46.416+07	2025-07-08 10:09:28.96+07	220
9	Chiếc Lá Cuối Cùng - O. Henry (Tái Bản) 	Tuyển tập truyện ngắn Chiếc Lá Cuối Cùng\r\n\r\n \r\n\r\nĐôi nét về tác giả O. Henry\r\n\r\nO.Hen-ri (William Sydney Porter), sinh ngày11 tháng 9 năm 1862 – mất ngày 5 tháng 6 năm 1910, được biết đến với bút danh O. Henry. Ông là một nhà văn người Mỹ đã rất nổi tiếng với bạn đọc Việt Nam qua truyện ngắn Chiếc lá cuối cùng.\r\n\r\n \r\n\r\nVề tuyển tập truyện ngắn của O. Henry\r\n\r\nTruyện ngắn của O.Hen-ri nổi tiếng là dí dỏm, dễ hiểu, giàu tình cảm và luôn có những cái kết bất ngờ một cách khéo léo. Tình cảm của ông luôn hướng về những người nghèo, những người bất hạnh. Truyện ngắn của ông thường sâu sắc, cảm động và đầy chất thơ. Nhiều truyện ngắn của ông được xem là hay nhất thế giới và vẫn được xem là mẫu mực cho các nhà văn trẻ trong nhiều thập niên sau. Qua những tuyên ngôn nghệ thuật được phát biểu trực tiếp hoặc bằng lời người trần thuật hay bằng hình tượng nghệ thuật trong truyện ngắn, O.Hen-ri đã thể hiện quan niệm sáng tác của một nghệ sĩ hiện thực, một nghệ sĩ của tình thương yêu, đầy lòng nhân ái.\r\n\r\n"Chiếc lá cuối cùng" là một truyện ngắn của nhà văn người Mỹ O. Henry  nằm trong tuyển tập này. Tác phẩm được xuất bản lần đầu vào năm 1907 trong tập truyện The Trimmed Lamp and Other Stories. Truyện ngắn đã được đưa vào sách giáo khoa của nhiều nước để giới thiệu văn học nước ngoài, trong đó có sách giáo khoa Ngữ Văn lớp 8 tập 2.	76000.00	29	O. Henry	Văn học	2022	/images/img-1751456876657-838532463.png	print_book	\N	30	2025-06-23 17:40:22.223+07	2025-07-04 15:11:09.699+07	336
12	Gulliver Du Ký - Jonathan Swift	Jonathan Swift (1667–1745) là nhà thơ, nhà văn trào phúng Ai-len gốc Anh. Ông là một nhà văn có tài, ghét những trò giả dối, thích châm biếm và chửi đời, và là một nhà ái quốc chân chính. Ông sáng tác NXB Văn Học từ năm 1704.Những năm 1720 – 1736, Swift sáng tác những bài thơ hay nhất và viết Gulliver du ký (Gulliver’s Travels), tác phẩm kinh điển của NXB Văn Học Anh và thế giới.\r\n\r\n\r\n\r\nGulliver du ký không đơn thuần chỉ là một cuốn phiêu lưu ký, du ký thông thường để giải trí trong chốc lát mà là một cuốn sách trong đó tác giả gửi gắm bao tâm huyết với những nhận xét sâu sắc về cuộc đời và những con người, khiến người đọc phải suy nghĩ.Thoạt nhìn Gulliver du ký là một cuộc phiêu lưu vui nhộn, một cuốn sách dành cho trẻ em. Nhưng thực ra đây là một tác phẩm châm biếm sâu sắc: Swift chỉ ra điều nực cười của dân chúng dựa trên hoàn cảnh chính trị xã hội nước Anh thế kỷ XVIII.	65000.00	20	Jonathan Swift	NXB Văn Học	2016	/images/img-1751456781251-700048341.png	print_book	\N	30	2025-06-23 17:44:33.629+07	2025-07-02 22:01:28.84+07	400
25	Sách: Những Cuộc Phiêu Lưu Của Sherlock Holmes (Tái Bản)	Những Cuộc Phiêu Lưu Của Sherlock Holmes\r\nSir Arthur Conan Doyle (22/5/1859 – 7/7/1930) là nhà văn người Scotland nổi tiếng với tiểu thuyết trinh thám Sherlock Holmes, tác phẩm được cho là một sáng kiến lớn trong lĩnh vực tiểu thuyết trinh thám. Các tác phẩm của ông bao gồm nhiều truyện khoa học giả tưởng, tiểu thuyết lịch sử, kịch lịch sử, tiểu thuyết, thơ và bút ký.\r\nSherlock Holmes là một nhân vật thám tử hư cấu, xuất hiện lần đầu trong tác phẩm của nhà văn Arthur Conan Doyle xuất bản năm 1887. Nhân vật là một thám tử tư ở London, nổi tiếng nhờ trí thông minh, khả năng suy diễn logic và quan sát tinh tường trong khi phá những vụ án mà cảnh sát phải bó tay. Nhiều người cho rằng Sherlock Holmes là nhân vật thám tử hư cấu nổi tiếng nhất trong lịch sử NXB Văn Học và là một trong những nhân vật NXB Văn Học được biết đến nhiều nhất trên toàn thế giới.\r\nTính đến nay, tác phẩm và nhân vật này đã có sức sống trải dài ba thế kỉ. Thế mà khắp nơi trên thế giới, các nhà xuất bản vẫn tiếp tục tái bản sách của Conan Doyle, nhân vật Sherlock Holmes vẫn tiếp tục được tái sinh trong nhiều hình thức nghệ thuật: Điện ảnh, sân khấu, hội họa, truyện tranh, game....\r\n... Ở Holmes có đầy đủ hai yếu tố tạo thành một con người lí tưởng, đó là một trí tuệ sáng suốt và một trái tim nhân hậu. “Tôi không phải là công lí, nhưng tôi đại diện cho công lí trong phạm vị nhỏ hẹp của tôi” là phát biểu giản dị và gần như duy nhất của Holmes về ý nghĩa và mục đích cao đẹp các cống hiến lớn lao của mình.\r\n\r\n \r\n\r\nCó lẽ chính điều này đã tạo nên sự đồng cảm với độc giả. Dù các vụ án của Holmes đã cách đây hàng thế kỉ, nhưng những thế lực tà ác, đen tối luôn luôn có mặt ở bất cứ thời đại nào. Chính vì vậy mà câu chuyện về Sherlock Holmes luôn luôn ấm nóng tính thời sự, và từ trong thẳm sâu tâm thức của nhân dân luôn rất cần một tinh thần Sherlock Holmes - tinh thần của những trang hiệp sĩ tận tâm, tận lực trong nhiệm vụ cao cả và nặng nề “trừ gian, diệt ác”, và đây cũng chính là một trong những bí quyết tạo nên sự bất tử của vị thám tử lừng danh này.\r\n\r\n 	70000.00	19	Arthur Conan Doyle	NXB Văn học	2022	/images/img-1751453988464-988688120.png	print_book	\N	30	2025-07-02 17:21:48.451+07	2025-07-04 15:11:09.694+07	308
8	Tư Duy Về Tiền Bạc	Tư Duy Về Tiền Bạc \r\n\r\n \r\n\r\nMục tiêu của bạn trong vấn đề tài chính cá nhân và đầu tư là gì? \r\n\r\nLà tìm cách đánh bại được thị trường, là thu nhập được lượng của cải khổng lồ? Nhưng thực tế là, chỉ có một số ít những người may mắn mới có thể đạt được như những gì mà số đông tin là con đường dẫn tới thành công tài chính.  \r\n\r\n \r\n\r\n\r\n\r\n \r\n\r\nQua Tư duy về tiền bạc - sản phẩm của hơn 30 năm làm việc trong lĩnh vực tài chính cá nhân, Jonathan Clements đã cung cấp cho bạn đọc một cách thức rõ ràng hơn, sáng suốt hơn để suy nghĩ về tình trạng tài chính của mình, để có những lựa chọn thông minh hơn và giành được nhiều hạnh phúc nhất từ những đồng tiền mình. Ngắn gọn, rõ ràng và đầy ắp những lời khuyên tuyệt vời về tài chính, cuốn sách sẽ dạy bạn cách phớt lờ các bản năng của mình, kiềm chế nhưng cảm xúc, hít thở sâu và không ngừng tập trung vào những gì tốt nhất cho bản thân - cho hạnh phúc và tự do tài chính của bạn trong suốt một đời người.\r\n\r\n \r\n\r\n \r\n\r\n \r\n\r\n#Sách_kinh_doanh #Tư_duy_về_tiền_bạc\r\n\r\n#Sách_kinh_tế  #tài_chính_cá_nhân 	64000.00	23	Nhiều tác giả	Thanh Niên	2022	/images/img-1751456912645-745079038.png	print_book	\N	29	2025-06-23 16:58:44.555+07	2025-07-02 21:59:50.63+07	216
34	Tập Truyện Ngắn Vợ Nhặt - Kim Lân (Tái Bản	<h1 style="text-align: center;"><strong>Tập truyện ngắn Vợ nhặt</strong></h1>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>Kim L&acirc;n t&ecirc;n thật l&agrave; Nguyễn Văn T&agrave;i, sinh ng&agrave;y 1 th&aacute;ng 8 năm 1920.&nbsp;</p>\r\n<p><br>&Ocirc;ng qu&ecirc; ở l&agrave;ng Ph&ugrave; Lưu, x&atilde; T&acirc;n Hồng, huyện Từ Sơn (nay l&agrave; l&agrave;ng Ph&ugrave; Lưu, phường Đ&ocirc;ng Ng&agrave;n, thị x&atilde; Từ Sơn), tỉnh Bắc Ninh. Do ho&agrave;n cảnh gia đ&igrave;nh kh&oacute; khăn, &ocirc;ng chỉ được học hết bậc tiểu học rồi phải đi l&agrave;m. Kim L&acirc;n bắt đầu viết truyện ngắn từ năm 1941. Một số truyện (Vợ nhặt, Đứa con người vợ lẽ,...) mang t&iacute;nh chất tự truyện nhưng đ&atilde; thể hiện được kh&ocirc;ng kh&iacute; ti&ecirc;u điều, ảm đạm của n&ocirc;ng th&ocirc;n Việt Nam v&agrave; cuộc sống lam lũ, vất vả của người n&ocirc;ng d&acirc;n thời k&igrave; đ&oacute;.</p>\r\n<p><br>Sau C&aacute;ch Mạng th&aacute;ng T&aacute;m, Kim L&acirc;n tiếp tục l&agrave;m b&aacute;o, viết văn. &Ocirc;ng vẫn chuy&ecirc;n về truyện ngắn v&agrave; vẫn viết về l&agrave;ng qu&ecirc; Việt Nam - mảng hiện thực m&agrave; từ l&acirc;u &ocirc;ng đ&atilde; hiểu biết s&acirc;u sắc. Những t&aacute;c phẩm ch&iacute;nh: N&ecirc;n vợ n&ecirc;n chồng (tập truyện ngắn, 1955), Con ch&oacute; xấu x&iacute; (tập truyện ngắn, 1962).</p>\r\n<p><img style="display: block; margin-left: auto; margin-right: auto;" src="https://file.hstatic.net/1000237375/file/_mg_9876_grande.jpg"></p>\r\n<p>&nbsp;</p>\r\n<p>Tập truyện ngắn &ldquo;Vợ nhặt&rdquo; tập hợp những truyện ngắn đặc sắc nhất của Kim L&acirc;n &ndash; một c&acirc;y b&uacute;t truyện ngắn vững v&agrave;ng, viết về cuộc sống v&agrave; con người ở n&ocirc;ng th&ocirc;n bằng t&igrave;nh cảm, t&acirc;m hồn của một người vốn l&agrave; con đẻ của đồng ruộng.</p>	48000.00	7	Kim Lân	Văn học	2022	/images/img-1751710475671-146844492.png	print_book	\N	31	2025-07-05 17:14:35.679+07	2025-07-09 23:55:03.059+07	232
15	Giông Tố - Vũ Trọng Phụng (Tái Bản) 	Tiểu thuyết Giông tố\r\n\r\n \r\n\r\n \r\n\r\nĐôi nét về tác giả\r\n\r\nVũ Trọng Phụng sinh năm 1912 tại Hà Nội trong một gia đình nghèo. Chính quê nhà văn ở làng Hảo (tức Bần, Yên Nhân, huyện Mỹ Hào, tỉnh Hưng Yên).\r\n\r\nVũ Trọng Phụng có truyện ngắn đăng trên nhiều tờ báo từ năm 1930. Tác phẩm của nhà văn hầu hết đăng báo trước khi in thành sách.\r\n\r\nTác phẩm chính: Không một tiếng vang (kịch, 1931), Cạm bẫy người (phóng sự, 1933), Dứt tình (tiểu thuyết, 1934), Kỹ nghệ lấy Tây (phóng sự, 1934), Giông tố (tiểu thuyết, 1936), Cơm thầy cơm cô (phóng sự, 1936), Vỡ đê (tiểu thuyết, 1936), Số đỏ (tiểu thuyết, 1936), Làm đĩ (tiểu thuyết, 1936), Lấy nhau vì tình (tiểu thuyết, 1937), Lục sì (phóng sự, 1937), Trúng số độc đắc (tiểu thuyết, 1938),... và nhiều truyện ngắn.\r\n\r\nÔng mất ngày 13 tháng 10 năm 1939 vì bệnh lao.\r\n\r\n"...Cái độc đáo của Vũ Trọng Phụng thì rất nhiều. Ông mất rất sớm nhưng đã để lại 8 tiểu thuyết, 4 phóng sự dài, nhiều bài báo, tiểu luận. Trường hợp đó trong lịch sử NXB Văn Học thế giới rất hiếm. Trong số các tác phẩm đó, tôi thấy Vũ Trọng Phụng có hai tiểu thuyết “Số đỏ” và “Giông tố” là hai tiểu thuyết quan trọng nhất trong lịch sử NXB Văn Học Việt Nam thế kỉ XX…”\r\n\r\n(Giáo sư Peter Zinoman)\r\n\r\n---\r\n\r\nVề tiểu thuyết Giông tố\r\n\r\nGiông tố là tác phẩm mang nội dung châm biếm sâu sắc về một xã hội mục nát, sự hỗn loạn khi pha trộn hai nền văn hóa giữa Tây và ta, thể hiện rõ sự bần cùng của những người nghèo khổ và lên án thái độ sa đọa hống hách của kẻ giàu có.\r\n\r\nTrong Giông tố, Vũ Trọng Phụng bóc trần mọi khía cạnh xấu xa của con người, sự tha hóa, nhẫn tâm ẩn sâu bên trong một xã hội mục nát. Ông đã thành công xuất sắc trong việc xây dựng một câu chuyện về tầng lớp tư sản thối nát đương thời.	68000.00	189	Vũ Trọng Phụng	Văn học	2022	/images/img-1751456617162-258999088.png	print_book	\N	31	2025-06-23 17:47:08.18+07	2025-07-10 22:24:38.963+07	364
22	Tiểu Thuyết Bước Đường Cùng - Nguyễn Công Hoan	"Vợ chồng Pha nhịn đói không được, đành phải ra sau nhà, bẻ buồng chuối xanh, bán rẻ, để mua gạo nấu cháo. Nhưng cũng chỉ được một bữa. Bữa sau, anh phải bán cái phản đi, lấy hai hào. Rồi áo quần, bát đĩa, cứ dần dần theo nhau đi ra ngoài để chuộc về cho chủ một ít gạo. Nhưng rồi quanh mình anh không có gì bán được cả. Một lần, anh đã đưa mắt nhìn đến thằng bé con và suy nghĩ. Nhưng nó gầy gò, bẩn thỉu quá, có đem bán cũng chưa chắc có người mua. Giá nó lên năm lên bảy, có sức hầu hạ, thì người ta còn sai vặt được. Đằng này, con anh mới được ngót hai tháng, lại xanh xao vàng vọt, lúc nào cũng như cái mồi sẵn sàng của thần chết, thì người phúc đức đến đâu cũng không dám nuôi.\r\n\r\nAnh nhớ mãi lúc chị tắt thở, thì chân tay co rúm như con vật bị thui. Thấy giường nằm của vợ mọi khi, bây giờ vắng tanh, anh ôm con vào lòng, nức lên khóc. Nghĩ đến cảnh gà trống nuôi con, anh đau đớn lắm. Anh thương vợ đã nhịn đói khát mấy hôm cuối cùng. Nhưng, chợt nghĩ đến sự nhẹ nợ của người chết, anh lại buồn cho thân thế anh. Cảnh anh đã túng lại thêm bấn. Giá không có đứa con mà anh có bổn phận phải nuôi, anh có thể liều, hành động phi pháp để theo mệnh lệnh của thần Đói. Anh có thể ăn cướp, ăn trộm, dù có bị tù tội chăng nữa, anh cũng không còn phải để liên lụy cho ai.\r\n\r\nMà vào tù, dù có mất tự do, nhưng anh không phải lo cơm ăn, áo mặc. Bây giờ cơm không có, áo không có, anh cần tự do để làm gì."\r\n\r\n(Trích đoạn)	52000.00	2	 Nguyễn Công Hoan	NXB Văn Học	2025	/images/img-1751456536666-758127672.png	print_book	\N	31	2025-06-30 20:34:09.248+07	2025-07-06 19:37:01.364+07	250
35	Nhật Ký Trong Tù - Hồ Chí Minh (Tái Bản) 	<p style="text-align: center;"><strong><span style="font-size: 18pt;">NHẬT K&Yacute; TRONG T&Ugrave; - NGỤC TRUNG NHẬT K&Yacute;</span></strong></p>\r\n<p>&nbsp;</p>\r\n<p>Tr&ecirc;n đường đi đến T&uacute;c Vinh (Quảng T&acirc;y, Trung Quốc), Chủ tịch Hồ Ch&iacute; Minh bị ch&iacute;nh quyền Tưởng Giới Thạch bắt giam v&agrave; bị ch&uacute;ng đầy ải qua gần 30 nh&agrave; giam của 13 huyện thuộc tỉnh Quảng T&acirc;y, trong khoảng thời gian 13 th&aacute;ng, đến ng&agrave;y 10 th&aacute;ng 9 năm 1943 mới được thả tự do. Trong thời gian bị cầm t&ugrave;, Người đ&atilde; s&aacute;ng t&aacute;c tập Nhật k&yacute; trong t&ugrave; với 133 b&agrave;i thơ chữ H&aacute;n.Thơ nhật k&yacute; của Người ghi lại ch&acirc;n thực, chi tiết chế độ nh&agrave; t&ugrave; cũng như chế độ x&atilde; hội Trung Quốc thời Tưởng Giới Thạch. Đ&oacute; l&agrave; một chế độ thối n&aacute;t, mục ruỗng, nhiều tệ nạn, nhiều bất c&ocirc;ng; con người th&igrave; c&ugrave;ng cực, chịu nhiều khổ đau. Tập thơ c&ograve;n tập trung phản &aacute;nh r&otilde; n&eacute;t con người Hồ Ch&iacute; Minh về đời sống vật chất, đời sống tinh thần trong suốt thời gian ở t&ugrave;. Trong đ&oacute; c&oacute; n&oacute;i đến cả mối quan hệ của Người với những người cầm quyền, từ những vi&ecirc;n cai ngục, đến những nh&agrave; chức tr&aacute;ch của nhiều cấp của ch&iacute;nh quyền Tưởng. Nhưng nội dung chủ đạo của tập cả tập thơ lại thể hiện con người Hồ Ch&iacute; Minh, một con người vĩ đại.</p>\r\n<p>Gi&aacute;o sư Phương Lựu - nh&agrave; l&yacute; luận ph&ecirc; b&igrave;nh văn học đ&atilde; đưa ra bằng chứng, tuy được viết bằng chữ H&aacute;n nhưng "Nhật k&yacute; trong t&ugrave;" của B&aacute;c rất kh&aacute;c với thơ Đường. Trước hết, n&eacute;t ri&ecirc;ng ấy c&oacute; được l&agrave; do từ ngữ được sử dụng theo chiều hướng phổ th&ocirc;ng h&oacute;a, đại ch&uacute;ng h&oacute;a. B&ecirc;n cạnh vốn từ vựng cổ được vận dụng, B&aacute;c c&ograve;n đưa v&agrave;o nhiều từ ngữ bạch thoại - khẩu ngữ.</p>\r\n<p>&ldquo;Ng&ocirc;n từ của B&aacute;c kh&ocirc;ng phải l&agrave; ng&ocirc;n từ cổ điển. Thể loại thơ của B&aacute;c cũng 4 c&acirc;u nhưng n&oacute; l&agrave; tứ tuyệt tự sự - ghi nhật k&iacute;, kể chuyện. Đ&oacute; l&agrave; điều rất kh&aacute;c thơ Đường. Thơ Đường hay so s&aacute;nh, đối thanh, đối &yacute; nhưng thơ của B&aacute;c kh&ocirc;ng chủ về đối. Những việc l&agrave;m của B&aacute;c rất nhỏ nhưng c&oacute; nhiều việc nhỏ của B&aacute;c cũng c&oacute; &yacute; nghĩa lớn. Điều đ&oacute; khẳng định B&aacute;c của ch&uacute;ng ta rất tr&acirc;n trọng, y&ecirc;u qu&yacute; văn h&oacute;a Trung Quốc v&agrave; ra sức học tập n&oacute; nhưng kh&ocirc;ng bao giờ rập khu&ocirc;n.&rdquo; - Gi&aacute;o sư Phương Lựu ph&acirc;n t&iacute;ch.</p>\r\n<p>Gi&aacute;o sư Phương Lựu khẳng định, cống hiến lớn nhất của Chủ tịch Hồ Ch&iacute; Minh về mặt thể loại NXB Văn Học trong &ldquo;Nhật k&iacute; trong t&ugrave;&rdquo; l&agrave; s&aacute;ng tạo ra thể thơ tứ tuyệt tự sự. Hiển nhi&ecirc;n thơ Đường c&oacute; nhiều b&agrave;i mang t&iacute;nh chất tự sự như: &ldquo;Tam tại&rdquo;, &ldquo;Tam biệt&rdquo; của Đỗ Phủ; &ldquo;Trường hận ca&rdquo;, &ldquo;Tỳ b&agrave; h&agrave;nh&rdquo; của Bạch Cư Dị&hellip; nhưng kh&ocirc;ng phải l&agrave; thơ tứ tuyệt.</p>\r\n<p>Thơ Đường luật, nhất l&agrave; tứ tuyệt, th&igrave; tuyệt đại bộ phận l&agrave; thơ trữ t&igrave;nh, tả cảnh hoặc kết hợp cả hai. Ngược lại, thơ tứ tuyệt trong &ldquo;Nhật k&iacute; trong t&ugrave;&rdquo; tuy c&oacute; những b&agrave;i trữ t&igrave;nh nhưng lại c&oacute; t&iacute;nh chất &ldquo;nhật k&iacute;&rdquo; với nhiều chi tiết đời thường, v&iacute; dụ như b&agrave;i: &ldquo;Chia nước&rdquo;, &ldquo; Viết hộ b&aacute;o c&aacute;o cho c&aacute;c bạn t&ugrave;&rdquo;, &ldquo;L&ecirc;n xe lửa đi Lai T&acirc;n&rdquo;, &ldquo;Cuộc sống trong t&ugrave;&rdquo;&hellip;</p>\r\n<p>&ldquo;Nhật k&iacute; trong t&ugrave;&rdquo; vốn l&agrave; một tập thơ chứa đựng nhiều bất ngờ, th&uacute; vị. T&iacute;nh chất n&ocirc;m na trong thơ chữ H&aacute;n của Hồ Ch&iacute; Minh lại biểu hiện một con người gần gũi, đời thường. Đằng sau c&aacute;i đời thường, t&acirc;m hồn đồng cảm ấy l&agrave; một nh&acirc;n c&aacute;ch lớn, một &yacute; ch&iacute; v&agrave; kh&aacute;t vọng tự do. Mặc d&ugrave;, c&aacute;ch l&agrave;m thơ trong t&ugrave; của Người l&agrave; để giải khu&acirc;y, kh&ocirc;ng giống với c&aacute;c thi sĩ l&agrave;m thơ.</p>\r\n<p>Ở đ&acirc;y, người t&ugrave; l&agrave;m thơ để mong thời gian tr&ocirc;i nhanh hơn, vừa ng&acirc;m vừa đợi đến ng&agrave;y tự do. B&aacute;c l&agrave;m thơ kh&ocirc;ng giống như những nh&agrave; thơ kh&aacute;c, ba năm.</p>	64000.00	2	Hồ Chí Minh	Văn học	2022	/images/img-1751710769408-849444714.png	print_book	\N	31	2025-07-05 17:19:29.413+07	2025-07-09 23:55:03.057+07	300
11	Đảo Giấu Vàng (Tái Bản)	ĐẢO GIẤU VÀNG\r\n\r\n \r\n\r\nRobert Louis Stevenson (1850-1894) là nhà văn người Scotland. Ông học ngành khoa học, đỗ kỹ sư, được huy chương bạc về một sáng kiến kỹ thuật. Nhưng đó chỉ là vốn kiến thức chung để giúp ông đi vào ngành mà trái tim ông đã chọn: viết văn. Stevenson được nhiều người mến phục vì tinh thần phấn đấu chống lại bệnh tật với sự vui vẻ và lòng can đảm. Ông cho ra đời nhiều tác phẩm văn học nổi tiếng, trong đó có tiểu thuyết Đảo giấu vàng.\r\n\r\n\r\n\r\nMột hòn đảo chơi vơi giữa biển, đêm ngày ầm ầm sóng vỗ, bỗng có một sức lôi cuốn kỳ diệu chỉ vì nó giấu trong lòng một kho vàng do băng cướp của viên thuyền trưởng Flint cất giấu. Ai sẽ đoạt được kho vàng, bọn cướp còn lại trong các băng của Flint hay là những người khác? Việc trước hết, có ý nghĩa quyết định là tìm ra được nơi Flint chôn giấu kho vàng, và tấm bản đồ chỉ nơi cất giấu lại tình cờ rơi vào tay chú thiếu niên nghèo, dũng cảm, thông minh hào hiệp, tên là Jim Haokinx. Câu chuyện phiêu lưu đến Đảo giấu vàng cũng bắt đầu từ đây...	57600.00	19	Robert Louis Stevenson	 NXB Văn học	2022	/images/img-1751456814918-394065603.png	print_book	\N	30	2025-06-23 17:43:52.797+07	2025-07-07 22:57:11.008+07	276
36	Phóng Sự Việc Làng - Ngô Tất Tố (Tái Bản)	<p style="text-align: center;"><span style="font-size: 18pt;"><strong>PH&Oacute;NG SỰ VIỆC L&Agrave;NG</strong></span></p>\r\n<p>&nbsp;</p>\r\n<p>Ra đời c&aacute;ch đ&acirc;y ba phần tư thế kỷ,&nbsp;<strong>Ph&oacute;ng sự Việc l&agrave;ng</strong>&nbsp;giới thiệu với bạn đọc, nhất l&agrave; thế hệ trẻ v&agrave; với độc giả ở c&aacute;c v&ugrave;ng miền kh&aacute;c trong cả nước ta về &ldquo;cuộc đời v&agrave; con người trong bức tranh l&agrave;ng qu&ecirc; Bắc Bộ&rdquo;.</p>\r\n<p>&nbsp;</p>\r\n<p><strong>Ph&oacute;ng sự Việc l&agrave;ng</strong>&nbsp;chứa đựng một khối lượng kiến thức s&acirc;u rộng, được ghi lại rất cụ thể, r&agrave;nh mạch, l&ocirc;i cuốn bạn đọc đi từ ngạc nhi&ecirc;n n&agrave;y đến bất ngờ kh&aacute;c rất chi tiết về bộ mặt n&ocirc;ng th&ocirc;n với h&agrave;ng loạt &ldquo;phong tục, hủ tục&rdquo; diễn ra li&ecirc;n mi&ecirc;n dai dẳng trong đời sống v&agrave; x&atilde; hội d&acirc;n qu&ecirc; c&aacute;ch đ&acirc;y non một thế kỉ.</p>\r\n<p>&nbsp;</p>\r\n<p><strong>Việc l&agrave;ng</strong>&nbsp;c&ograve;n thuật lại c&aacute;c &ldquo;phong tục&rdquo; c&oacute; &yacute; nghĩa tốt đẹp về &ldquo;sự gắn b&oacute; của d&acirc;n với l&agrave;ng&rdquo;, về tục &ldquo;v&agrave;o ng&ocirc;i&rdquo; khi con trẻ ra đời, về lễ nghi khi c&oacute; người qua đời, về lễ &ldquo;thượng điền&rdquo;, về nghệ thuật ẩm thực hoặc một số c&ocirc;ng việc cần c&ugrave; trong tập qu&aacute;n l&agrave;m l&uacute;a nước, chăn nu&ocirc;i gia cầm...</p>\r\n<p>&nbsp;</p>\r\n<p>Trải qua biết bao biến đổi,&nbsp;<strong>Việc l&agrave;ng</strong> vẫn c&ograve;n &yacute; nghĩa lớn v&agrave; để lại nhiều b&agrave;i học c&oacute; gi&aacute; trị trong qu&aacute; tr&igrave;nh chọn lọc, cải biến v&agrave; x&acirc;y dựng đời sống văn ho&aacute; mới trong x&atilde; hội n&ocirc;ng th&ocirc;n hiện nay.</p>	36000.00	0	Ngô Tất Tố	Văn học	2022	/images/img-1751904095995-278493498.png	print_book	\N	31	2025-07-07 23:01:36.001+07	2025-07-08 10:04:58.302+07	146
13	Hai Vạn Dặm Dưới Biển (Tái Bản)	Hai Vạn Dặm Dưới Biển\r\n\r\n \r\n\r\nJules Gabriel Verne (1828 - 1905), là nhà văn Pháp nổi tiếng, được coi là một trong những người “Cha đẻ” của thể loại NXB Văn Học Khoa học viễn tưởng. Ở Jules Verne, nhà văn và nhà bác học chỉ là một. Ông có kiến thức sâu rộng, có óc tưởng tượng vô cùng phong phú, có nhiều tư tưởng tiến bộ và là một tấm gương lao động sáng ngời. Ông đã để lại một di sản NXB Văn Học - khoa học lớn cả về số lượng và chất lượng: Từ trái đất lên mặt trăng (1865), Những đứa con của thuyền trưởng Grăng (1867), Hai vạn dặm dưới đáy biển (1869), Vòng quanh thế giới trong 80 ngày (1873)…\r\n\r\n\r\n\r\nHai vạn dặm dưới đáy biển là một trong những tác phẩm thành công nhất của Jules Verne. Rất nhiều năm đã qua, những hiểu biết mọi mặt của con người về biển đã tiến những bước dài. Nhiều khái niệm đã đổi thay về căn bản. Nhưng sự phát triển của khoa học, kỹ thuật không làm chúng ta giảm lòng yêu mến và kính phục Jules Verne, vì cuốn sách này đã góp phần hướng biết bao thanh thiếu niên tiến vào khoa học, và bao người sau này đã trở thành những nhà hải dương học, ngư học và chế tạo tàu ngầm!	81600.00	36	Jules Verne	NXB Văn học	2022	/images/img-1751456690531-648824653.png	print_book	\N	30	2025-06-23 17:45:10.092+07	2025-07-09 23:55:03.054+07	412
16	Tập Truyện Ngắn Chí Phèo - Nam Cao (Tái Bản) 	<h1><strong>TẬP TRUYỆN NGẮN CH&Iacute; PH&Egrave;O</strong></h1>\r\n<p>&nbsp;</p>\r\n<p><strong>T&aacute;c giả</strong></p>\r\n<p><strong>Nam Cao</strong>&nbsp;c&oacute; b&uacute;t danh l&agrave; Th&uacute;y Rư, Xu&acirc;n Du, Nguyệt, Nhi&ecirc;u Kh&ecirc;...</p>\r\n<p>T&ecirc;n khai sinh: Trần Hữu Tri, sinh ng&agrave;y 29 th&aacute;ng 10 năm 1917. Qu&ecirc; qu&aacute;n: l&agrave;ng Đại Ho&agrave;ng, phủ L&yacute; Nh&acirc;n, tỉnh H&agrave; Nam (nay l&agrave; x&atilde; H&ograve;a Hậu, huyện L&yacute; Nh&acirc;n, H&agrave; Nam). Đảng vi&ecirc;n Đảng Cộng sản Việt Nam.</p>\r\n<p>&nbsp;</p>\r\n<p>T&aacute;c phẩm đ&atilde; xuất bản: Đ&ocirc;i lứa xứng đ&ocirc;i (truyện ngắn, 1941); Nửa đ&ecirc;m (truyện ngắn, 1944); Cười (truyện ngắn, 1946), Ở rừng (nhật k&yacute;, 1948); Truyện bi&ecirc;n giới (1951); Đ&ocirc;i mắt(truyện ngắn, 1954); Sống m&ograve;n (truyện d&agrave;i, 1956); Ch&iacute; Ph&egrave;o (1957); Truyện ngắn Nam Cao (truyện ngắn, 1960); Một đ&aacute;m cưới (truyện ngắn, 1963); T&aacute;c phẩm Nam Cao (tuyển, 1964); Nam Cao t&aacute;c phẩm (tập I: 1976, tập II: 1977); Tuyển tập Nam Cao(tập I: 1987, tập II: 1993); Những c&aacute;nh hoa t&agrave;n (truyện ngắn, 1988); Nam Cao truyện ngắn tuyển chọn (1995); Nam Cao truyện ngắn (chọn lọc, 1996); Nam Cao to&agrave;n tập (1999).</p>\r\n<p>&nbsp;</p>\r\n<p>Ngo&agrave;i ra &ocirc;ng c&ograve;n l&agrave;m thơ, viết kịch (Đ&oacute;ng g&oacute;p, 1951) v&agrave; bi&ecirc;n soạn s&aacute;ch địa l&yacute; c&ugrave;ng với Văn T&acirc;n (Địa dư c&aacute;c nước ch&acirc;u &Acirc;u, 1948); Địa dư c&aacute;c nước ch&acirc;u &Aacute;, ch&acirc;u Phi, 1949; Địa dư Việt Nam, 1951.</p>\r\n<p>&nbsp;</p>\r\n<p><strong>T&aacute;c phẩm</strong></p>\r\n<p>&nbsp;</p>\r\n<p><img src="https://salt.tikicdn.com/ts/tmp/8c/0c/87/66b3ab80492b90a58c84206dae8c841a.jpg" width="581" height="581"></p>\r\n<p><em>Ch&iacute; Ph&egrave;o - Nam Cao</em></p>\r\n<p>&nbsp;</p>\r\n<p><strong>&ldquo;Ch&iacute; Ph&egrave;o&rdquo;&nbsp;</strong>&ndash; tập truyện ngắn t&aacute;i hiện bức tranh ch&acirc;n thực n&ocirc;ng th&ocirc;n Việt Nam trước 1945, ngh&egrave;o đ&oacute;i, xơ x&aacute;c tr&ecirc;n con đường ph&aacute; sản, bần c&ugrave;ng, hết sức th&ecirc; thảm, người n&ocirc;ng d&acirc;n bị đẩy v&agrave;o con đường tha h&oacute;a, lưu manh h&oacute;a.&nbsp;Nam Cao&nbsp;kh&ocirc;ng hề b&ocirc;i nhọ người n&ocirc;ng d&acirc;n, tr&aacute;i lại nh&agrave; văn đi s&acirc;u v&agrave;o nội t&acirc;m nh&acirc;n vật để khẳng định nh&acirc;n phẩm v&agrave; bản chất lương thiện ngay cả khi bị v&ugrave;i dập, cướp mất c&agrave; nh&acirc;n h&igrave;nh, nh&acirc;n t&iacute;nh của người n&ocirc;ng d&acirc;n, đồng thời kết &aacute;n đanh th&eacute;p c&aacute;i x&atilde; hội t&agrave;n bạo đ&oacute; trước 1945.</p>\r\n<p>&nbsp;</p>\r\n<p>Những s&aacute;ng t&aacute;c của Nam Cao ngo&agrave;i gi&aacute; trị hiện thực s&acirc;u sắc, c&aacute;c t&aacute;c phẩm đi s&acirc;u v&agrave;o nội t&acirc;m nh&acirc;n vật, để lại những cảm x&uacute;c s&acirc;u lắng trong l&ograve;ng người đọc.</p>	40000.00	35	Nam Cao	Văn học	2022	/images/img-1751456590962-319572284.png	print_book	\N	31	2025-06-23 17:47:39.049+07	2025-07-09 23:55:03.058+07	196
\.


--
-- TOC entry 5156 (class 0 OID 19344)
-- Dependencies: 250
-- Data for Name: promotions; Type: TABLE DATA; Schema: public; Owner: cuduc
--

COPY public.promotions (id, ma_khuyen_mai, mo_ta, loai_giam_gia, gia_tri_giam, dieu_kien_don_hang_toi_thieu, ngay_bat_dau, ngay_ket_thuc, so_luong_gioi_han, so_luong_da_su_dung, pham_vi_ap_dung, trang_thai, "createdAt", "updatedAt", danh_sach_id_ap_dung, giam_toi_da) FROM stdin;
1	MUNGDAILE	Giảm 15% cho tất cả đơn hàng mừng đại lễ 2/9	percentage	15.00	200000.00	2025-09-01 12:00:00+07	2025-09-02 23:59:00+07	10	0	all	t	2025-07-01 22:12:15.99+07	2025-07-09 15:52:34.582+07		100000.00
4	SALE7/7	Giảm 20k cho tất cả đơn hàng ngày 7/7	fixed_amount	20000.00	50000.00	2025-06-30 10:00:00+07	2025-07-14 23:59:00+07	10	9	all	t	2025-07-02 12:40:17.853+07	2025-07-09 23:55:03.06+07		20000.00
6	BOOKZONE	Giảm 20% cho tất cả đơn hàng ngày 14/7	percentage	20.00	350000.00	2025-07-01 00:00:00+07	2025-07-14 23:59:00+07	10	3	all	t	2025-07-07 23:06:54.219+07	2025-07-10 22:24:38.965+07		70000.00
9	BOOKZONE111	Giảm 15% cho tất cả đơn hàng mừng đại lễ 2/9	percentage	15.00	200000.00	2025-07-01 00:00:00+07	2025-07-08 23:59:00+07	10	1	all	t	2025-07-08 10:08:21.29+07	2025-07-08 10:09:28.97+07		50000.00
7	BOOKZONE12	Giảm 100% cho tất cả đơn hàng 	percentage	100.00	300000.00	2025-07-01 00:00:00+07	2025-07-30 23:59:00+07	10	0	all	t	2025-07-08 07:25:53.864+07	2025-07-09 15:52:21.172+07		\N
5	SALE5/7	Giảm 15% cho tất cả đơn hàng mừng đại lễ 2/9	percentage	15.00	200000.00	2025-07-05 18:00:00+07	2025-07-05 19:40:00+07	10	0	product	t	2025-07-05 17:35:55.837+07	2025-07-09 15:52:27.89+07	9,10,11,14	50000.00
\.


--
-- TOC entry 5164 (class 0 OID 19434)
-- Dependencies: 258
-- Data for Name: receipt_items; Type: TABLE DATA; Schema: public; Owner: cuduc
--

COPY public.receipt_items (id, receipt_id, product_id, so_luong_nhap, gia_nhap, chiet_khau, thanh_tien, "createdAt", "updatedAt") FROM stdin;
2	3	15	1	1000000.00	100000.00	900000.00	2025-06-26 23:45:20.282+07	2025-06-26 23:45:20.282+07
3	4	15	100	11000.00	0.00	1100000.00	2025-06-26 23:50:10.799+07	2025-06-26 23:50:10.799+07
4	5	15	1	10000.00	1000.00	9000.00	2025-06-27 00:13:33.286+07	2025-06-27 00:13:33.286+07
5	5	16	1	100000.00	10000.00	90000.00	2025-06-27 00:13:33.292+07	2025-06-27 00:13:33.292+07
6	6	14	20	10000.00	1000.00	180000.00	2025-06-27 00:52:14.775+07	2025-06-27 00:52:14.775+07
7	7	9	1	100000.00	10000.00	90000.00	2025-06-27 15:20:08.377+07	2025-06-27 15:20:08.377+07
8	7	8	1	100000.00	20000.00	80000.00	2025-06-27 15:20:08.383+07	2025-06-27 15:20:08.383+07
9	8	15	10	10000.00	0.00	100000.00	2025-06-29 15:49:22.188+07	2025-06-29 15:49:22.188+07
10	8	16	10	100000.00	0.00	1000000.00	2025-06-29 15:49:22.195+07	2025-06-29 15:49:22.195+07
11	8	13	10	81600.00	0.00	816000.00	2025-06-29 15:49:22.197+07	2025-06-29 15:49:22.197+07
12	9	11	10	57600.00	0.00	576000.00	2025-06-30 14:13:08.477+07	2025-06-30 14:13:08.477+07
13	9	9	10	76000.00	0.00	760000.00	2025-06-30 14:13:08.482+07	2025-06-30 14:13:08.482+07
14	9	8	10	133500.00	0.00	1335000.00	2025-06-30 14:13:08.484+07	2025-06-30 14:13:08.484+07
16	10	13	10	81600.00	0.00	816000.00	2025-06-30 14:14:24.578+07	2025-06-30 14:14:24.578+07
17	10	14	10	10000.00	0.00	100000.00	2025-06-30 14:14:24.581+07	2025-06-30 14:14:24.581+07
18	11	10	10	172500.00	0.00	1725000.00	2025-06-30 14:15:55.859+07	2025-06-30 14:15:55.859+07
19	11	8	10	133500.00	0.00	1335000.00	2025-06-30 14:15:55.862+07	2025-06-30 14:15:55.862+07
20	12	9	10	76000.00	0.00	760000.00	2025-06-30 14:16:16.825+07	2025-06-30 14:16:16.825+07
22	14	16	10	40000.00	0.00	400000.00	2025-07-02 22:01:28.83+07	2025-07-02 22:01:28.83+07
23	14	13	10	81600.00	0.00	816000.00	2025-07-02 22:01:28.837+07	2025-07-02 22:01:28.837+07
24	14	12	10	65000.00	0.00	650000.00	2025-07-02 22:01:28.84+07	2025-07-02 22:01:28.84+07
25	14	11	10	57600.00	0.00	576000.00	2025-07-02 22:01:28.841+07	2025-07-02 22:01:28.841+07
26	15	25	10	70000.00	14000.00	560000.00	2025-07-04 15:11:09.683+07	2025-07-04 15:11:09.683+07
27	15	9	10	76000.00	15200.00	608000.00	2025-07-04 15:11:09.697+07	2025-07-04 15:11:09.697+07
28	15	16	10	40000.00	16000.00	240000.00	2025-07-04 15:11:09.7+07	2025-07-04 15:11:09.7+07
29	16	22	10	52000.00	15600.00	364000.00	2025-07-04 15:12:30.538+07	2025-07-04 15:12:30.538+07
30	17	35	10	64000.00	6400.00	576000.00	2025-07-07 23:04:09.003+07	2025-07-07 23:04:09.003+07
31	17	34	10	48000.00	9600.00	384000.00	2025-07-07 23:04:09.007+07	2025-07-07 23:04:09.007+07
32	17	16	10	40000.00	4000.00	360000.00	2025-07-07 23:04:09.009+07	2025-07-07 23:04:09.009+07
33	18	15	100	68000.00	13600.00	5440000.00	2025-07-09 16:20:52.11+07	2025-07-09 16:20:52.11+07
\.


--
-- TOC entry 5162 (class 0 OID 19415)
-- Dependencies: 256
-- Data for Name: receipts; Type: TABLE DATA; Schema: public; Owner: cuduc
--

COPY public.receipts (id, user_id, ngay_nhap, tong_tien_phieu_nhap, ghi_chu, "createdAt", "updatedAt", ten_nha_cung_cap) FROM stdin;
3	1	2025-06-26 23:45:20.276+07	900000.00	hiiii	2025-06-26 23:45:20.276+07	2025-06-26 23:45:20.276+07	Minh Long Book
4	1	2025-06-26 23:50:10.797+07	1100000.00	hi	2025-06-26 23:50:10.797+07	2025-06-26 23:50:10.797+07	Minh Long Book
5	1	2025-06-27 00:13:33.278+07	99000.00	hi	2025-06-27 00:13:33.279+07	2025-06-27 00:13:33.279+07	Minh Long Book
6	1	2025-06-27 00:52:14.767+07	180000.00	hehe	2025-06-27 00:52:14.768+07	2025-06-27 00:52:14.768+07	Fahasa
7	1	2025-06-27 15:20:08.369+07	170000.00		2025-06-27 15:20:08.37+07	2025-06-27 15:20:08.37+07	Minh Long Book
8	1	2025-06-29 15:49:22.177+07	1916000.00		2025-06-29 15:49:22.177+07	2025-06-29 15:49:22.177+07	Minh Long Book
9	1	2025-06-30 14:13:08.467+07	3893220.00	hiii	2025-06-30 14:13:08.468+07	2025-06-30 14:13:08.468+07	Nhà Sách Phương Nam
10	1	2025-06-30 14:14:24.576+07	916000.00		2025-06-30 14:14:24.576+07	2025-06-30 14:14:24.576+07	Nhà Sách Phương Nam
11	1	2025-06-30 14:15:55.856+07	3060000.00	hi	2025-06-30 14:15:55.856+07	2025-06-30 14:15:55.856+07	Fahasa
12	1	2025-06-30 14:16:16.822+07	760000.00		2025-06-30 14:16:16.822+07	2025-06-30 14:16:16.822+07	Fahasa
13	1	2025-06-30 14:16:41.192+07	1111110.00		2025-06-30 14:16:41.192+07	2025-06-30 14:16:41.192+07	Fahasa
14	1	2025-07-02 22:01:28.824+07	2442000.00	hiiii	2025-07-02 22:01:28.824+07	2025-07-02 22:01:28.824+07	Fahasa
15	1	2025-07-04 15:11:09.673+07	1408000.00	hi	2025-07-04 15:11:09.673+07	2025-07-04 15:11:09.673+07	Minh Long Book
16	1	2025-07-04 15:12:30.533+07	364000.00	hi	2025-07-04 15:12:30.533+07	2025-07-04 15:12:30.533+07	Minh Long Book
17	1	2025-07-07 23:04:09.001+07	1320000.00		2025-07-07 23:04:09.001+07	2025-07-07 23:04:09.001+07	Minh Long Book
18	1	2025-07-09 16:20:52.107+07	5440000.00		2025-07-09 16:20:52.107+07	2025-07-09 16:20:52.107+07	Minh Long Book
\.


--
-- TOC entry 5158 (class 0 OID 19359)
-- Dependencies: 252
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: cuduc
--

COPY public.reviews (id, user_id, product_id, rating, comment, parent_id, "createdAt", "updatedAt") FROM stdin;
1	7	16	5	truyện hay xứng đáng 5s	\N	2025-07-05 12:35:13.743+07	2025-07-05 12:35:13.743+07
\.


--
-- TOC entry 5134 (class 0 OID 19177)
-- Dependencies: 228
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: cuduc
--

COPY public.roles (id, ten_quyen, "createdAt", "updatedAt") FROM stdin;
1	admin	2025-06-19 16:02:51.272+07	2025-06-19 16:02:51.272+07
2	user	2025-06-19 16:02:51.272+07	2025-06-19 16:02:51.272+07
\.


--
-- TOC entry 5160 (class 0 OID 19383)
-- Dependencies: 254
-- Data for Name: slideshows; Type: TABLE DATA; Schema: public; Owner: cuduc
--

COPY public.slideshows (id, image_url, tieu_de, phu_de, link_to, thu_tu_hien_thi, trang_thai, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 5136 (class 0 OID 19186)
-- Dependencies: 230
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: cuduc
--

COPY public.users (id, ten_dang_nhap, email, mat_khau, ho_ten, phone, img, dia_chi, trang_thai, "createdAt", "updatedAt", "resetPasswordToken", "resetPasswordExpire", role_id) FROM stdin;
2	tranduc1221	tranduc123@gmail.com	$2b$10$uw9JqjgJFsQUegaZHL6EZepydfC//7jkCmI6bFPEiyxmfZJTIi9rO	Trần Anh Đức	\N	\N	\N	t	2025-06-20 13:27:54.017+07	2025-06-27 00:02:36.897+07	\N	\N	2
5	trananhtai1221	trantai123@gmail.com	$2b$10$j885dJmsLHSiXvZ/CiHIceoI44h7W7.38VOj0tECnXVgPXGLeDdau	Trần Anh Tài 	\N	\N	\N	t	2025-06-23 19:21:00.728+07	2025-06-29 14:23:16.683+07	\N	\N	2
1	admin	admin@bookstore.com	$2b$10$hf9Ek9E12yEvYceyKPv/a.TZsYSrybScHO7fWiZ1vug5FmzUaaBNK	Admin Master	\N	\N	\N	t	2025-06-19 16:02:51.285+07	2025-06-19 16:02:51.285+07	\N	\N	1
7	tranduc	tranhduc1001@gmail.com	$2b$10$2bE3Okofiku9pWcZo8rE6esf2Gr6.FnGQpIpwbk2g.Cd8DtFxjeJq	Trần Đức	0339952573	\N	158 Lê Hồng Phong	t	2025-06-29 14:49:13.178+07	2025-07-07 22:54:38.008+07	\N	\N	2
\.


--
-- TOC entry 5203 (class 0 OID 0)
-- Dependencies: 237
-- Name: cart_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cuduc
--

SELECT pg_catalog.setval('public.cart_items_id_seq', 168, true);


--
-- TOC entry 5204 (class 0 OID 0)
-- Dependencies: 231
-- Name: carts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cuduc
--

SELECT pg_catalog.setval('public.carts_id_seq', 4, true);


--
-- TOC entry 5205 (class 0 OID 0)
-- Dependencies: 233
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cuduc
--

SELECT pg_catalog.setval('public.categories_id_seq', 41, true);


--
-- TOC entry 5206 (class 0 OID 0)
-- Dependencies: 239
-- Name: combo_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cuduc
--

SELECT pg_catalog.setval('public.combo_items_id_seq', 1, false);


--
-- TOC entry 5207 (class 0 OID 0)
-- Dependencies: 241
-- Name: combos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cuduc
--

SELECT pg_catalog.setval('public.combos_id_seq', 1, false);


--
-- TOC entry 5208 (class 0 OID 0)
-- Dependencies: 243
-- Name: ebook_download_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cuduc
--

SELECT pg_catalog.setval('public.ebook_download_links_id_seq', 1, false);


--
-- TOC entry 5209 (class 0 OID 0)
-- Dependencies: 245
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cuduc
--

SELECT pg_catalog.setval('public.order_items_id_seq', 107, true);


--
-- TOC entry 5210 (class 0 OID 0)
-- Dependencies: 247
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cuduc
--

SELECT pg_catalog.setval('public.orders_id_seq', 41, true);


--
-- TOC entry 5211 (class 0 OID 0)
-- Dependencies: 259
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cuduc
--

SELECT pg_catalog.setval('public.posts_id_seq', 1, false);


--
-- TOC entry 5212 (class 0 OID 0)
-- Dependencies: 235
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cuduc
--

SELECT pg_catalog.setval('public.products_id_seq', 36, true);


--
-- TOC entry 5213 (class 0 OID 0)
-- Dependencies: 249
-- Name: promotions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cuduc
--

SELECT pg_catalog.setval('public.promotions_id_seq', 9, true);


--
-- TOC entry 5214 (class 0 OID 0)
-- Dependencies: 257
-- Name: receipt_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cuduc
--

SELECT pg_catalog.setval('public.receipt_items_id_seq', 33, true);


--
-- TOC entry 5215 (class 0 OID 0)
-- Dependencies: 255
-- Name: receipts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cuduc
--

SELECT pg_catalog.setval('public.receipts_id_seq', 18, true);


--
-- TOC entry 5216 (class 0 OID 0)
-- Dependencies: 251
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cuduc
--

SELECT pg_catalog.setval('public.reviews_id_seq', 1, true);


--
-- TOC entry 5217 (class 0 OID 0)
-- Dependencies: 227
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cuduc
--

SELECT pg_catalog.setval('public.roles_id_seq', 1, false);


--
-- TOC entry 5218 (class 0 OID 0)
-- Dependencies: 253
-- Name: slideshows_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cuduc
--

SELECT pg_catalog.setval('public.slideshows_id_seq', 1, false);


--
-- TOC entry 5219 (class 0 OID 0)
-- Dependencies: 229
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cuduc
--

SELECT pg_catalog.setval('public.users_id_seq', 7, true);


--
-- TOC entry 4906 (class 2606 OID 19256)
-- Name: cart_items cart_items_pkey; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_pkey PRIMARY KEY (id);


--
-- TOC entry 4898 (class 2606 OID 19211)
-- Name: carts carts_pkey; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (id);


--
-- TOC entry 4900 (class 2606 OID 19213)
-- Name: carts carts_user_id_key; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_user_id_key UNIQUE (user_id);


--
-- TOC entry 4902 (class 2606 OID 19227)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 4908 (class 2606 OID 19273)
-- Name: combo_items combo_items_pkey; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.combo_items
    ADD CONSTRAINT combo_items_pkey PRIMARY KEY (id);


--
-- TOC entry 4910 (class 2606 OID 19283)
-- Name: combos combos_pkey; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.combos
    ADD CONSTRAINT combos_pkey PRIMARY KEY (id);


--
-- TOC entry 4912 (class 2606 OID 21802)
-- Name: ebook_download_links ebook_download_links_download_token_key; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.ebook_download_links
    ADD CONSTRAINT ebook_download_links_download_token_key UNIQUE (download_token);


--
-- TOC entry 4914 (class 2606 OID 21804)
-- Name: ebook_download_links ebook_download_links_download_token_key1; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.ebook_download_links
    ADD CONSTRAINT ebook_download_links_download_token_key1 UNIQUE (download_token);


--
-- TOC entry 4916 (class 2606 OID 21806)
-- Name: ebook_download_links ebook_download_links_download_token_key2; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.ebook_download_links
    ADD CONSTRAINT ebook_download_links_download_token_key2 UNIQUE (download_token);


--
-- TOC entry 4918 (class 2606 OID 21808)
-- Name: ebook_download_links ebook_download_links_download_token_key3; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.ebook_download_links
    ADD CONSTRAINT ebook_download_links_download_token_key3 UNIQUE (download_token);


--
-- TOC entry 4920 (class 2606 OID 21810)
-- Name: ebook_download_links ebook_download_links_download_token_key4; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.ebook_download_links
    ADD CONSTRAINT ebook_download_links_download_token_key4 UNIQUE (download_token);


--
-- TOC entry 4922 (class 2606 OID 21800)
-- Name: ebook_download_links ebook_download_links_download_token_key5; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.ebook_download_links
    ADD CONSTRAINT ebook_download_links_download_token_key5 UNIQUE (download_token);


--
-- TOC entry 4924 (class 2606 OID 21812)
-- Name: ebook_download_links ebook_download_links_download_token_key6; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.ebook_download_links
    ADD CONSTRAINT ebook_download_links_download_token_key6 UNIQUE (download_token);


--
-- TOC entry 4926 (class 2606 OID 21814)
-- Name: ebook_download_links ebook_download_links_download_token_key7; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.ebook_download_links
    ADD CONSTRAINT ebook_download_links_download_token_key7 UNIQUE (download_token);


--
-- TOC entry 4928 (class 2606 OID 21798)
-- Name: ebook_download_links ebook_download_links_download_token_key8; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.ebook_download_links
    ADD CONSTRAINT ebook_download_links_download_token_key8 UNIQUE (download_token);


--
-- TOC entry 4930 (class 2606 OID 21816)
-- Name: ebook_download_links ebook_download_links_download_token_key9; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.ebook_download_links
    ADD CONSTRAINT ebook_download_links_download_token_key9 UNIQUE (download_token);


--
-- TOC entry 4932 (class 2606 OID 19291)
-- Name: ebook_download_links ebook_download_links_pkey; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.ebook_download_links
    ADD CONSTRAINT ebook_download_links_pkey PRIMARY KEY (id);


--
-- TOC entry 4934 (class 2606 OID 19300)
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- TOC entry 4936 (class 2606 OID 19328)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- TOC entry 4964 (class 2606 OID 20820)
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- TOC entry 4966 (class 2606 OID 21847)
-- Name: posts posts_slug_key; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_slug_key UNIQUE (slug);


--
-- TOC entry 4968 (class 2606 OID 21849)
-- Name: posts posts_slug_key1; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_slug_key1 UNIQUE (slug);


--
-- TOC entry 4970 (class 2606 OID 21845)
-- Name: posts posts_slug_key2; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_slug_key2 UNIQUE (slug);


--
-- TOC entry 4972 (class 2606 OID 21851)
-- Name: posts posts_slug_key3; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_slug_key3 UNIQUE (slug);


--
-- TOC entry 4904 (class 2606 OID 19243)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- TOC entry 4938 (class 2606 OID 21863)
-- Name: promotions promotions_ma_khuyen_mai_key; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.promotions
    ADD CONSTRAINT promotions_ma_khuyen_mai_key UNIQUE (ma_khuyen_mai);


--
-- TOC entry 4940 (class 2606 OID 21865)
-- Name: promotions promotions_ma_khuyen_mai_key1; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.promotions
    ADD CONSTRAINT promotions_ma_khuyen_mai_key1 UNIQUE (ma_khuyen_mai);


--
-- TOC entry 4942 (class 2606 OID 21861)
-- Name: promotions promotions_ma_khuyen_mai_key2; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.promotions
    ADD CONSTRAINT promotions_ma_khuyen_mai_key2 UNIQUE (ma_khuyen_mai);


--
-- TOC entry 4944 (class 2606 OID 21859)
-- Name: promotions promotions_ma_khuyen_mai_key3; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.promotions
    ADD CONSTRAINT promotions_ma_khuyen_mai_key3 UNIQUE (ma_khuyen_mai);


--
-- TOC entry 4946 (class 2606 OID 21867)
-- Name: promotions promotions_ma_khuyen_mai_key4; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.promotions
    ADD CONSTRAINT promotions_ma_khuyen_mai_key4 UNIQUE (ma_khuyen_mai);


--
-- TOC entry 4948 (class 2606 OID 21869)
-- Name: promotions promotions_ma_khuyen_mai_key5; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.promotions
    ADD CONSTRAINT promotions_ma_khuyen_mai_key5 UNIQUE (ma_khuyen_mai);


--
-- TOC entry 4950 (class 2606 OID 21857)
-- Name: promotions promotions_ma_khuyen_mai_key6; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.promotions
    ADD CONSTRAINT promotions_ma_khuyen_mai_key6 UNIQUE (ma_khuyen_mai);


--
-- TOC entry 4952 (class 2606 OID 21871)
-- Name: promotions promotions_ma_khuyen_mai_key7; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.promotions
    ADD CONSTRAINT promotions_ma_khuyen_mai_key7 UNIQUE (ma_khuyen_mai);


--
-- TOC entry 4954 (class 2606 OID 19355)
-- Name: promotions promotions_pkey; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.promotions
    ADD CONSTRAINT promotions_pkey PRIMARY KEY (id);


--
-- TOC entry 4962 (class 2606 OID 19441)
-- Name: receipt_items receipt_items_pkey; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.receipt_items
    ADD CONSTRAINT receipt_items_pkey PRIMARY KEY (id);


--
-- TOC entry 4960 (class 2606 OID 19422)
-- Name: receipts receipts_pkey; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.receipts
    ADD CONSTRAINT receipts_pkey PRIMARY KEY (id);


--
-- TOC entry 4956 (class 2606 OID 19366)
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- TOC entry 4778 (class 2606 OID 19182)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 4780 (class 2606 OID 21645)
-- Name: roles roles_ten_quyen_key; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_ten_quyen_key UNIQUE (ten_quyen);


--
-- TOC entry 4782 (class 2606 OID 21647)
-- Name: roles roles_ten_quyen_key1; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_ten_quyen_key1 UNIQUE (ten_quyen);


--
-- TOC entry 4784 (class 2606 OID 21665)
-- Name: roles roles_ten_quyen_key10; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_ten_quyen_key10 UNIQUE (ten_quyen);


--
-- TOC entry 4786 (class 2606 OID 21667)
-- Name: roles roles_ten_quyen_key11; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_ten_quyen_key11 UNIQUE (ten_quyen);


--
-- TOC entry 4788 (class 2606 OID 21669)
-- Name: roles roles_ten_quyen_key12; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_ten_quyen_key12 UNIQUE (ten_quyen);


--
-- TOC entry 4790 (class 2606 OID 21643)
-- Name: roles roles_ten_quyen_key13; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_ten_quyen_key13 UNIQUE (ten_quyen);


--
-- TOC entry 4792 (class 2606 OID 21671)
-- Name: roles roles_ten_quyen_key14; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_ten_quyen_key14 UNIQUE (ten_quyen);


--
-- TOC entry 4794 (class 2606 OID 21673)
-- Name: roles roles_ten_quyen_key15; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_ten_quyen_key15 UNIQUE (ten_quyen);


--
-- TOC entry 4796 (class 2606 OID 21641)
-- Name: roles roles_ten_quyen_key16; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_ten_quyen_key16 UNIQUE (ten_quyen);


--
-- TOC entry 4798 (class 2606 OID 21639)
-- Name: roles roles_ten_quyen_key17; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_ten_quyen_key17 UNIQUE (ten_quyen);


--
-- TOC entry 4800 (class 2606 OID 21675)
-- Name: roles roles_ten_quyen_key18; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_ten_quyen_key18 UNIQUE (ten_quyen);


--
-- TOC entry 4802 (class 2606 OID 21637)
-- Name: roles roles_ten_quyen_key19; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_ten_quyen_key19 UNIQUE (ten_quyen);


--
-- TOC entry 4804 (class 2606 OID 21649)
-- Name: roles roles_ten_quyen_key2; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_ten_quyen_key2 UNIQUE (ten_quyen);


--
-- TOC entry 4806 (class 2606 OID 21677)
-- Name: roles roles_ten_quyen_key20; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_ten_quyen_key20 UNIQUE (ten_quyen);


--
-- TOC entry 4808 (class 2606 OID 21635)
-- Name: roles roles_ten_quyen_key21; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_ten_quyen_key21 UNIQUE (ten_quyen);


--
-- TOC entry 4810 (class 2606 OID 21679)
-- Name: roles roles_ten_quyen_key22; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_ten_quyen_key22 UNIQUE (ten_quyen);


--
-- TOC entry 4812 (class 2606 OID 21681)
-- Name: roles roles_ten_quyen_key23; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_ten_quyen_key23 UNIQUE (ten_quyen);


--
-- TOC entry 4814 (class 2606 OID 21651)
-- Name: roles roles_ten_quyen_key3; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_ten_quyen_key3 UNIQUE (ten_quyen);


--
-- TOC entry 4816 (class 2606 OID 21653)
-- Name: roles roles_ten_quyen_key4; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_ten_quyen_key4 UNIQUE (ten_quyen);


--
-- TOC entry 4818 (class 2606 OID 21655)
-- Name: roles roles_ten_quyen_key5; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_ten_quyen_key5 UNIQUE (ten_quyen);


--
-- TOC entry 4820 (class 2606 OID 21657)
-- Name: roles roles_ten_quyen_key6; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_ten_quyen_key6 UNIQUE (ten_quyen);


--
-- TOC entry 4822 (class 2606 OID 21659)
-- Name: roles roles_ten_quyen_key7; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_ten_quyen_key7 UNIQUE (ten_quyen);


--
-- TOC entry 4824 (class 2606 OID 21661)
-- Name: roles roles_ten_quyen_key8; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_ten_quyen_key8 UNIQUE (ten_quyen);


--
-- TOC entry 4826 (class 2606 OID 21663)
-- Name: roles roles_ten_quyen_key9; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_ten_quyen_key9 UNIQUE (ten_quyen);


--
-- TOC entry 4958 (class 2606 OID 19392)
-- Name: slideshows slideshows_pkey; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.slideshows
    ADD CONSTRAINT slideshows_pkey PRIMARY KEY (id);


--
-- TOC entry 4828 (class 2606 OID 21733)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4830 (class 2606 OID 21735)
-- Name: users users_email_key1; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key1 UNIQUE (email);


--
-- TOC entry 4832 (class 2606 OID 21729)
-- Name: users users_email_key10; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key10 UNIQUE (email);


--
-- TOC entry 4834 (class 2606 OID 21751)
-- Name: users users_email_key11; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key11 UNIQUE (email);


--
-- TOC entry 4836 (class 2606 OID 21753)
-- Name: users users_email_key12; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key12 UNIQUE (email);


--
-- TOC entry 4838 (class 2606 OID 21755)
-- Name: users users_email_key13; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key13 UNIQUE (email);


--
-- TOC entry 4840 (class 2606 OID 21727)
-- Name: users users_email_key14; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key14 UNIQUE (email);


--
-- TOC entry 4842 (class 2606 OID 21757)
-- Name: users users_email_key15; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key15 UNIQUE (email);


--
-- TOC entry 4844 (class 2606 OID 21759)
-- Name: users users_email_key16; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key16 UNIQUE (email);


--
-- TOC entry 4846 (class 2606 OID 21737)
-- Name: users users_email_key2; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key2 UNIQUE (email);


--
-- TOC entry 4848 (class 2606 OID 21739)
-- Name: users users_email_key3; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key3 UNIQUE (email);


--
-- TOC entry 4850 (class 2606 OID 21741)
-- Name: users users_email_key4; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key4 UNIQUE (email);


--
-- TOC entry 4852 (class 2606 OID 21743)
-- Name: users users_email_key5; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key5 UNIQUE (email);


--
-- TOC entry 4854 (class 2606 OID 21731)
-- Name: users users_email_key6; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key6 UNIQUE (email);


--
-- TOC entry 4856 (class 2606 OID 21745)
-- Name: users users_email_key7; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key7 UNIQUE (email);


--
-- TOC entry 4858 (class 2606 OID 21747)
-- Name: users users_email_key8; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key8 UNIQUE (email);


--
-- TOC entry 4860 (class 2606 OID 21749)
-- Name: users users_email_key9; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key9 UNIQUE (email);


--
-- TOC entry 4862 (class 2606 OID 19195)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4864 (class 2606 OID 21701)
-- Name: users users_ten_dang_nhap_key; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_ten_dang_nhap_key UNIQUE (ten_dang_nhap);


--
-- TOC entry 4866 (class 2606 OID 21703)
-- Name: users users_ten_dang_nhap_key1; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_ten_dang_nhap_key1 UNIQUE (ten_dang_nhap);


--
-- TOC entry 4868 (class 2606 OID 21695)
-- Name: users users_ten_dang_nhap_key10; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_ten_dang_nhap_key10 UNIQUE (ten_dang_nhap);


--
-- TOC entry 4870 (class 2606 OID 21717)
-- Name: users users_ten_dang_nhap_key11; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_ten_dang_nhap_key11 UNIQUE (ten_dang_nhap);


--
-- TOC entry 4872 (class 2606 OID 21693)
-- Name: users users_ten_dang_nhap_key12; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_ten_dang_nhap_key12 UNIQUE (ten_dang_nhap);


--
-- TOC entry 4874 (class 2606 OID 21719)
-- Name: users users_ten_dang_nhap_key13; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_ten_dang_nhap_key13 UNIQUE (ten_dang_nhap);


--
-- TOC entry 4876 (class 2606 OID 21691)
-- Name: users users_ten_dang_nhap_key14; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_ten_dang_nhap_key14 UNIQUE (ten_dang_nhap);


--
-- TOC entry 4878 (class 2606 OID 21721)
-- Name: users users_ten_dang_nhap_key15; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_ten_dang_nhap_key15 UNIQUE (ten_dang_nhap);


--
-- TOC entry 4880 (class 2606 OID 21723)
-- Name: users users_ten_dang_nhap_key16; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_ten_dang_nhap_key16 UNIQUE (ten_dang_nhap);


--
-- TOC entry 4882 (class 2606 OID 21705)
-- Name: users users_ten_dang_nhap_key2; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_ten_dang_nhap_key2 UNIQUE (ten_dang_nhap);


--
-- TOC entry 4884 (class 2606 OID 21707)
-- Name: users users_ten_dang_nhap_key3; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_ten_dang_nhap_key3 UNIQUE (ten_dang_nhap);


--
-- TOC entry 4886 (class 2606 OID 21709)
-- Name: users users_ten_dang_nhap_key4; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_ten_dang_nhap_key4 UNIQUE (ten_dang_nhap);


--
-- TOC entry 4888 (class 2606 OID 21711)
-- Name: users users_ten_dang_nhap_key5; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_ten_dang_nhap_key5 UNIQUE (ten_dang_nhap);


--
-- TOC entry 4890 (class 2606 OID 21699)
-- Name: users users_ten_dang_nhap_key6; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_ten_dang_nhap_key6 UNIQUE (ten_dang_nhap);


--
-- TOC entry 4892 (class 2606 OID 21713)
-- Name: users users_ten_dang_nhap_key7; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_ten_dang_nhap_key7 UNIQUE (ten_dang_nhap);


--
-- TOC entry 4894 (class 2606 OID 21697)
-- Name: users users_ten_dang_nhap_key8; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_ten_dang_nhap_key8 UNIQUE (ten_dang_nhap);


--
-- TOC entry 4896 (class 2606 OID 21715)
-- Name: users users_ten_dang_nhap_key9; Type: CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_ten_dang_nhap_key9 UNIQUE (ten_dang_nhap);


--
-- TOC entry 4977 (class 2606 OID 21781)
-- Name: cart_items cart_items_cart_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_cart_id_fkey FOREIGN KEY (cart_id) REFERENCES public.carts(id) ON UPDATE CASCADE;


--
-- TOC entry 4978 (class 2606 OID 21786)
-- Name: cart_items cart_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE;


--
-- TOC entry 4974 (class 2606 OID 21762)
-- Name: carts carts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE;


--
-- TOC entry 4975 (class 2606 OID 21767)
-- Name: categories categories_danh_muc_cha_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_danh_muc_cha_id_fkey FOREIGN KEY (danh_muc_cha_id) REFERENCES public.categories(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 4979 (class 2606 OID 21832)
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4980 (class 2606 OID 21837)
-- Name: order_items order_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 4981 (class 2606 OID 21819)
-- Name: orders orders_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 4976 (class 2606 OID 21776)
-- Name: products products_danh_muc_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_danh_muc_id_fkey FOREIGN KEY (danh_muc_id) REFERENCES public.categories(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4986 (class 2606 OID 21890)
-- Name: receipt_items receipt_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.receipt_items
    ADD CONSTRAINT receipt_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4987 (class 2606 OID 21885)
-- Name: receipt_items receipt_items_receipt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.receipt_items
    ADD CONSTRAINT receipt_items_receipt_id_fkey FOREIGN KEY (receipt_id) REFERENCES public.receipts(id) ON UPDATE CASCADE;


--
-- TOC entry 4985 (class 2606 OID 21880)
-- Name: receipts receipts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.receipts
    ADD CONSTRAINT receipts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE;


--
-- TOC entry 4982 (class 2606 OID 21909)
-- Name: reviews reviews_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.reviews(id);


--
-- TOC entry 4983 (class 2606 OID 21904)
-- Name: reviews reviews_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4984 (class 2606 OID 21899)
-- Name: reviews reviews_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE;


--
-- TOC entry 4973 (class 2606 OID 21683)
-- Name: users users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cuduc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2025-07-10 22:57:54

--
-- PostgreSQL database dump complete
--

