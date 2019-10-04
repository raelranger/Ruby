 
 # จงอธิบายการทำงานของ Code และ แสดงผลลัพธ์ของ Code ที่ให้

class Candy
    def taste
        puts "Uuuumaiiiiiiiii"
    end
end

class Puthai < Candy
    def taste
        puts "Yummmmy"
    end
end

class Changnoi < Candy
    
end

candy = Candy.new
candy.taste()
candy = Puthai.new
candy.taste()
candy = Changnoi.new
candy.taste()
