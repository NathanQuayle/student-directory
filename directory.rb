require 'csv'

@students = []

def print_header
  
  puts "The students of Villains Academy".center(100)
  puts "-------------".center(100)
  
end

def print_students_list
  
  sorted = sort_by_cohort
  
  sorted.each do |k, v|
    
    puts k.to_s.center(100)
    v.each_with_index { |e, i| puts "#{i + 1}. #{e}".center(100) }
    
  end

end

def sort_by_cohort
  
  sorted = {}
  
  # Sort by cohort.
  @students.each do |student|
   
    if !sorted.key?(student[:cohort])
      sorted[student[:cohort]] = [student[:name]]
    else
      sorted[student[:cohort]].push(student[:name])
    end
    
  end
  
  sorted
  
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

  loop do
    
    puts "Please enter the names of the students"
    name = STDIN.gets.chomp.capitalize
    break if name == ""
    
    puts "Enter a cohort"
    cohort = STDIN.gets.chomp.capitalize.to_sym
    cohort = :"September" if cohort == :""
    push_students(name, cohort)
    
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
    process(STDIN.gets.chomp)
	
  end
  
end

def print_menu 

  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save students file"
  puts "4. Load students file"
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
    puts "Goodbye!"
    exit
  else
    puts "I don't know what you meant, try again."
  end
  
end

def save_students
  
  puts "Enter a filename  to save to: "
  filename = gets.chomp
  
  # open the file for writing
  CSV.open(filename, "w") do |csv|
  
    #itierate over the array of students
    @students.each do |student|

      csv << [student[:name], student[:cohort]]
      
    end
    
  end
  
  puts "Saved students.csv!"
  
end

def try_load_students
  
  filename = ARGV.empty? ? "students.csv" : ARGV.first

  load_students(filename)
  
end

def load_students(filename = "")
  
  while !File.file?(filename) do
    puts "Enter a filename to load: "
    filename = gets.chomp
  end
  
  total_loaded = 0
  
  CSV.foreach(filename) do |row|
    
    name, cohort = row
    push_students(name, cohort)
    total_loaded += 1
  
  end
  
  puts "Loaded #{total_loaded} from #{filename}"
  
end

def push_students(name, cohort)
  
  @students << {
    name: name, 
    cohort: cohort.to_sym
  }
  
end

try_load_students 
interactive_menu