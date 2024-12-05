// 用户行程管理的控制器  
import { executeQuery } from '../config/dbconfig.js';
import { v4 as uuidv4 } from 'uuid';

const tripController = {  

  //增加新的行程到 tripmanage  
  addTripManage: async (req, res) => {  
    const { user_id, plan_name, date, weather, keywords, summary, accomodation } = req.body; 
    // 分配planId，使用唯一标识符库
    const plan_id = uuidv4();
    // 输入验证  
    if (!user_id) {  
      return res.status(400).json({ error: 'user_id is required' });  
    }  

    try {  
      const sql = `  
        INSERT INTO tripmanage (plan_id, user_id, plan_name, date, weather, keywords, summary, accomodation)  
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)`;  
      await executeQuery(sql, [plan_id, user_id, plan_name, date, weather, keywords, summary, accomodation]); 
      res.send({
        message: 'Trip added successfully',
        data: {  
          plan_id,  
          // 可以添加其他需要返回给前端的字段  
        }, 
        code: 200,
      }) 
    } catch (error) {  
      console.error('Database error:', error);  
      res.status(500).json({ error: 'Internal Server Error' });  
    }  
  },  

  // 功能6: 删除行程  
  deleteTripManage: async (req, res) => {  
    const { plan_id } = req.body;  

    // 输入验证  
    if (!plan_id) {  
      return res.status(400).json({ error: 'plan_id is required' });  
    }  

    try {  
      const sql = 'DELETE FROM tripmanage WHERE plan_id = ?';  
      await executeQuery(sql, [plan_id]);  
      res.status(200).json({ message: 'Trip deleted successfully' });  
    } catch (error) {  
      console.error('Database error:', error);  
      res.status(500).json({ error: 'Internal Server Error' });  
    }  
  }, 

  //根据用户 ID 查询并返回 tripmanage  
  getTripManageByUserId: async (req, res) => {  
    const { user_id } = req.body;  
    // 输入验证  
    if (!user_id) {  
      return res.status(400).json({ error: 'user_id is required' });  
    }  

    try {  
      const sql = 'SELECT * FROM tripmanage WHERE user_id = ?';  
      const results = await executeQuery(sql, [user_id]);  

      if (results.length === 0) {  
        return res.status(404).json({ error: 'No trips found for this user' });  
      }  

      res.send({
        results,
        code: 200,
      });  
    } catch (error) {  
      console.error('Database error:', error);  
      res.status(500).json({ error: 'Internal Server Error' });  
    }  
  }, 

  // 功能5: 更新行程信息  
  updateTripManage: async (req, res) => {  
    const { plan_id, user_id, plan_name, date, weather, keywords, summary, accomodation } = req.body;  

    // 输入验证  
    if (!plan_id) {  
      return res.status(400).json({ error: 'plan_id is required' });  
    }  

    try {  
      const sql = `  
        UPDATE tripmanage  
        SET user_id = ?, plan_name = ?, date = ?, weather = ?, keywords = ?, summary = ?, accomodation = ?  
        WHERE plan_id = ?`;  
      await executeQuery(sql, [user_id, plan_name, date, weather, keywords, summary, accomodation, plan_id]);  
      res.status(200).json({ message: 'Trip updated successfully' });  
    } catch (error) {  
      console.error('Database error:', error);  
      res.status(500).json({ error: 'Internal Server Error' });  
    }  
  }

}; 

