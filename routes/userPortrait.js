// routes/userPortraitRoutes.js  
import express from 'express';  
import userPortraitController from '../controllers/userPortraitController.js';  

const router = express.Router();  
 
router.post('/add', userPortraitController.addUserPortrait);  
router.get('/get', userPortraitController.getUserPortrait);  
router.put('/update', userPortraitController.updateUserPortrait);    
router.delete('/delete', userPortraitController.deleteUserPortrait);  

export default router;