import express from 'express';
import { tripController, dailyTripController, activityController } from '../controllers/tripManagerController.js';  
const router = express.Router();  

router.post('/add', tripController.addTripManage);   
router.delete('/delete', tripController.deleteTripManage); 
router.post('/getByUid', tripController.getTripManageByUserId); 
router.post('/getByUid_Pid', tripController.getTripManageByUId_PId); 
router.put('/update', tripController.updateTripManage); 
router.post('/getTripMD', tripController.getTripManageMarkdown);
router.post('/getDailyMD', tripController.getDailyTripMarkdown);
 
router.post('/dailytrips/add', dailyTripController.addDailyTrip);   
router.delete('/dailytrips/delete', dailyTripController.deleteDailyTrip); 
router.post('/dailytrips/getByPid', dailyTripController.getDailyTripByPlanId);  
router.post('/dailytrips/getByPid_Day', dailyTripController.getDailyTripByPId_Day); 
router.put('/dailytrips/update', dailyTripController.updateDailyTrip); 

router.post('/dailytrips/activities/add', activityController.addActivity);   
router.delete('/dailytrips/activities/delete', activityController.deleteActivity);   
router.post('/dailytrips/activities/get', activityController.getActivitiesByDay);
router.put('/dailytrips/activities/update', activityController.updateActivity);   

export default router;