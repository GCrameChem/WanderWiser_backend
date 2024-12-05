// 用户注册与登录路由文件

import express from 'express';
const router = express.Router();
import userController from '../controllers/userAccountController.js';

// 接口列表
router.post('/register', userController.register);

router.post('/login', userController.login);

// Route to get all users (for admin testing)
router.get('/get', userController.getAllUsers);

router.delete('/delete', userController.deleteUser);

export default router;