const dailyTripController = {  
  // 添加新的日程  
  addDailyTrip: async (req, res) => {  
    const { plan_id, day, overview } = req.body;  

    // 输入验证  
    if (!plan_id || day == null || !overview) {  
      return res.status(400).json({ error: 'plan_id, day, and overview are required' });  
    }  

    try {  
      const sql = `  
        INSERT INTO dailytrip (plan_id, day, overview)  
        VALUES (?, ?, ?)`;  
      await executeQuery(sql, [plan_id, day, overview]);  
      res.status(200).json({ message: 'Daily trip added successfully' });  
    } catch (error) {  
      console.error('Database error:', error);  
      res.status(500).json({ error: 'Internal Server Error' });  
    }  
  },  
  
  // 删除日程  
  deleteDailyTrip: async (req, res) => {  
    const { plan_id, day } = req.body;
    // 输入验证  
    if (!plan_id || day == null) {  
      return res.status(400).json({ error: 'plan_id and day are required' });  
    }  

    try {  
      const sql = 'DELETE FROM dailytrip WHERE plan_id = ? AND day = ?';  
      await executeQuery(sql, [plan_id, day]);  
      res.status(200).json({ message: 'Daily trip deleted successfully' });  
    } catch (error) {  
      console.error('Database error:', error);  
      res.status(500).json({ error: 'Internal Server Error' });  
    }  
  },

  //根据 plan_id 查询并返回 dailytrip  
  getDailyTripByPlanId: async (req, res) => {  
    const { plan_id } = req.body;  

    // 输入验证  
    if (!plan_id) {  
      return res.status(400).json({ error: 'plan_id is required' });  
    }  

    try {  
      const sql = 'SELECT * FROM dailytrip WHERE plan_id = ?';  
      const results = await executeQuery(sql, [plan_id]);  

      if (results.length === 0) {  
        return res.status(404).json({ error: 'No daily trips found for this plan' });  
      }  
      res.send({
        results,
        code: 200,
      });
    } catch (error) {  
      console.error('Database error:', error);  
      res.status(500).json({ error: 'Internal Server Error' });  
    }  
  },
  
  // 更新日程信息  
  updateDailyTrip: async (req, res) => {  
    const { plan_id, day, overview } = req.body;  

    // 输入验证  
    if (!plan_id || day == null) {  
      return res.status(400).json({ error: 'plan_id and day are required' });  
    }  

    try {  
      const sql = `  
        UPDATE dailytrip  
        SET overview = ?  
        WHERE plan_id = ? AND day = ?`;  
      await executeQuery(sql, [overview, plan_id, day]);  
      res.status(200).json({ message: 'Daily trip updated successfully' });  
    } catch (error) {  
      console.error('Database error:', error);  
      res.status(500).json({ error: 'Internal Server Error' });  
    }  
  }

};  

const activityController = {  
  // 添加新的活动  
  addActivity: async (req, res) => {  
    const {day, start_time, end_time, display_image, booking_method, transport } = req.body;  

    const act_id = uuidv4();
    // 输入验证  
    if (day == null) {  
      return res.status(400).json({ error: 'day is required' });  
    }  

    try {  
      const sql = `  
        INSERT INTO activity (act_id, day, start_time, end_time, display_image, booking_method, transport)  
        VALUES (?, ?, ?, ?, ?, ?, ?)`;  
      await executeQuery(sql, [act_id, day, start_time, end_time, display_image, booking_method, transport]);  
      res.send({
        message: 'Activity added successfully',
        data: {  
          act_id,  
          // 可以添加其他需要返回给前端的字段  
        }, 
        code: 200,
      }) 
    } catch (error) {  
      console.error('Database error:', error);  
      res.status(500).json({ error: 'Internal Server Error' });  
    }  
  },  

  // 删除活动  
  deleteActivity: async (req, res) => {  
    const { act_id } = req.body; 
    // 输入验证  
    if (!act_id) {  
      return res.status(400).json({ error: 'act_id is required' });  
    }  

    try {  
      const sql = 'DELETE FROM activity WHERE act_id = ?';  
      await executeQuery(sql, [act_id]);  
      res.status(200).json({ message: 'Activity deleted successfully' });  
    } catch (error) {  
      console.error('Database error:', error);  
      res.status(500).json({ error: 'Internal Server Error' });  
    }  
  },

  //根据 day 查询并返回相关信息  
  getActivitiesByDay: async (req, res) => {  
    const { day } = req.body;  

    // 输入验证  
    if (!day) {  
      return res.status(400).json({ error: 'day is required' });  
    }  

    try {  
      const sql = 'SELECT * FROM dailytrip WHERE day = ?';  
      const results = await executeQuery(sql, [day]);  

      if (results.length === 0) {  
        return res.status(404).json({ error: 'No trips found for this day' });  
      }  
      res.send({
        results,
        code: 200,
      });  
    } catch (error) {  
      console.error('Database error:', error);  
      res.status(500).json({ error: 'Internal Server Error' });  
    }  
  },

  // 更新活动信息  
  updateActivity: async (req, res) => {  
    const { act_id, day, start_time, end_time, display_image, booking_method, transport } = req.body;  
    console.log(req.body);
    // 输入验证  
    if (!act_id) {  
      return res.status(400).json({ error: 'act_id is required' });  
    }  

    try {  
      const sql = `  
        UPDATE activity  
        SET day = ?, start_time = ?, end_time = ?, display_image = ?, booking_method = ?, transport = ?  
        WHERE act_id = ?`;  
      await executeQuery(sql, [day, start_time, end_time, display_image, booking_method, transport, act_id]);  
      res.status(200).json({ message: 'Activity updated successfully' });  
    } catch (error) {  
      console.error('Database error:', error);  
      res.status(500).json({ error: 'Internal Server Error' });  
    }  
  }

};  

export { tripController, dailyTripController, activityController };