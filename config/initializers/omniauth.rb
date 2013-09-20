Rails.application.config.middleware.use OmniAuth::Builder do
   provider :facebook, '346465042117861', '1b343ec22e3591df454ca44fa6608597', {:scope => 'publish_stream,offline_access,email,contact_email'}
   provider :twitter, 'STh1hXgu4AnhSMgPSsP1UA', 'X5VD4YT9pQICjlpzdORnvbesij1Ro4yz9kVyh2Nlg'
   provider :linkedin, 'muh3vc5p2rlw', 'WNPnOxdQFqbIDnci', :scope => 'r_fullprofile r_emailaddress r_network w_messages', :fields => ["id", "email-address", "last-name", "headline", "industry", "picture-url", "public-profile-url", "location", "connections"]
end