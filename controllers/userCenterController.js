// 个人中心控制器
import { executeQuery } from '../config/dbconfig.js';


const updateNickName = async (req, res) => {
  const { user_id, nickName } = req.body;

  // Validate input
  if (!user_id || !nickName) {
    return res.status(400).json({ error: 'user_id and nickName are required' });
  }

  try {
    // 构建 SQL 更新语句  
    const sql = 'UPDATE userdata SET nickname = ? WHERE user_id = ?';  
    const result = await executeQuery(sql, [nickName, user_id]);

    if (result.affectedRows === 0) {
      return res.status(404).json({ error: 'User not found' });
    }

    // Send success response
    res.status(200).json({ message: 'Nickname updated successfully' });
  } catch (error) {
    console.error('Database error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

const updateGender = async (req, res) => {
  const { user_id, gender } = req.body;

  // Validate input
  if (!user_id || !gender) {
    return res.status(400).json({ error: 'user_id and gender are required' });
  }

  try {
    // 构建 SQL 更新语句  
    const sql = 'UPDATE userdata SET gender = ? WHERE user_id = ?';  
    const result = await executeQuery(sql, [gender, user_id]);

    if (result.affectedRows === 0) {
      return res.status(404).json({ error: 'User not found' });
    }

    // Send success response
    res.status(200).json({ message: 'Gender updated successfully' });
  } catch (error) {
    console.error('Database error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

const updateAge = async (req, res) => {
  const { user_id, age } = req.body;

  // Validate input
  if (!user_id || !age) {
    return res.status(400).json({ error: 'user_id and age are required' });
  }

  try {
    // 构建 SQL 更新语句  
    const sql = 'UPDATE userdata SET age = ? WHERE user_id = ?';  
    const result = await executeQuery(sql, [age, user_id]);

    if (result.affectedRows === 0) {
      return res.status(404).json({ error: 'User not found' });
    }

    // Send success response
    res.status(200).json({ message: 'Age updated successfully' });
  } catch (error) {
    console.error('Database error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

const updateSchool = async (req, res) => {
  const { user_id, school } = req.body;

  // Validate input
  if (!user_id || !school) {
    return res.status(400).json({ error: 'user_id and school are required' });
  }

  try {
    // 构建 SQL 更新语句  
    const sql = 'UPDATE userdata SET school = ? WHERE user_id = ?';  
    const result = await executeQuery(sql, [school, user_id]);

    if (result.affectedRows === 0) {
      return res.status(404).json({ error: 'User not found' });
    }

    // Send success response
    res.status(200).json({ message: 'School updated successfully' });
  } catch (error) {
    console.error('Database error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

const updateDesc =  async (req, res) => {
  const { user_id, desc } = req.body;

  // Validate input
  if (!user_id || !desc) {
    return res.status(400).json({ error: 'user_id and description are required' });
  }

  try {
    // 构建 SQL 更新语句  
    const sql = 'UPDATE userdata SET description = ? WHERE user_id = ?';  
    const result = await executeQuery(sql, [desc, user_id]);

    if (result.affectedRows === 0) {
      return res.status(404).json({ error: 'User not found' });
    }

    // Send success response
    res.status(200).json({ message: 'Desc updated successfully' });
  } catch (error) {
    console.error('Database error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

const updatePassword = async (req, res) => {
  const { user_id, password } = req.body;

  // Validate input
  if (!user_id || !password) {
    return res.status(400).json({ error: 'user_id and desc are required' });
  }

  try {
    // 构建 SQL 更新语句  
    const sql = 'UPDATE userdata SET password = ? WHERE user_id = ?';  
    const result = await executeQuery(sql, [password, user_id]);

    if (result.affectedRows === 0) {
      return res.status(404).json({ error: 'User not found' });
    }

    // Send success response
    res.status(200).json({ message: 'Password updated successfully' });
  } catch (error) {
    console.error('Database error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

const persondata = async (req, res) => {
  const { user_id } = req.body;

  const sql = 'SELECT * FROM userdata WHERE user_id = ?';

  try {
      const result = await executeQuery(sql, [user_id]); // 执行查询
      if (result.length > 0) {
        const userData = result[0]; // 假设返回的用户数据是数组，取第一个元素

        res.send({
          code: 200,
          data: {
            nickName: userData.nickname,
            desc: userData.description,
            gender: userData.gender,
            age: userData.age,
            school: userData.school
          },
        });
      } else {
        res.status(404).json({ code: 404, message: '用户不存在' });
      }
    } catch (error) {
      console.error('数据库查询错误:', error);
      res.status(500).json({ code: 500, message: '内部服务器错误' });
    }
};

// 导出所有函数
export default { 
  updateNickName,
  updateGender,
  updateAge,
  updateSchool,
  updateDesc,
  updatePassword,
  persondata,
 };