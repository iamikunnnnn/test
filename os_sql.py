import os

results = []
for filename in os.listdir("./DDL语句"):
    filepath = os.path.join("./DDL语句", filename)   # 拼接完整路径
    if os.path.isfile(filepath):  # 只处理文件，忽略文件夹
        with open(filepath, "r", encoding="utf-8") as f:
            content = f.read()
            results.append(content)

print(results)
