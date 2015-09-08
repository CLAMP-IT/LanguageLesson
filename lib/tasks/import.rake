require 'json'
require 'pp'

namespace :import do
  task :import_lesson, [:directory, :json_file, :language_name] => :environment do |t, args|
    counter = 0
                                                  
    directory = args[:directory]

    infile = args[:json_file]

    puts "DIRECTORY: #{directory}"
    puts "JSON FILE: #{infile}"

    file_target = File.join( directory, infile )
    
    puts file_target

    hash = JSON.parse( File.read file_target )

    lesson = Lesson.create(name: hash['lesson']['name'].gsub(/_/, ' '), 
                           graded: hash['lesson']['graded'],
                           language: Language.find_by_name(args[:language_name]))
    
    hash['lesson']['page_elements'].each do |element|
      type = element.first[0]

      unless type == 'branch_table' || type == 'end_branch' 
        new_element = eval(type.camelize).create(title: element[type]['title'], content: element[type]['content'])

        lesson_element = LessonElement.new(lesson: lesson)
        lesson_element.presentable = new_element
        lesson_element.save
        
        pp new_element
      
        if new_element.is_a? PromptResponseAudioQuestion        
          if element[type]['prompt_audio']
            prompt_audio = new_element.build_prompt_audio

            file = File.open( File.join(directory, element[type]['prompt_audio']) )

            filename = File.basename(element[type]['prompt_audio'])
            
            uuid = SecureRandom.uuid
            uuid_path = "#{uuid[0,2]}/#{uuid[2,2]}/#{uuid}"

            prompt_audio = new_element.build_prompt_audio
            prompt_audio.bucket_name = S3_BUCKET.name
            prompt_audio.uuid = uuid
            prompt_audio.url = "recordings/#{uuid_path}/#{filename}"
            prompt_audio.file_size = file.size

            obj = S3_BUCKET.objects[prompt_audio.url].write(file: file, acl: :public_read)
            
            prompt_audio.save

            pp prompt_audio
          end

          if element[type]['response_audio']
            response_audio = new_element.build_response_audio

            file = File.open( File.join(directory, element[type]['response_audio']) )

            filename = File.basename(element[type]['response_audio'])

            uuid = SecureRandom.uuid
            uuid_path = "#{uuid[0,2]}/#{uuid[2,2]}/#{uuid}"
            
            response_audio = new_element.build_response_audio
            response_audio.bucket_name = S3_BUCKET.name
            response_audio.uuid = uuid
            response_audio.url = "recordings/#{uuid_path}/#{filename}"
            response_audio.file_size = file.size

            obj = S3_BUCKET.objects[response_audio.url].write(file: file, acl: :public_read)
            
            response_audio.save

            pp response_audio
          end
        elsif new_element.is_a? PromptedAudioQuestion        
          if element[type]['prompt_audio']
            file = File.open( File.join(directory, element[type]['prompt_audio']) )

            filename = File.basename(element[type]['prompt_audio'])
            
            uuid = SecureRandom.uuid
            uuid_path = "#{uuid[0,2]}/#{uuid[2,2]}/#{uuid}"
            
            prompt_audio = new_element.build_prompt_audio
            prompt_audio.bucket_name = S3_BUCKET.name
            prompt_audio.uuid = uuid
            prompt_audio.url = "recordings/#{uuid_path}/#{filename}"
            prompt_audio.file_size = file.size

            obj = S3_BUCKET.objects[prompt_audio.url].write(file: file, acl: :public_read)

            prompt_audio.save
            
            pp prompt_audio
          end
        else
          if element[type]['audio']
            file = File.open( File.join(directory, element[type]['audio']) )
            filename = File.basename(element[type]['audio'])

            uuid = SecureRandom.uuid
            uuid_path = "#{uuid[0,2]}/#{uuid[2,2]}/#{uuid}"
            
            recording = new_element.build_recording
            recording.bucket_name = S3_BUCKET.name
            recording.uuid = uuid
            recording.url = "recordings/#{uuid_path}/#{filename}"
            recording.file_size = file.size

            obj = S3_BUCKET.objects[recording.url].write(file: file, acl: :public_read)
            
            recording.save

            pp recording
          end
        end
      end
    end
  end
end
