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

      pp new_element
      
      if new_element.is_a? PromptResponseAudioQuestion        
        if element[type]['prompt_audio']
          prompt_audio = new_element.build_prompt_audio
          prompt_audio.file = File.open( File.join(directory, element[type]['prompt_audio']) )
          prompt_audio.save
          pp prompt_audio
        end

        if element[type]['response_audio']
          response_audio = new_element.build_response_audio
          response_audio.file = File.open( File.join(directory, element[type]['response_audio']) )
          response_audio.save
          pp response_audio
        end
      elsif new_element.is_a? PromptedAudioQuestion        
        if element[type]['prompt_audio']
          prompt_audio = new_element.build_prompt_audio
          prompt_audio.file = File.open( File.join(directory, element[type]['prompt_audio']) )
          prompt_audio.save
          pp prompt_audio
        end
      else
        if element[type]['audio']
          recording = new_element.build_recording
          recording.file = File.open( File.join(directory, element[type]['audio']) )
          recording.save
          pp recording
        end
      end
    end
  end
end
