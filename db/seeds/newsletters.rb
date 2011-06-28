User.find(:all).each do |user|
  if user.plugins.find_by_name('newsletters').nil?
    user.plugins.create(:name => 'newsletters',
                        :position => (user.plugins.maximum(:position) || -1) +1)
  end
end
RefinerySetting.find_or_set(:email, '', :scoping => 'newsletters')