Rails.application.routes.draw do
  # ! QUEBERT
  scope module: 'quebert', path: 'api/quebert' do
    ## ALL Routines & Scheduled Tasks
    get 'post-routine', to: 'routines#que_routine'

    ## ALL Slash commands route through here
    get 'cronfig', to: 'commands#cronfig'
    post 'cronfig', to: 'commands#cronfig'
    post 'slash-command', to: 'commands#slash_command'
  end

  # ! THE_OREGON_TRAIL
  scope module: 'oregon_trail', path: 'api/oregon-trail' do
    resources :games
  end
end
