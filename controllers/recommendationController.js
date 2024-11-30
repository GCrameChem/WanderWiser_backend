import { executeQuery } from '../config/dbconfig.js'; // 数据库查询函数  
import { v4 as uuidv4 } from 'uuid';

const recommendationController = {  
  // 添加新的推荐  
  addRecommendation: async (req, res) => {  
    const { user_id, recommendation_reason, feedback_status, rating } = req.body;  

    // 分配planId，使用唯一标识符库
    const recommendation_id = uuidv4();
    // 输入验证  
    if (!user_id || !recommendation_reason || !feedback_status || !rating) {  
      return res.status(400).json({ error: 'user_id, recommendation_reason, feedback_status, and rating are required' });  
    }  

    try {  
      const creation_time = new Date(); // 获取当前时间  
      const sql = `  
        INSERT INTO recommendation (recommendation_id, user_id, recommendation_reason, creation_time, feedback_status, rating)  
        VALUES (?, ?, ?, ?, ?)`;  
      await executeQuery(sql, [recommendation_id, user_id, recommendation_reason, creation_time, feedback_status, rating]);  
      res.status(201).json({ message: 'Recommendation added successfully' });  
    } catch (error) {  
      console.error('Database error:', error);  
      res.status(500).json({ error: 'Internal Server Error' });  
    }  
  },  

  // 更新推荐信息  
  updateRecommendation: async (req, res) => {  
    const { recommendation_id, user_id, recommendation_reason, feedback_status, rating } = req.body;  

    // 输入验证  
    if (!recommendation_id) {  
      return res.status(400).json({ error: 'recommendation_id is required' });  
    }  

    try {  
      const sql = `  
        UPDATE recommendation  
        SET user_id = ?, recommendation_reason = ?, feedback_status = ?, rating = ?  
        WHERE recommendation_id = ?`;  
      await executeQuery(sql, [user_id, recommendation_reason, feedback_status, rating, recommendation_id]);  
      res.status(200).json({ message: 'Recommendation updated successfully' });  
    } catch (error) {  
      console.error('Database error:', error);  
      res.status(500).json({ error: 'Internal Server Error' });  
    }  
  },  

  // 删除推荐  
  deleteRecommendation: async (req, res) => {  
    const { recommendation_id } = req.body;  

    // 输入验证  
    if (!recommendation_id) {  
      return res.status(400).json({ error: 'recommendation_id is required' });  
    }  

    try {  
      const sql = 'DELETE FROM recommendation WHERE recommendation_id = ?';  
      await executeQuery(sql, [recommendation_id]);  
      res.status(200).json({ message: 'Recommendation deleted successfully' });  
    } catch (error) {  
      console.error('Database error:', error);  
      res.status(500).json({ error: 'Internal Server Error' });  
    }  
  },  

  // 根据用户 ID 查询推荐信息  
  getRecommendationsByUserId: async (req, res) => {  
    const { user_id } = req.body;  

    // 输入验证  
    if (!user_id) {  
      return res.status(400).json({ error: 'user_id is required' });  
    }  

    try {  
      const sql = 'SELECT * FROM recommendation WHERE user_id = ?';  
      const results = await executeQuery(sql, [user_id]);  

      if (results.length === 0) {  
        return res.status(404).json({ error: 'No recommendations found for this user' });  
      }  

      res.status(200).json(results);  
    } catch (error) {  
      console.error('Database error:', error);  
      res.status(500).json({ error: 'Internal Server Error' });  
    }  
  },

  // 根据推荐 ID 查询推荐信息  
  getRecommendationsById: async (req, res) => {  
    const { recommendation_id } = req.body;  

    // 输入验证  
    if (!recommendation_id) {  
      return res.status(400).json({ error: 'recommendation_id is required' });  
    }  

    try {  
      const sql = 'SELECT * FROM recommendation WHERE recommendation_id = ?';  
      const results = await executeQuery(sql, [recommendation_id]);  

      if (results.length === 0) {  
        return res.status(404).json({ error: 'No recommendation found for this recommendation_id' });  
      }  

      res.status(200).json(results);  
    } catch (error) {  
      console.error('Database error:', error);  
      res.status(500).json({ error: 'Internal Server Error' });  
    }  
  }  
};  

export default recommendationController;