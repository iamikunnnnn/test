#*********************以下内容暂不知道应该放到什么分类，但很有用**************************

# 先查询education最大值和education，再作为子查询的FROM为子查询提供数据来源，然后子查询进一步where筛选，这样就解决
# 了GROUP BY 后面不能WHERE的问题，最后再嵌套到大表，大表根据education和筛选结果相等的就是结果了。
# 核心思维就是将group by 结果 作为 FROM来源，而不是常见的作为JOIN

SELECT * FROM pandas_data WHERE age>=22 AND
education=
(SELECT t.education
FROM (
    SELECT education, COUNT(*) AS cnt,
           MAX(COUNT(*)) OVER() AS max_cnt
    FROM pandas_data
    GROUP BY education
) AS t
WHERE cnt = max_cnt
);


#
#
# INSERT INTO pandas_data (name, age, nationality,education, gender)
# SELECT %s, %s, %s, %s, %s
# WHERE NOT EXISTS (
#     SELECT 1 FROM pandas_das);ta
#     WHERE name = %s AND age = %