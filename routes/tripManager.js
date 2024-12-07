import express from 'express';
import { tripController, dailyTripController, activityController } from '../controllers/tripManagerController.js';  
const router = express.Router();  

router.post('/add', tripController.addTripManage);   
router.delete('/delete', tripController.deleteTripManage); 
router.post('/get', tripController.getTripManageByUserId); 
router.put('/update', tripController.updateTripManage); 
 
router.post('/dailytrips/add', dailyTripController.addDailyTrip);   
router.delete('/dailytrips/delete', dailyTripController.deleteDailyTrip); 
router.post('/dailytrips/get', dailyTripController.getDailyTripByPlanId);  
router.put('/dailytrips/update', dailyTripController.updateDailyTrip); 

router.post('/dailytrips/activities/add', activityController.addActivity);   
router.delete('/dailytrips/activities/delete', activityController.deleteActivity);   
router.post('/dailytrips/activities/get', activityController.getActivitiesByDay);
router.put('/dailytrips/activities/update', activityController.updateActivity);   

export default router;