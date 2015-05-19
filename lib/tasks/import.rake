require 'json'
require 'pp'

namespace :import do
  task :import_lesson, [:directory, :json_file] => :environment do |t, args|
    counter = 0
                                                  
    directory = args[:directory]

    infile = args[:json_file]

    puts "DIRECTORY: #{directory}"
    puts "JSON FILE: #{infile}"

    file_target = File.join( directory, infile )
    
    puts file_target

    hash = JSON.parse( File.read file_target )

    lesson = Lesson.create(name: hash['lesson']['name'].gsub(/_/, ' '), 
                           graded: hash['lesson']['graded'])
    
    hash['lesson']['page_elements'].each do |element|
      type = element.first[0]
      
      new_element = eval(type.camelize).create(title: element[type]['title'], content: element[type]['content'])

      lesson_element = LessonElement.new(lesson: lesson)
      lesson_element.presentable = new_element
      lesson_element.save

      if element[type]['audio']
        audio_file = File.open( File.join(directory, element[type]['audio']) )

        recording = Recording.new( file: audio_file )
        recording.recordable = new_element
        pp recording
        
        puts recording.save
      end
    end
  end
end 
