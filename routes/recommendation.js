import express from 'express';  
import recommendationController from '../controllers/recommendationController.js';  

const router = express.Router();  

router.post('/add', recommendationController.addRecommendation);  
router.put('/update', recommendationController.updateRecommendation);  
router.delete('/delete', recommendationController.deleteRecommendation);  
router.get('/getById', recommendationController.getRecommendationsById);  
router.post('/getByUser', recommendationController.getRecommendationsByUserId);  

export default router;