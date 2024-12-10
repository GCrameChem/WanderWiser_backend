// 用户行程管理的控制器  
import { executeQuery } from '../config/dbconfig.js';
import { v4 as uuidv4 } from 'uuid';
import fs from 'fs'; // 文件系统模块  
import path from 'path'; // 路径模块  

const tripController = {  

  //增加新的行程到 tripmanage 
  addTripManage: async (req, res) => {  
      const { user_id, plan_name, days } = req.body;   
      // 分配 plan_id，使用唯一标识符库  
      const plan_id = uuidv4();  
      
      // 输入验证  
      if (!user_id) {  
        return res.status(400).json({ error: 'user_id is required' });  
      }  

      try {  
        const sql = `  
          INSERT INTO tripmanage (plan_id, user_id, plan_name, days)  
          VALUES (?, ?, ?, ?)`;  
        await executeQuery(sql, [plan_id, user_id, plan_name, days]);   
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
        const result = await executeQuery(sql, [plan_id]);  
        
        // 检查是否有行被删除  
        if (result.affectedRows === 0) {  
            return res.status(404).json({ error: 'Trip not found' });  
        }  
        
        res.status(200).json({ message: 'Trip deleted successfully' });  
      } catch (error) {  
        console.error('Database error:', error);  
        res.status(500).json({ error: 'Internal Server Error' });  
      }  
  },  

  // 根据用户 ID 查询并返回 tripmanage  
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
      const { plan_id, user_id, plan_name, days } = req.body;  

      // 输入验证  
      if (!plan_id) {  
        return res.status(400).json({ error: 'plan_id is required' });  
      }  

      try {  
        const sql = `  
          UPDATE tripmanage  
          SET user_id = ?, plan_name = ?, days = ?  
          WHERE plan_id = ?`;  
          
        const result = await executeQuery(sql, [user_id, plan_name, days, plan_id]);  

        // 检查是否有行被更新  
        if (result.affectedRows === 0) {  
            return res.status(404).json({ error: 'Trip not found' });  
        }  

        res.status(200).json({ message: 'Trip updated successfully' });  
      } catch (error) {  
        console.error('Database error:', error);  
        res.status(500).json({ error: 'Internal Server Error' });  
      }  
  },

  // 获取行程的 Markdown 格式  
  getTripManageMarkdown: async (req, res) => {  
    const { plan_id } = req.body;  
    // 输入验证  
    if (!plan_id) {  
      return res.status(400).json({ error: 'plan_id is required' });  
    }  

    try {  
      // 获取 tripmanage 基本信息  
      const tripSql = 'SELECT * FROM tripmanage WHERE plan_id = ?';  
      const tripResults = await executeQuery(tripSql, [plan_id]);  

      if (tripResults.length === 0) {  
        return res.status(404).json({ error: 'No trips found for this user' });  
      }  

      // 直接从数据库查询 dailytrip 数据  
      const dailySql = 'SELECT * FROM dailytrip WHERE plan_id = ? ORDER BY day';  
      const dailyTrips = await executeQuery(dailySql, [plan_id]);  

      if (dailyTrips.length === 0) {  
        return res.status(404).json({ error: 'No daily trips found for this plan' });  
      }  

      // 格式化为Markdown  
      let markdownContent = `# ${tripResults[0].plan_name}\n\n---\n\n`;  

      const formatDate = (date) => {  
        const options = { year: 'numeric', month: '2-digit', day: '2-digit' };  
        const formattedDate = new Date(date).toLocaleDateString('zh-CN', options);  
        return formattedDate.replace(/\//g, '/'); // 将日期格式化为 YYYY/MM/DD  
      };  
      
      // 遍历每个旅行  
      dailyTrips.forEach(trip => {  
        markdownContent += `## 第${trip.day}天 - ${trip.location} - ${trip.weather} - ${formatDate(trip.date)}\n`;  
        markdownContent += `- **关键词**: ${trip.keywords}\n`;  
        markdownContent += `- **主要内容**: ${trip.abstract}\n`;  
        markdownContent += `- **住宿点**: ${trip.accomodation}\n\n`;  
        markdownContent += `---\n\n`;  
      });     

      const directoryPath = 'D:/Markdown';  
      const filePath = path.join(directoryPath, 'trip_manage.md');  

      // 检查目录是否存在，如果不存在则创建  
      if (!fs.existsSync(directoryPath)) {  
        fs.mkdirSync(directoryPath, { recursive: true }); // 使用 recursive: true 可以创建多层目录  
      }  

      // 写入 Markdown 文件  
      fs.writeFileSync(filePath, markdownContent, { flag: 'w' }); // flag: 'w' 是默认选项，覆盖同名文件  

      // 发送文件给前端  
      res.download(filePath, 'trip_manage.md', (err) => {  
        if (err) {  
          console.error('Error downloading file:', err);  
          res.status(500).json({ error: 'Error downloading file' });  
        }  
      });  
    } catch (error) {  
      console.error('Database error:', error);  
      res.status(500).json({ error: 'Internal Server Error' });  
    }  
  },
  getDailyTripMarkdown: async (req, res) => {  
    const { plan_id, day } = req.body;  
  
    // 输入验证  
    if (!plan_id || !day) {  
      return res.status(400).json({ error: 'plan_id and day are required' });  
    }  
  
    try {  
      // 查询 dailytrip 表  
      const dailyTripSql = 'SELECT summary, carry_items, location FROM dailytrip WHERE plan_id = ? AND day = ?';  
      const dailyTripResults = await executeQuery(dailyTripSql, [plan_id, day]);  
  
      if (dailyTripResults.length === 0) {  
        return res.status(404).json({ error: 'No daily trip found for this plan and day' });  
      }  
  
      const { summary, carry_items, location } = dailyTripResults[0];  
  
      // 查询 activity 表  
      const activitySql = 'SELECT * FROM activity WHERE day = ? ORDER BY start_time';  
      const activityResults = await executeQuery(activitySql, [day]);  
  
      if (activityResults.length === 0) {  
        return res.status(404).json({ error: 'No activities found for this day' });  
      }  
  
      // 生成 Markdown 内容  
      let markdownContent = `# 第${day}天 - ${location}\n\n---\n\n`;  
      markdownContent += `### **今日建议携带物品**\n`;  
      markdownContent += `- ${carry_items ? carry_items.split(',').join('\n- ') : '无'}\n\n`;  
      markdownContent += `---\n\n`;  
      markdownContent += `### **时间与活动安排**\n\n`;  
  
      activityResults.forEach(activity => {  
        markdownContent += `#### **${activity.start_time.toLocaleString('zh-CN', { hour: '2-digit', minute: '2-digit' })} - ${activity.actname}**\n`;  
        markdownContent += `- **活动内容**: ${activity.activity_content}\n`;  
        markdownContent += `- **地址**: ${activity.address}\n`;  
        markdownContent += `- **交通方式**: ${activity.transport}\n`;  
        markdownContent += `- **宣传图片**:\n![活动图片](${activity.display_image})\n`;  
        markdownContent += `- **预定链接**: [点击预约门票](${activity.booking_method})\n\n`;  
        markdownContent += `---\n\n`;  
      });  
  
      markdownContent += `### **每日总结**\n`;  
      markdownContent += `${summary}\n`;  
  
      const directoryPath = 'D:/Markdown';  
      const filePath = path.join(directoryPath, 'daily_trip.md');  

      // 检查目录是否存在，如果不存在则创建  
      if (!fs.existsSync(directoryPath)) {  
        fs.mkdirSync(directoryPath, { recursive: true }); // 使用 recursive: true 可以创建多层目录  
      }  

      // 写入 Markdown 文件  
      fs.writeFileSync(filePath, markdownContent, { flag: 'w' }); // flag: 'w' 是默认选项，覆盖同名文件  

      // 发送文件给前端  
      res.download(filePath, 'daily_trip.md', (err) => {  
        if (err) {  
          console.error('Error downloading file:', err);  
          res.status(500).json({ error: 'Error downloading file' });  
        }  
      });  
    } catch (error) {  
      console.error('Database error:', error);  
      res.status(500).json({ error: 'Internal Server Error' });  
    }  
  }
};  

