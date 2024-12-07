//地图及路径显示路由
import express from 'express';
const router = express.Router();
import mapController from '../controllers/mapController.js';

router.get('/map1', mapController.showMap1);
router.get('/map2', mapController.showMap2);
router.get('/path', mapController.showPath);

export default router;
