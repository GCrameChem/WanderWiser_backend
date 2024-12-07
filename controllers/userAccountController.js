// 处理登录与注册的控制器

import { executeQuery } from '../config/dbconfig.js';
import { v4 as uuidv4 } from 'uuid';

const register = async (req, res) => {
  try {
    const { username, password } = req.body;
    console.log('Received register request:', req.body);

    // 分配user_id，使用唯一标识符库
    const user_id = uuidv4();
    // const gender = '未知';
    // const age = '未知';
    const account_status = 'disabled';
    const registration_time = new Date().toISOString().slice(0, 19).replace('T', ' ');
    // 改进:加一个判断用户名是否已经存在的逻辑，不能重复申请
    // 改进：区分大小写（这个小bug也可能是数据库的问题
    const sql = 'INSERT INTO useraccount (account, user_id, password, registration_time, account_status) VALUES (?, ?, ?, ?, ?)';
    // 改进：为每个不同的用户自动分配id
    // 改进：哈希加密至少三次，并保证数据库中存储的是加密后的密码

    // 传递正确的值
    const result = await executeQuery(sql, [username, user_id, password, registration_time, account_status]);

    // 返回响应
    res.send({
      message: 'Data inserted successfully XD',
      data: {  
        user_id: user_id,  
        // 可以添加其他需要返回给前端的字段  
      }, 
      code: 200,
    });
  } catch (error) {
    console.error('Error inserting data:', error);
    res.status(500).send('Internal Server Error');
  }
};


const login = async (req, res) => {
    const { user_id, password } = req.body;
    console.log('Received login request:', req.body);
    try {
        // 查询数据库，检查是否存在该用户名
        const sql = 'SELECT account, password, account_status FROM useraccount WHERE user_id = ?';
        const result = await executeQuery(sql, [user_id]);
        if (result.length > 0) {
            const dbPassword = result[0].password;
            const account_status = result[0].account_status;  // 获取account_status

            // 比较数据库中的密码与用户输入的密码
            if (dbPassword === password&& account_status === 'disabled') {
              // 这里为了方便先不更新登录时间和状态，实际测试时取消注释
              const sqlUpdate = 'UPDATE useraccount SET last_login_time = NOW(), account_status = "activated" WHERE user_id = ?';
              const resultUpdate = await executeQuery(sqlUpdate, [user_id]);
                res.send({
                    message: 'Login successful XD',
                    data: {  
                      user_id: user_id,  // 可以添加其他需要返回给前端的字段
                    }, 
                    code: 200,
                });
            } else {
                res.status(401).send({
                    message: 'Incorrect password',
                    code: 401,
                });
            }
        } else {
            res.status(404).send({
                message: 'User not found',
                code: 404,
            });
        }
    } catch (error) {
        console.error('Error querying database:', error);
        res.status(500).send('Internal Server Error');
    }
};

  // Get all users (for admin testing)
  const getAllUsers = async (req, res) => {
    try {
      const sql = 'SELECT * FROM useraccount';
      const result = await executeQuery(sql);

      res.send({
        result,
        code: 200,
      });
    } catch (error) {
      console.error('Error fetching data:', error);
      res.status(500).send('Internal Server Error');
    }
  };

  const deleteUser = async (req, res) => {
    const { user_id } = req.body;  

    // 输入验证  
    if (!user_id) {  
      return res.status(400).json({ error: 'user_id is required' });  
    }  
    try {  
      const sql = 'DELETE FROM useraccount WHERE user_id = ?';  
      await executeQuery(sql, [user_id]);  
      res.status(200).json({ message: 'user deleted successfully' });  
    } catch (error) {  
      console.error('Database error:', error);  
      res.status(500).json({ error: 'Internal Server Error' });  
    } 
  }
  export default { 
    register,
    login,
    getAllUsers,
    deleteUser,
  };