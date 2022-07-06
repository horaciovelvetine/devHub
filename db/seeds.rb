quebert = Quebert::Bot.create!(id: ENV['CLIENT_ID'])
cronfig = Quebert::Cronfig.new

cronfig.bot_id = quebert
quebert.cronfig = cronfig
