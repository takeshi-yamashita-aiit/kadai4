# ------------------------------
# 正常動作時のチェック
# 最大公約数が計算できているか
# 正常動作の正解データ
echo "2" > /tmp/$$-ans
# 正常動作の出力
./main.sh 2 4 > /tmp/$$-result
diff /tmp/$$-ans /tmp/$$-result || echo "テスト2-1" >> /tmp/$$-error.log

# ------------------------------
# 異常動作時のチェック
# 引数異常
echo "Error: Expecting 2 args; found 1 (15)" > /tmp/$$-ans
./main.sh 15 > /tmp/$$-result
diff /tmp/$$-ans /tmp/$$-result || echo "テスト2-1" >> /tmp/$$-error.log

# ------------------------------
# エラーメッセージを出力する
if [ -f /tmp/$$-error.log ];then
        cat /tmp/$$-error.log 1>&2
        rm -f /tmp/$$-*
        exit 1
fi