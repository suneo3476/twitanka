#! ruby
require 'csv'
Encoding.default_internal = 'utf-8'
Encoding.default_external = 'utf-8'

str = ''
c = 0
open("tankar.txt","w") do |txt| #txt書き込み
	CSV.foreach("elm_pos_kana.csv") do |row| #csv読み込み
		if(row[0]=~/[、。・「」【】]/u) #記号類排除
			next
		end
		if(c==0 && row[1]=='助詞') #助詞を文頭にしない
			next
		end
		c += row[2].length
		str += row[0]
		if(c>31) #字余りは許さない
			c = 0
			str = ''
			next
		end
		if(c==31 && row[1]!='助詞') #ナイス57577です
			c = 0
			txt.puts(str)
			str = ''
		end
	end
end