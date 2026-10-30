import { Routes, Route, Navigate } from 'react-router-dom';
import MainLayout from '../layouts/MainLayout';
import AdminLayout from '../layouts/AdminLayout';

import Home from '../pages/Home';
import Shop from '../pages/Shop';
import Category from '../pages/Category';
import ProductDetails from '../pages/ProductDetails';
import SearchResults from '../pages/SearchResults';
import Cart from '../pages/Cart';
import Wishlist from '../pages/Wishlist';
import Checkout from '../pages/Checkout';
import OrderSuccess from '../pages/OrderSuccess';
import Orders from '../pages/Orders';
import Login from '../pages/Login';
import Register from '../pages/Register';
import ForgotPassword from '../pages/ForgotPassword';
import ResetPassword from '../pages/ResetPassword';
import Profile from '../pages/Profile';
import InformationPage from '../pages/InformationPage';
import Gifting from '../pages/Gifting';

import AdminLogin from '../pages/admin/AdminLogin';
import Dashboard from '../pages/admin/Dashboard';
import AdminProducts from '../pages/admin/Products';
import AddProduct from '../pages/admin/AddProduct';
import EditProduct from '../pages/admin/EditProduct';
import AdminCategories from '../pages/admin/Categories';
import AdminOrders from '../pages/admin/Orders';
import AdminUsers from '../pages/admin/Users';

export default function AppRoutes() {
  return (
    <Routes>
      {/* Storefront Layout */}
      <Route element={<MainLayout />}>
        <Route path="/" element={<Home />} />
        <Route path="/shop" element={<Shop />} />
        <Route path="/bags" element={<Shop />} />
        <Route path="/bags/cp" element={<Shop />} />
        <Route path="/gifting" element={<Gifting />} />
        <Route path="/category/:slug" element={<Category />} />
        <Route path="/product/:slug" element={<ProductDetails />} />
        <Route path="/search" element={<SearchResults />} />
        <Route path="/cart" element={<Cart />} />
        <Route path="/wishlist" element={<Wishlist />} />
        <Route path="/checkout" element={<Checkout />} />
        <Route path="/order-success" element={<OrderSuccess />} />
        <Route path="/orders" element={<Orders />} />
        <Route path="/login" element={<Login />} />
        <Route path="/register" element={<Register />} />
        <Route path="/forgot-password" element={<ForgotPassword />} />
        <Route path="/reset-password" element={<ResetPassword />} />
        <Route path="/profile" element={<Profile />} />
        <Route path="/pages/:slug" element={<InformationPage />} />
      </Route>

      {/* Admin Portal Authentication */}
      <Route path="/admin/login" element={<AdminLogin />} />

      {/* Protected Admin Console */}
      <Route path="/admin" element={<AdminLayout />}>
        <Route index element={<Navigate to="/admin/dashboard" replace />} />
        <Route path="dashboard" element={<Dashboard />} />
        <Route path="products" element={<AdminProducts />} />
        <Route path="products/new" element={<AddProduct />} />
        <Route path="products/:id/edit" element={<EditProduct />} />
        <Route path="categories" element={<AdminCategories />} />
        <Route path="orders" element={<AdminOrders />} />
        <Route path="users" element={<AdminUsers />} />
      </Route>

      {/* Catch-all redirect */}
      <Route path="*" element={<Navigate to="/" replace />} />
    </Routes>
  );
}
