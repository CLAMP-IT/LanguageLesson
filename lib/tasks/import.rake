require 'json'

namespace :import do
  task :import_lesson, [:directory, :json_file] => :environment do |t, args|
    counter = 0
                                                  
    directory = args[:directory]

    infile = args[:json_file]

    puts directory
    puts infile

    hash = JSON.parse( File.read "#{directory}/#{infile}" )
    pp hash

    lesson = Lesson.create(name: hash['lesson']['name'], graded: hash['lesson']['graded'])
    
    pp lesson

    hash['lesson']['page_elements'].each do |element|
      type = element.first[0]
      pp element[type]
      
      new_element = eval(type.camelize).create(title: element[type]['title'], content: element[type]['content'])

      lesson_element = LessonElement.new(lesson: lesson)
      lesson_element.presentable = new_element
      lesson_element.save

      audio_file = File.open( File.join(directory, element[type]['audio']) )

      recording = Recording.new( file: audio_file )
      recording.recordable = new_element
      pp new_element
      pp recording

      recording.save

      #puts "TYPE: #{element.first[0]}"
      
                                   end
    
  end
end 
