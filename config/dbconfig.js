// 数据库配置文件
import mysql from 'mysql';
//创建连接池
const pool = mysql.createPool({
  host: '127.0.0.1', //服务器地址
  user: 'root', // 填自己的账号
  password: '20040201zy', // 对应密码
  database: 'ww', // 对应数据库名称
})

// 封装sql执行函数
export const executeQuery = (sql, values) => {
  return new Promise((resolve, reject) => {
    pool.getConnection((err, connection) => {
      if (err) {
        reject(err);
        return;
      }

      connection.query(sql, values, (queryErr, results) => {
        connection.release();

        if (queryErr) {
          reject(queryErr);
        } else {
          resolve(results);
        }
      });
    });
  });
};