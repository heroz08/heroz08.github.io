---
title: mysql的增删改查
date: 2019-11-23 10:50:02
tags: [mysql]
---

- 插入数据

```mysql
语法： 
    INSERT INTO 表名(列名) VALUES(列名值)
栗子：
    INSERT INTO tags(name,id,url) VALUES('爬虫',10,'https://news.so.com/hotnews')
解释：
    向标签表(tags)里插入一条，姓名，id和访问地址分别为VALUES内对应的值

```

- 更新数据

```mysql
语法：
    UPDATE 表名 SET 列名=更新值 WHERE 更新条件
栗子：
    UPDATE articles SET title='你好，世界',content='世界没你想的那么糟！' WHERE id=1
解释：
    更新id为1的文章，标题和内容都进行了修改

```

- 删除数据

```mysql
语法：
    DELETE FROM 表名 WHERE 删除条件
栗子：
    DELETE FROM tags WHERE id=11
解释：
    从标签表(tags)里删除id为11的数据

```

- 查询

```mysql
语法：
    SELECT 列名 FROM 表名 WHERE 查询条件 ORDER BY 排序列名
栗子：
    SELECT name,title,content FROM tags WHERE id=8
解释：
    查询id为8的标签表里对应信息
```