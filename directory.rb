@students = []

def print_header
  
  puts "The students of Villains Academy".center(100)
  puts "-------------".center(100)
  
end

def print_students_list
  
  sorted = {}
  
  # Sort by cohort.
  @students.each do |student|
   
    if !sorted.key?(student[:cohort])
      sorted[student[:cohort]] = [student[:name]]
    else
      sorted[student[:cohort]].push(student[:name])
    end
    
  end
  
  sorted.each do |k, v|
    
    puts k.to_s.center(100)
    v.each_with_index { |e, i| puts "#{i + 1}. #{e}".center(100) }
    
  end

end

def print_footer
  
  if @students.count == 0
    puts "We have no students".center(100) if @students.count == 0
  else
    puts "Overall, we have #{@students.count} great students".center(100) 
  end
  
end

def input_students
  
  puts "To finish, just hit return twice"
  # create an empty array

  loop do
    
    puts "Please enter the names of the students"
    name = gets.chomp.capitalize.to_sym
    break if name == :""
    puts "Enter a cohort"
    cohort = gets.chomp.capitalize.to_sym
    cohort = :"September" if cohort == :""
    @students << {
    name: name, 
    cohort: cohort, 
    }
    
    if @students.count == 1
      puts "Now we have 1 student"
    else
      puts "Now we have #{@students.count} students"
    end
    
  end
  
end

def interactive_menu 
  loop do
    
    print_menu
    process(gets.chomp)
	
  end
  
end

def print_menu 

    puts "1. Input the students"
    puts "2. Show the students"
    puts "3. Save students file: Students.csv"
    puts "4. Load students file: Students.csv"
    puts "9. Exit" 
  
end

def show_students
  
  print_header
  print_students_list
  print_footer
  
end

def process(selection)
  
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit
  else
    puts "I don't know what you meant, try again."
  end
  
end

def save_students
  
  # open the file for writing
  file = File.open("students.csv", "w")
  #itierate over the array of students
  @students.each do |student|
    
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
    
  end
  
  puts "Saved students.csv!"
  file.close
  
end

def load_students
  
  file = File.open("students.csv", "r")
  file.readlines.each do |line|
  
    name, cohort = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym}
  
  end
  
  puts "Loaded students.csv!"
  file.close
  
end

interactive_menu