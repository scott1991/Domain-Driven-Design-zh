for f in *.jpg; do
    # 提取文件名前两位数字，并去掉前导零
    num=${f:0:2}
    num=$(echo $num | sed 's/^0*//')
    dir="ch$num"
    # 创建目录（如果不存在）
    mkdir -p "$dir"
    # 移动文件到新目录
    mv "$f" "$dir/$f"
done