const dailyTripController = {  
  // 添加新的日程  
  addDailyTrip: async (req, res) => {  
    const { plan_id, day, location, date, weather, keywords, summary, accomodation, abstract, carry_items} = req.body;  // 新增字段  

    // 输入验证  
    if (!plan_id || day == null) {  
      return res.status(400).json({ error: 'plan_id and day are required' });  
    }  

    try {  
      const sql = `  
        INSERT INTO dailytrip (plan_id, day, location, date, weather, keywords, summary, accomodation, abstract, carry_items)  
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`;  
      await executeQuery(sql, [plan_id, day, location, date, weather, keywords, summary, accomodation, abstract, carry_items]);  
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
      const result = await executeQuery(sql, [plan_id, day]);  

      // 检查是否有行被删除  
      if (result.affectedRows === 0) {  
        return res.status(404).json({ error: 'No daily trip found to delete' });  
      }  
      
      res.status(200).json({ message: 'Daily trip deleted successfully' });  
    } catch (error) {  
      console.error('Database error:', error);  
      res.status(500).json({ error: 'Internal Server Error' });  
    }  
  },  

  // 根据 plan_id 查询并返回 dailytrip  
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
    const { plan_id, day, location, date, weather, keywords, summary, accomodation, abstract, carry_items } = req.body;  // 新增字段  

    // 输入验证  
    if (!plan_id || day == null) {  
      return res.status(400).json({ error: ' plan_id and day are required' });  
    }  

    try {  
      const sql = `  
        UPDATE dailytrip  
        SET location = ?, date = ?, weather = ?, keywords = ?, summary = ?, accomodation = ?, abstract = ?, carry_items = ?
        WHERE plan_id = ? AND day = ?`;  
      const result = await executeQuery(sql, [location, date, weather, keywords, summary, accomodation, abstract, carry_items, plan_id, day]);  

      // 检查是否有行被更新  
      if (result.affectedRows === 0) {  
        return res.status(404).json({ error: 'No daily trip found to update' });  
      }  
      
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
    const {actname, day, start_time, end_time, display_image, booking_method, transport, activity_content, address, recommended_dishes } = req.body;  

    const act_id = uuidv4();
    // 输入验证  
    if (day == null) {  
      return res.status(400).json({ error: 'day is required' });  
    }  

    try {  
      const sql = `  
        INSERT INTO activity (act_id, actname, day, start_time, end_time, display_image, booking_method, transport, activity_content, address, recommended_dishes)  
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`;  
      await executeQuery(sql, [act_id, actname, day, start_time, end_time, display_image, booking_method, transport, activity_content, address, recommended_dishes ]);  
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
    const { act_id, actname, day, start_time, end_time, display_image, booking_method, transport, activity_content, address, recommended_dishes } = req.body;  
    // 输入验证  
    if (!act_id) {  
      return res.status(400).json({ error: 'act_id is required' });  
    }  

    try {  
      const sql = `  
        UPDATE activity  
        SET actname = ?, day = ?, start_time = ?, end_time = ?, display_image = ?, booking_method = ?, transport = ?, activity_content = ?, address = ?, recommended_dishes = ?
        WHERE act_id = ?`;  
      await executeQuery(sql, [actname, day, start_time, end_time, display_image, booking_method, transport, activity_content, address, recommended_dishes, act_id]);  
      res.status(200).json({ message: 'Activity updated successfully' });  
    } catch (error) {  
      console.error('Database error:', error);  
      res.status(500).json({ error: 'Internal Server Error' });  
    }  
  }

};  

export { tripController, dailyTripController, activityController };