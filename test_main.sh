# ------------------------------
# 正常動作時のチェック
# 最大公約数が計算できているか
# 正常動作の正解データ
echo "2" > /tmp/$$-ans
./main.sh 2 4 > /tmp/$$-result
diff /tmp/$$-ans /tmp/$$-result || echo "テスト1-1" >> /tmp/$$-error.log

echo "1" > /tmp/$$-ans
./main.sh 0 1 > /tmp/$$-result
diff /tmp/$$-ans /tmp/$$-result || echo "テスト1-2" >> /tmp/$$-error.log

echo "9223372036854775807" > /tmp/$$-ans
./main.sh 9223372036854775807 9223372036854775807 > /tmp/$$-result
diff /tmp/$$-ans /tmp/$$-result || echo "テスト1-3" >> /tmp/$$-error.log

# ------------------------------
# 異常動作時のチェック
# 引数異常(2-1)
echo "Error: Expecting 2 args; found 1 (15)" > /tmp/$$-ans
./main.sh 15 > /tmp/$$-result
diff /tmp/$$-ans /tmp/$$-result || echo "テスト2-1-1" >> /tmp/$$-error.log

echo "Error: Expecting 2 args; found 3 (15 48 60)" > /tmp/$$-ans
./main.sh 15 48 60 > /tmp/$$-result
diff /tmp/$$-ans /tmp/$$-result || echo "テスト2-1-2" >> /tmp/$$-error.log

# 引数が正の整数であること(2-2)
## マイナス
echo "Error: 2 args must be positive integer; found (-1 0)" > /tmp/$$-ans
./main.sh -1 0 > /tmp/$$-result
diff /tmp/$$-ans /tmp/$$-result || echo "テスト2-2-1" >> /tmp/$$-error.log
## 小数
echo "Error: 2 args must be positive integer; found (0 1.8)" > /tmp/$$-ans
./main.sh 0 1.8 > /tmp/$$-result
diff /tmp/$$-ans /tmp/$$-result || echo "テスト2-2-2" >> /tmp/$$-error.log

# 引数の片方が0ではないこと(2-3)
echo "Error: Either arg must be grater than 0; found (0 0)" > /tmp/$$-ans
./main.sh 0 0 > /tmp/$$-result
diff /tmp/$$-ans /tmp/$$-result || echo "テスト2-3" >> /tmp/$$-error.log

# 引数が整数の最大値より小さいこと(2-4)
echo "Error: 2 args must be smaller than 9223372036854775808" > /tmp/$$-ans
./main.sh 9223372036854775807 9223372036854775808 > /tmp/$$-result
diff /tmp/$$-ans /tmp/$$-result || echo "テスト2-4-1" >> /tmp/$$-error.log

# ------------------------------
# エラーメッセージを出力する
if [ -f /tmp/$$-error.log ];then
        cat /tmp/$$-error.log 1>&2
        rm -f /tmp/$$-*
        exit 1
fi