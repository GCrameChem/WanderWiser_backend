import { executeQuery } from '../config/dbconfig.js';  

// 用户个人偏好数据控制器  
const userPortraitController = {  
  // 增加用户  
  addUserPortrait: async (req, res) => {  
    const {  
      user_id, user_gender, user_age, birth_day,  
      travel_history, preferred_travel_season, interests,  
      place_residence, occupation, education_level,  
      budget, income_level, consumption_level,  
      relationship, other_profile, click_rate,  
      conversion_rate, recent_behavior_count  
    } = req.body;  

    if (!user_id) {  
      return res.status(400).json({ error: 'user_id, user_gender, and user_age are required' });  
    }  

    try {  
      const sql = `  
        INSERT INTO userportrait (  
          user_id, user_gender, user_age, birth_day,  
          travel_history, preferred_travel_season, interests,  
          place_residence, occupation, education_level,  
          budget, income_level, consumption_level,  
          relationship, other_profile, click_rate,  
          conversion_rate, recent_behavior_count  
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`;  

      await executeQuery(sql, [  
        user_id, user_gender, user_age, birth_day,  
        travel_history, preferred_travel_season, interests,  
        place_residence, occupation, education_level,  
        budget, income_level, consumption_level,  
        relationship, other_profile, click_rate,  
        conversion_rate, recent_behavior_count  
      ]);  

      res.status(201).json({ message: 'User portrait created successfully' });  
    } catch (error) {  
      console.error('Database error:', error);  
      res.status(500).json({ error: 'Internal Server Error' });  
    }  
  },  

  // 查找用户偏好数据  
  getUserPortrait: async (req, res) => {  
    const { user_id } = req.params;  

    try {  
      const sql = 'SELECT * FROM userportrait WHERE user_id = ?';  
      const results = await executeQuery(sql, [user_id]);  

      if (results.length === 0) {  
        return res.status(404).json({ error: 'User portrait not found' });  
      }  

      res.status(200).json(results[0]);  
    } catch (error) {  
      console.error('Database error:', error);  
      res.status(500).json({ error: 'Internal Server Error' });  
    }  
  },  

  // 更新用户偏好数据 
  updateUserPortrait: async (req, res) => {  
    const { user_id } = req.params;  
    const {  
      user_gender, user_age, birth_day,  
      travel_history, preferred_travel_season, interests,  
      place_residence, occupation, education_level,  
      budget, income_level, consumption_level,  
      relationship, other_profile, click_rate,  
      conversion_rate, recent_behavior_count  
    } = req.body;  

    try {  
      const sql = `  
        UPDATE userportrait SET  
          user_gender = ?,  
          user_age = ?,  
          birth_day = ?,  
          travel_history = ?,  
          preferred_travel_season = ?,  
          interests = ?,  
          place_residence = ?,  
          occupation = ?,  
          education_level = ?,  
          budget = ?,  
          income_level = ?,  
          consumption_level = ?,  
          relationship = ?,  
          other_profile = ?,  
          click_rate = ?,  
          conversion_rate = ?,  
          recent_behavior_count = ?  
        WHERE user_id = ?`;  

      const result = await executeQuery(sql, [  
        user_gender, user_age, birth_day,  
        travel_history, preferred_travel_season, interests,  
        place_residence, occupation, education_level,  
        budget, income_level, consumption_level,  
        relationship, other_profile, click_rate,  
        conversion_rate, recent_behavior_count,  
        user_id  
      ]);  

      if (result.affectedRows === 0) {  
        return res.status(404).json({ error: 'User portrait not found' });  
      }  

      res.status(200).json({ message: 'User portrait updated successfully' });  
    } catch (error) {  
      console.error('Database error:', error);  
      res.status(500).json({ error: 'Internal Server Error' });  
    }  
  },  

  // 删除用户画像  
  deleteUserPortrait: async (req, res) => {  
    const { user_id } = req.params;  

    try {  
      const sql = 'DELETE FROM userportrait WHERE user_id = ?';  
      const result = await executeQuery(sql, [user_id]);  

      if (result.affectedRows === 0) {  
        return res.status(404).json({ error: 'User portrait not found' });  
      }  

      res.status(200).json({ message: 'User portrait deleted successfully' });  
    } catch (error) {  
      console.error('Database error:', error);  
      res.status(500).json({ error: 'Internal Server Error' });  
    }  
  }  
};  

export default userPortraitController;