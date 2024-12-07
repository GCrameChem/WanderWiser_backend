import { executeQuery } from '../config/dbconfig.js'; // 数据库查询函数  
import { v4 as uuidv4 } from 'uuid';

const userMemoryController = {  
  // 添加新的用户记忆  
  addUserMemory: async (req, res) => {  
    const { user_id, interaction_content, agent_response, context_info, preference_record } = req.body;

    // 输入验证  
    if (!user_id || !interaction_content) {  
      return res.status(400).json({ error: 'user_id and interaction_content are required' });  
    }  
    const memory_id = uuidv4();
    try {  
      const interaction_time = new Date(); // 获取当前时间  
      const sql = `  
        INSERT INTO usermemory (memory_id, user_id, interaction_time, interaction_content, agent_response, context_info, preference_record)  
        VALUES (?, ?, ?, ?, ?, ?, ?)`;  
      await executeQuery(sql, [memory_id, user_id, interaction_time, interaction_content, agent_response, context_info, preference_record]);  
      res.send({
        message: 'userMemory added successfully',
        data: {  
          memory_id,  
          // 可以添加其他需要返回给前端的字段  
        }, 
        code: 200,
      }) 
    } catch (error) {  
      console.error('Database error:', error);  
      res.status(500).json({ error: 'Internal Server Error' });  
    }  
  },  

  // 更新用户记忆信息  
  updateUserMemory: async (req, res) => {  
    const { memory_id, user_id, interaction_content, agent_response, context_info, preference_record } = req.body;  

    // 输入验证  
    if (!memory_id) {  
      return res.status(400).json({ error: 'memory_id is required' });  
    }  

    try {  
      const sql = `  
        UPDATE usermemory  
        SET user_id = ?, interaction_content = ?, agent_response = ?, context_info = ?, preference_record = ?  
        WHERE memory_id = ?`;  
      await executeQuery(sql, [user_id, interaction_content, agent_response, context_info, preference_record, memory_id]);  
      res.status(200).json({ message: 'User memory updated successfully' });  
    } catch (error) {  
      console.error('Database error:', error);  
      res.status(500).json({ error: 'Internal Server Error' });  
    }  
  },  

  // 删除用户记忆  
  deleteUserMemory: async (req, res) => {  
    const { memory_id } = req.body;  

    // 输入验证  
    if (!memory_id) {  
      return res.status(400).json({ error: 'memory_id is required' });  
    }  

    try {  
      const sql = 'DELETE FROM usermemory WHERE memory_id = ?';  
      await executeQuery(sql, [memory_id]);  
      res.status(200).json({ message: 'User memory deleted successfully' });  
    } catch (error) {  
      console.error('Database error:', error);  
      res.status(500).json({ error: 'Internal Server Error' });  
    }  
  },  

  // 根据 ID 查询用户记忆  
  getUserMemoriesById: async (req, res) => {  
    const { memory_id } = req.body;  
    // 输入验证  
    if (!memory_id) {  
      return res.status(400).json({ error: 'memory_id is required' });  
    }  

    try {  
      const sql = 'SELECT * FROM usermemory WHERE memory_id = ?';  
      const results = await executeQuery(sql, [memory_id]);  

      if (results.length === 0) {  
        return res.status(404).json({ error: 'No memory found for this memory_id' });  
      }  
      res.send({
        results,
        code: 200,
      });  
    } catch (error) {  
      console.error('Database error:', error);  
      res.status(500).json({ error: 'Internal Server Error' });  
    }  
  } ,

  // 根据用户 ID 查询用户记忆  
  getUserMemoriesByUserId: async (req, res) => {  
    const { user_id } = req.body;  

    // 输入验证  
    if (!user_id) {  
      return res.status(400).json({ error: 'user_id is required' });  
    }  

    try {  
      const sql = 'SELECT * FROM usermemory WHERE user_id = ?';  
      const results = await executeQuery(sql, [user_id]);  

      if (results.length === 0) {  
        return res.status(404).json({ error: 'No memories found for this user' });  
      }  
      res.send({
        results,
        code: 200,
      });  
    } catch (error) {  
      console.error('Database error:', error);  
      res.status(500).json({ error: 'Internal Server Error' });  
    }  
  }  
};  

export default userMemoryController;