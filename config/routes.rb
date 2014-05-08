LanguageLesson::Application.routes.draw do
  resources :page_elements

  resources :content_blocks

  resources :pages

  resources :answers

  resources :questions
  resources :prompted_audio_questions

  resources :lessons do
    resources :questions
  end

  resources :courses

  resources :recordings do
    member do
      post :receive
    end
  end

  resources :lesson_attempts do
    resources :question_attempts
  end

  namespace :lti do
    resources :courses
    resources :lessons
    resources :questions
    resources :prompted_audio_questions
    resources :lesson_attempts do
      resources :question_attempts
    end
    
    get 'start' => 'lti#start', :as => 'start_lti'
    get 'choose_lesson' => 'lti#choose_lesson', :as => 'choose_lesson'
    get 'start_lesson/(:lesson_id)' => 'lessons#start_lesson', :as => 'start_lesson'
    get 'lesson_attempts/start_attempt/(:lesson_id)' => 'lesson_attempts#start_attempt', :as => 'start_lesson_attempt'
    get 'lesson_attempts/show_page_element/(:lesson_attempt_id)/(:page_element_id)' => 'lesson_attempts#show_page_element', :as => 'show_lesson_attempt_page_element'
  end

  get '/home/backbone' => 'home#backbone'
  get '/home/test' => 'home#test'

  get '/backbone/lesson(/:id)' => 'backbone#lesson'

  root :to => "home#index"

  #match '/home/start_lti' => 'home#start_lti', :as => 'start_lti'
  #match '/home/choose_lesson' => 'home#choose_lesson', :as => 'choose_lesson'
end
