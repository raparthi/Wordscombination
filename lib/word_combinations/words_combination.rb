class WordCombination
  attr_accessor :dictionary, :mat
  def initialize
    hash = ('a'..'z').each_with_index.map { |x,i| [x.to_sym, (i/3)+2]}.to_h
    hash[:s] = 7
    hash[:v] = 8
    hash[:y] = 9
    hash[:z] = 9
    @dictionary = []
    File.read("/Users/balakishore/Workspace/word_combinations/lib/word_combinations/dictionary.txt").each_line do |line|
      @dictionary << { line.strip.split("").map { |k| hash[k.downcase.to_sym] }.join => line.strip }
    end
    @mat = [[3,3,4],[3,4,3],[4,3,3],[4,6,0],[5,5,0],[6,4,0],[7,3,0],[3,7,0],[10,0,0]]
  end

  def get_words(ph)
    return "Invalid phone number" if validate_phone_number(ph)
    result = []
    mat.each do |a|
      init_arr = find_sub_str(0, a[0], ph)
      init_arr.each { |elem| result << elem.downcase if elem.size >= 10 } if init_arr
      middle_arr = find_sub_str(a[0], (a[1]+a[0]), ph) if a[1] !=0
      result_init_mid = init_arr.map { |k| middle_arr.map {|v| (k + "," + v) }}.flatten if middle_arr
      result_init_mid.each { |elem| result << elem.downcase if elem.size >= 10} if result_init_mid
      rear_arr = find_sub_str((a[1]+a[0]), a[0]+a[1]+a[2], ph) if a[2] != 0
      result << result_init_mid.map { |k| rear_arr.map {|v| (k + "," + v).downcase  }  }.flatten if rear_arr
    end
    result.flatten.sort_by { |r| r.size }
  end

  private
  def find_sub_str(init, rear, ph)
    dictionary.find_all{|e| e[ph.slice(init...rear)] }.map{ |k| k.values }.flatten
  end

  def validate_phone_number(ph)
    ph.include?('0') ||  ph.include?('1')
  end
end

