Rails.application.config.middleware.use OmniAuth::Builder do
   provider :facebook, '346465042117861', '1b343ec22e3591df454ca44fa6608597', {:scope => 'email'}
   provider :twitter, 'STh1hXgu4AnhSMgPSsP1UA', 'X5VD4YT9pQICjlpzdORnvbesij1Ro4yz9kVyh2Nlg'
   provider :linkedin, 'muh3vc5p2rlw', 'WNPnOxdQFqbIDnci'
end