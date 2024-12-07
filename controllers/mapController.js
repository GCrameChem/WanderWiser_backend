import path from 'path';

const mapController = {

    // 处理请求，返回 map1.html 文件
    showMap1: (req, res) => {
        res.sendFile(path.resolve('show/map1.html'));  // 使用相对路径并通过 resolve 转为绝对路径
    },

    // 处理请求，返回 map2.html 文件
    showMap2: (req, res) => {
        res.sendFile(path.resolve('show/map2.html'));
    },

    // 处理请求，返回 path.html 文件
    showPath: (req, res) => {
        res.sendFile(path.resolve('show/path.html'));
    }
};

export default mapController;
