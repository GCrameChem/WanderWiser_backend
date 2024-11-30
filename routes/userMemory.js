import express from 'express';  
import userMemoryController from '../controllers/userMemoryController.js';  

const router = express.Router();  

router.post('/add', userMemoryController.addUserMemory);  
router.put('/update', userMemoryController.updateUserMemory);  
router.delete('/delete', userMemoryController.deleteUserMemory);  
router.post('/getById', userMemoryController.getUserMemoriesById);
router.post('/getByUser', userMemoryController.getUserMemoriesByUserId);  

export default router;